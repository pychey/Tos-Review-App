import 'dotenv/config';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';
import * as bcrypt from 'bcrypt';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('Seeding...');

  // Users
  const hashedPassword = await bcrypt.hash('password123', 10);
  const users = await Promise.all(
    Array.from({ length: 10 }, (_, i) =>
      prisma.user.upsert({
        where: { email: `user${i + 1}@example.com` },
        update: {},
        create: {
          email: `user${i + 1}@example.com`,
          name: `User ${i + 1}`,
          hashedPassword,
          provider: 'LOCAL',
          bio: `Bio of user ${i + 1}`,
        },
      }),
    ),
  );
  console.log('Users seeded');

  // Posts
  const categories = ['FOOD', 'BEAUTY', 'OTHER'] as const;
  const posts = await Promise.all(
    Array.from({ length: 30 }, (_, i) =>
      prisma.post.create({
        data: {
          authorId: users[i % 10].id,
          productName: `Product ${i + 1}`,
          description: `This is a review of product ${i + 1}`,
          authorRating: parseFloat((Math.random() * 4 + 1).toFixed(1)),
          category: categories[i % 3],
          price: parseFloat((Math.random() * 100 + 5).toFixed(2)),
          location: ['Phnom Penh', 'Tokyo', 'Seoul', 'Singapore'][i % 4],
          mediaUrls: [],
        },
      }),
    ),
  );
  console.log('Posts seeded');

  // Follows
  await Promise.all(
    users.flatMap((user, i) =>
      [1, 2, 3].map((offset) =>
        prisma.follow.upsert({
          where: {
            followerId_followingId: {
              followerId: user.id,
              followingId: users[(i + offset) % 10].id,
            },
          },
          update: {},
          create: {
            followerId: user.id,
            followingId: users[(i + offset) % 10].id,
          },
        }),
      ),
    ),
  );
  console.log('Follows seeded');

  // Likes
  await Promise.all(
    posts.flatMap((post, i) =>
      [0, 1, 2].map((offset) =>
        prisma.like.upsert({
          where: {
            postId_userId: {
              postId: post.id,
              userId: users[(i + offset) % 10].id,
            },
          },
          update: {},
          create: {
            postId: post.id,
            userId: users[(i + offset) % 10].id,
          },
        }),
      ),
    ),
  );
  console.log('Likes seeded');

  // Ratings
  await Promise.all(
    posts.flatMap((post, i) =>
      [1, 2].map((offset) =>
        prisma.rating.upsert({
          where: {
            postId_userId: {
              postId: post.id,
              userId: users[(i + offset) % 10].id,
            },
          },
          update: {},
          create: {
            postId: post.id,
            userId: users[(i + offset) % 10].id,
            value: parseFloat((Math.random() * 4 + 1).toFixed(1)),
          },
        }),
      ),
    ),
  );
  console.log('Ratings seeded');

  // Comments
  const comments = await Promise.all(
    posts.flatMap((post, i) =>
      [0, 1].map((offset) =>
        prisma.comment.create({
          data: {
            postId: post.id,
            authorId: users[(i + offset) % 10].id,
            content: `Comment ${offset + 1} on post ${i + 1}`,
          },
        }),
      ),
    ),
  );
  console.log('Comments seeded');

  // Comment Likes
  await Promise.all(
    comments.flatMap((comment, i) =>
      prisma.commentLike.upsert({
        where: {
          commentId_userId: {
            commentId: comment.id,
            userId: users[(i + 1) % 10].id,
          },
        },
        update: {},
        create: {
          commentId: comment.id,
          userId: users[(i + 1) % 10].id,
        },
      }),
    ),
  );
  console.log('Comment likes seeded');

  // Saves
  await Promise.all(
    posts.flatMap((post, i) =>
      prisma.save.upsert({
        where: {
          postId_userId: {
            postId: post.id,
            userId: users[(i + 3) % 10].id,
          },
        },
        update: {},
        create: {
          postId: post.id,
          userId: users[(i + 3) % 10].id,
        },
      }),
    ),
  );
  console.log('Saves seeded');

  console.log('Done!');
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