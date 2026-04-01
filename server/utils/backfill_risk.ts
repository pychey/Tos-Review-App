import 'dotenv/config';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';
import axios from 'axios';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  const posts = await prisma.post.findMany({
    where: { riskLevel: null },
    include: {
      author: {
        select: {
          createdAt: true,
          _count: { select: { posts: true } },
        },
      },
    },
  });

  console.log(`Found ${posts.length} posts to backfill...`);

  for (const post of posts) {
    try {
      const accountAgeInDays =
        (Date.now() - new Date(post.author.createdAt).getTime()) /
        (1000 * 60 * 60 * 24);

      const response = await axios.post('http://localhost:8000/predict', {
        text: post.description,
        rating: post.authorRating,
        review_count: post.author._count.posts,
        account_age: accountAgeInDays,
      });

      const { risk_level, confidence, explanation, signals } = response.data;

      await prisma.post.update({
        where: { id: post.id },
        data: {
          riskLevel: risk_level,
          riskConfidence: confidence,
          riskReason: explanation,
          riskRules: signals?.applied_rules ?? [],
        },
      });

      console.log(`✓ ${post.productName} → ${risk_level} (${(confidence * 100).toFixed(0)}%)`);
    } catch (e) {
      console.error(`✗ ${post.productName} → ${e.message}`);
    }
  }

  console.log('\nDone!');
}

main()
  .then(async () => {
    await prisma.$disconnect();
    await pool.end();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    await pool.end();
    process.exit(1);
  });