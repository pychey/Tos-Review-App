import 'dotenv/config';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';
import * as bcrypt from 'bcrypt';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

const userData = [
  { name: 'Sophea Meas',   email: 'sophea@demo.com',   profileSrc: 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=200&h=200&fit=crop', role: 'ADMIN' as const },
  { name: 'Dara Keo',      email: 'dara@demo.com',     profileSrc: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop' },
  { name: 'Sreymom Chan',  email: 'sreymom@demo.com',  profileSrc: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop' },
  { name: 'Visal Noun',    email: 'visal@demo.com',    profileSrc: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop' },
  { name: 'Bopha Ly',      email: 'bopha@demo.com',    profileSrc: 'https://images.unsplash.com/photo-1554151228-14d9def656e4?w=200&h=200&fit=crop' },
  { name: 'Ratanak Pich',  email: 'ratanak@demo.com',  profileSrc: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop' },
  { name: 'Channary Som',  email: 'channary@demo.com', profileSrc: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop' },
  { name: 'Menghour Ros',  email: 'menghour@demo.com', profileSrc: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop' },
];

const postData = [
  // ── KHMER FOOD ───────────────────────────────────────────
  {
    productName: 'Khmer Rice Noodle (Num Banh Chok)',
    description: 'The most iconic Khmer breakfast. Fresh rice noodles with green fish-based curry sauce, topped with fresh vegetables and herbs. Found this at Phsar Thmei market and it blew my mind. Authentic taste, very affordable and filling. Highly recommend for anyone visiting Phnom Penh.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 1.50,
    location: 'Phsar Thmei, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1555126634-323283e090fa?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 0,
  },
  {
    productName: 'Lok Lak (Khmer Beef Stir Fry)',
    description: 'Classic Cambodian beef stir fry served on a bed of lettuce with a tangy lime pepper dipping sauce. The beef was perfectly tender and the sauce was incredible. This version from a local restaurant in BKK1 was the best I have had. Great for lunch or dinner.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 6.00,
    location: 'BKK1, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 1,
  },
  {
    productName: 'Amok Trey (Fish Amok)',
    description: 'Cambodia\'s national dish. Steamed fish curry in coconut milk with kroeung paste, served in a banana leaf bowl. This one from a restaurant in Siem Reap was creamy, aromatic and perfectly balanced. Must try for tourists and locals alike.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 7.50,
    location: 'Siem Reap',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1547592180-85f173990554?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 2,
  },
  {
    productName: 'Bai Sach Chrouk (Pork and Rice)',
    description: 'Simple but incredibly satisfying Khmer breakfast. Grilled marinated pork over broken rice with pickled vegetables and clear broth. This stall near Wat Phnom opens at 6am and always has a queue. Worth every minute of waiting.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 2.00,
    location: 'Wat Phnom, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 3,
  },
  {
    productName: 'Kuy Teav (Cambodian Noodle Soup)',
    description: 'Hearty pork or beef broth noodle soup loaded with bean sprouts, spring onions and your choice of meat. Found this gem in Toul Tompoung market. The broth was rich and clear, the noodles perfectly cooked. Best eaten early morning.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 2.50,
    location: 'Toul Tompoung, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 4,
  },
  {
    productName: 'Nom Pang (Cambodian Baguette Sandwich)',
    description: 'Cambodian take on the French baguette. Stuffed with pate, various meats, pickled vegetables and fresh herbs. The street stall near Royal Palace does it perfectly. Crispy outside, soft inside. Only $1 and extremely filling.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 1.00,
    location: 'Royal Palace, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 5,
  },
  {
    productName: 'Samlor Korko (Khmer Stirring Soup)',
    description: 'Traditional Cambodian vegetable and meat soup made with roasted ground rice and kroeung. One of the oldest Khmer dishes. This homestyle version was incredibly comforting and nutritious. Perfect for a rainy day.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 4.00,
    location: 'Daun Penh, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1547592180-85f173990554?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1534939561126-855b8675edd7?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 6,
  },
  {
    productName: 'Khmer Mango Sticky Rice',
    description: 'Sweet ripe mango served over glutinous sticky rice with rich coconut cream. Simple but absolutely divine. Found at a dessert stall in Orussey Market. The mango was perfectly ripe and the coconut cream was thick and fragrant.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 2.00,
    location: 'Orussey Market, Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1561043433-aaf687c4cf04?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 7,
  },

  // ── KHMER BEAUTY ─────────────────────────────────────────
  {
    productName: 'Sarika Cambodian Herbal Soap',
    description: 'All natural handmade soap using traditional Khmer herbal recipes. Made with turmeric, lemongrass and coconut oil. My skin felt so soft after just one week of use. No harsh chemicals and very affordable. Proud to support a local Cambodian brand.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 3.50,
    location: 'Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1607006344380-b6775a0824a7?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 0,
  },
  {
    productName: 'Cambodian Jasmine Coconut Body Oil',
    description: 'Traditional Khmer beauty secret. Pure coconut oil infused with jasmine flowers. Leaves skin glowing and deeply moisturized. My grandmother used this recipe for years and I finally found a brand that captures it perfectly. Great for dry skin in the Cambodian heat.',
    authorRating: 4,
    category: 'BEAUTY' as const,
    price: 8.00,
    location: 'Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1617897903246-719242758050?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 2,
  },

  // ── KOREAN FOOD ──────────────────────────────────────────
  {
    productName: 'Shin Ramyun (신라면)',
    description: 'The king of Korean instant noodles. Spicy beef broth with chewy noodles. I add an egg and some green onions and it becomes a proper meal. Available at most supermarkets in Phnom Penh now. Consistent quality every single time.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 1.20,
    location: 'Phnom Penh',
    productUrl: 'https://www.nongshim.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 1,
  },
  {
    productName: 'Bibigo Korean Dumplings (Mandu)',
    description: 'Frozen Korean dumplings filled with pork and vegetables. Pan fried until crispy on the outside and juicy inside. So easy to make and tastes restaurant quality. Found these at the Korean mart near Aeon Mall. Perfect snack or side dish.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 5.50,
    location: 'Phnom Penh',
    productUrl: 'https://www.bibigo.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 3,
  },
  {
    productName: 'Samyang Buldak Fire Noodles (불닭볶음면)',
    description: 'The famous Korean fire noodles challenge. These are genuinely very spicy but insanely addictive. I tried the original flavor and it had me sweating but I finished the whole thing. The chewy noodles and savory spicy sauce is unlike anything else. Not for the faint hearted.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 1.50,
    location: 'Phnom Penh',
    productUrl: 'https://www.samyangfoods.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 4,
  },
  {
    productName: 'Lotte Pepero Chocolate Sticks',
    description: 'Thin biscuit sticks dipped in chocolate. Light, crispy and not too sweet. Great for sharing and comes in many flavors. The almond chocolate version is my absolute favorite. Very popular in Cambodia now and easy to find at any convenience store.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 2.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.lotte.co.kr',
    mediaUrls: [
      'https://images.unsplash.com/photo-1481391319762-47dff72954d9?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1481391319762-47dff72954d9?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 5,
  },
  {
    productName: 'Ottogi Jin Ramen (오뚜기 진라면)',
    description: 'Milder and more savory alternative to Shin Ramyun. The broth is rich and comforting without being overwhelmingly spicy. Great for those who want Korean ramen flavor without the heat. I prefer this for late night meals.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 1.20,
    location: 'Phnom Penh',
    productUrl: 'https://www.ottogi.co.kr',
    mediaUrls: [
      'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 6,
  },

  // ── KOREAN BEAUTY ────────────────────────────────────────
  {
    productName: 'COSRX Advanced Snail 96 Mucin Power Essence',
    description: 'This snail mucin essence changed my skincare routine completely. Deeply hydrating and helps with redness and acne scars. I noticed visible improvement in skin texture after just 2 weeks. A little goes a long way so the bottle lasts for months. Worth every penny.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 25.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.cosrx.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1570194065650-d99fb4b38b47?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 0,
  },
  {
    productName: 'Some By Mi AHA BHA PHA 30 Days Miracle Toner',
    description: 'Transformed my acne prone skin in 30 days. This toner gently exfoliates, unclogs pores and brightens skin tone. I used to have constant breakouts and this product has reduced them significantly. Best Korean skincare product I have ever tried.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 18.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.somebymi.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 2,
  },
  {
    productName: 'Innisfree Green Tea Seed Serum',
    description: 'Lightweight serum packed with Jeju green tea extract. Provides intense moisture without feeling heavy or greasy. Perfect for humid Cambodian weather. My skin stays hydrated all day and looks plump and healthy. One of the best hydrating serums at this price point.',
    authorRating: 4,
    category: 'BEAUTY' as const,
    price: 22.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.innisfree.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 4,
  },
  {
    productName: 'Etude House Soon Jung Panthenol Soothing Gel',
    description: 'A lifesaver for sensitive and irritated skin. This gel calms redness and soothes skin after sun exposure. Super lightweight and absorbs instantly. I use it after every beach trip and it prevents peeling. Great for all skin types especially sensitive skin.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 15.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.etudehouse.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 6,
  },
  {
    productName: 'Laneige Lip Sleeping Mask',
    description: 'The hype around this product is completely justified. Wake up with incredibly soft and hydrated lips. The berry scent is delightful. I have been using it every night for 3 months and my dry lip problem is completely gone. A must have in any skincare routine.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 24.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.laneige.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 1,
  },
  {
    productName: 'Missha Time Revolution First Treatment Essence',
    description: 'Premium Korean essence with fermented yeast extract. Improves skin texture and gives a natural glow. This is my holy grail product. After one month my skin looks brighter and more even toned. Worth the splurge. Has replaced three other products in my routine.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 45.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.misshaus.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1570194065650-d99fb4b38b47?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 3,
  },

  // ── JAPANESE FOOD ────────────────────────────────────────
  {
    productName: 'Nissin Cup Noodle Original',
    description: 'The original instant cup noodle that started it all. Simple, satisfying and nostalgic. The seafood flavor is my go-to when I need a quick meal. Available everywhere in Phnom Penh at very affordable prices. A classic that never gets old.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 0.80,
    location: 'Phnom Penh',
    productUrl: 'https://www.nissin.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 5,
  },
  {
    productName: 'Pocky Chocolate Biscuit Sticks',
    description: 'Iconic Japanese snack that everyone loves. Thin crunchy biscuit sticks covered in smooth chocolate. Perfect snack for sharing. The matcha flavor is exceptional and unique. My whole family loves these and we always keep a box at home.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 2.50,
    location: 'Phnom Penh',
    productUrl: 'https://www.glico.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1481391319762-47dff72954d9?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1511381939415-e44eef2c66fa?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 7,
  },
  {
    productName: 'Meiji Chocolate Bar',
    description: 'Premium Japanese milk chocolate that melts smoothly in your mouth. Not too sweet and incredibly creamy. The quality difference from regular chocolate is very noticeable. I started buying these as a treat for myself and now I cannot go back to other chocolates.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 3.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.meiji.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1481391319762-47dff72954d9?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1606312619070-d48b2a27f927?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 0,
  },
  {
    productName: 'Kewpie Japanese Mayonnaise',
    description: 'Japanese mayo is in a completely different league from regular mayo. Richer, creamier and slightly tangy from rice vinegar. Made with egg yolks only which gives it that deep yellow color. I put this on everything now. Completely ruined regular mayonnaise for me.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 4.50,
    location: 'Phnom Penh',
    productUrl: 'https://www.kewpie.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 2,
  },
  {
    productName: 'Calbee Shrimp Crackers (Kappa Ebisen)',
    description: 'Light and airy Japanese shrimp crackers with an addictive savory flavor. Once you open the bag you cannot stop eating. The shrimp taste is natural and not artificial at all. Perfect snack with drinks. Kids and adults both love these.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 2.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.calbee.co.jp',
    mediaUrls: [
      'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1555126634-323283e090fa?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 4,
  },
  {
    productName: 'Yakult Probiotic Drink',
    description: 'Small bottle with huge health benefits. Daily probiotic drink that improves gut health and digestion. I drink one every morning and have noticed better digestion and less bloating. Slightly sweet and tangy taste that is refreshing. Been drinking it for 6 months consistently.',
    authorRating: 5,
    category: 'FOOD' as const,
    price: 0.50,
    location: 'Phnom Penh',
    productUrl: 'https://www.yakult.co.jp',
    mediaUrls: [
      'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1534939561126-855b8675edd7?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 6,
  },
  {
    productName: 'Maruchan Seimen Ramen',
    description: 'Step up from regular instant noodles. The noodles have a fresh feel and the broth is much deeper in flavor. Soy sauce flavor is my favorite. Takes 3 minutes to make and tastes like proper ramen. Great value for the quality you get.',
    authorRating: 4,
    category: 'FOOD' as const,
    price: 1.80,
    location: 'Phnom Penh',
    productUrl: null,
    mediaUrls: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 1,
  },

  // ── JAPANESE BEAUTY ──────────────────────────────────────
  {
    productName: 'Hada Labo Gokujyun Hyaluronic Acid Lotion',
    description: 'Amazing Japanese',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 14.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.rohto.co.jp',
    mediaUrls: [
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 3,
  },
  {
    productName: 'Shiseido Anessa Perfect UV Sunscreen SPF 50+',
    description: 'The gold standard of sunscreens. Sweat proof, water resistant and leaves no white cast. Living in Cambodia the sun is brutal and this is the only sunscreen I trust. Lightweight and comfortable to wear all day. Worth every cent and I will never switch to another brand.',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 32.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.shiseido.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1607006344380-b6775a0824a7?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 5,
  },
  {
    productName: 'SK-II Facial Treatment Essence',
    description: 'Amazing',
    authorRating: 5,
    category: 'BEAUTY' as const,
    price: 180.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.sk-ii.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 7,
  },
  {
    productName: 'Biore UV Aqua Rich Watery Essence SPF 50',
    description: 'Best budget sunscreen you can find. Watery texture that absorbs instantly with zero white cast. So light you barely feel it on your skin. Reapply every 2 hours under the Cambodian sun and your skin will thank you. I buy 3 tubes at a time.',
    authorRating: 4,
    category: 'BEAUTY' as const,
    price: 12.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.kao.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1570194065650-d99fb4b38b47?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 1,
  },
  {
    productName: 'Curel Intensive Moisture Care Face Wash',
    description: 'Gentle Japanese face wash specifically designed for sensitive and dry skin. Does not strip moisture barrier like harsh cleansers. Skin feels clean but still soft and comfortable after washing. Dermatologist recommended and fragrance free. My sensitive skin has never been happier.',
    authorRating: 4,
    category: 'BEAUTY' as const,
    price: 16.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.kao.com/curel',
    mediaUrls: [
      'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 3,
  },

  // ── OTHER ────────────────────────────────────────────────
  {
    productName: 'Anker Soundcore Life Q30 Headphones',
    description: 'Excellent noise cancelling headphones at a mid range price. The ANC is surprisingly effective for the price. Battery lasts 40 hours with ANC off. Sound quality is warm and punchy, great for music and calls. Build quality feels premium. Best headphones under $80.',
    authorRating: 5,
    category: 'OTHER' as const,
    price: 75.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.anker.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 2,
  },
  {
    productName: 'Sony WH-1000XM5 Headphones',
    description: 'The best noise cancelling headphones money can buy. Crystal clear audio, industry leading ANC and incredibly comfortable for long wear. I use these on flights and in coffee shops. The call quality is exceptional. Premium price but justified by the premium experience.',
    authorRating: 5,
    category: 'OTHER' as const,
    price: 350.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.sony.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1546435770-a3e736e31eca?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 4,
  },
  {
    productName: 'Muji Portable Aroma Diffuser',
    description: 'Amazing Amazing',
    authorRating: 4,
    category: 'OTHER' as const,
    price: 28.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.muji.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 6,
  },
  {
    productName: 'Samsung Galaxy Buds2 Pro',
    description: 'Korean engineering at its best. Compact earbuds with impressive ANC and Hi-Fi audio. The fit is secure and comfortable for hours. Seamless connection with Samsung phones but works well with any device. Sound stage is surprisingly wide for earbuds this size.',
    authorRating: 4,
    category: 'OTHER' as const,
    price: 180.00,
    location: 'Phnom Penh',
    productUrl: 'https://www.samsung.com',
    mediaUrls: [
      'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400&h=400&fit=crop',
    ],
    isAnonymous: false,
    authorIndex: 0,
  },
];

const adData = [
  {
    title: 'Find Your Dream Property in Cambodia',
    description: 'Browse thousands of properties across Cambodia. Buy, sell or rent with ease.',
    imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=400&fit=crop',
    linkUrl: 'https://www.khmer24.com',
    brandName: 'Khmer24',
    brandLogo: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=100&h=100&fit=crop',
    status: 'ACTIVE' as const,
  },
  {
    title: 'Shop Korean Beauty at Best Prices',
    description: 'Authentic K-beauty products delivered to your door in Phnom Penh.',
    imageUrl: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=400&fit=crop',
    linkUrl: 'https://www.stylekorean.com',
    brandName: 'Style Korean',
    brandLogo: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=100&h=100&fit=crop',
    status: 'ACTIVE' as const,
  },
];

// ============================================================
// SEED SCRIPT
// ============================================================

async function main() {
  console.log('Clearing existing data...');
  await prisma.notification.deleteMany();
  await prisma.commentLike.deleteMany();
  await prisma.comment.deleteMany();
  await prisma.like.deleteMany();
  await prisma.save.deleteMany();
  await prisma.rating.deleteMany();
  await prisma.postView.deleteMany();
  await prisma.report.deleteMany();
  await prisma.follow.deleteMany();
  await prisma.userInterest.deleteMany();
  await prisma.post.deleteMany();
  await prisma.advertisement.deleteMany();
  await prisma.user.deleteMany();
  console.log('Cleared.');

  // Users
  const hashedPassword = await bcrypt.hash('Demo@1234', 10);

  const randomPastDate = (maxDaysAgo: number) => {
    const ms = Math.random() * maxDaysAgo * 24 * 60 * 60 * 1000;
    return new Date(Date.now() - ms);
  };

  const users = await Promise.all(
    userData.map((u) =>
      prisma.user.create({
        data: {
          email: u.email,
          name: u.name,
          hashedPassword,
          provider: 'LOCAL',
          profileSrc: u.profileSrc,
          bio: 'Love reviewing products and sharing honest opinions.',
          role: u.role ?? 'USER',
          createdAt: randomPastDate(14),
        },
      }),
    ),
  );
  
  console.log(`Created ${users.length} users`);

  // Posts
  const posts = await Promise.all(
    postData.map((p) => {
      const { authorIndex, ...rest } = p;
      return prisma.post.create({
        data: {
          ...rest,
          authorId: users[authorIndex].id,
        },
      });
    }),
  );
  console.log(`Created ${posts.length} posts`);

  // Follows — each user follows 3 others
  await Promise.all(
    users.flatMap((user, i) =>
      [1, 2, 3].map((offset) =>
        prisma.follow.create({
          data: {
            followerId: user.id,
            followingId: users[(i + offset) % users.length].id,
          },
        }),
      ),
    ),
  );
  console.log('Created follows');

  // Likes
  await Promise.all(
    posts.flatMap((post, i) =>
      [0, 1, 2].map((offset) =>
        prisma.like.create({
          data: {
            postId: post.id,
            userId: users[(i + offset) % users.length].id,
          },
        }),
      ),
    ),
  );
  console.log('Created likes');

  // Ratings
  await Promise.all(
    posts.flatMap((post, i) =>
      [1, 2, 3].map((offset) =>
        prisma.rating.create({
          data: {
            postId: post.id,
            userId: users[(i + offset) % users.length].id,
            value: parseFloat((Math.random() * 2 + 3).toFixed(1)),
          },
        }),
      ),
    ),
  );
  console.log('Created ratings');

  // Comments
  const commentTexts = [
    'Great review! This is exactly what I was looking for.',
    'I have been using this for a month now and totally agree with your review.',
    'Where did you buy this? I want to try it too.',
    'Thanks for the honest review. Very helpful!',
    'I tried this last week and had the same experience.',
    'Does this ship to Phnom Penh? Would love to try it.',
    'My favorite product too! Been using it for years.',
    'Good review but I think the price has gone up recently.',
  ];
  await Promise.all(
    posts.flatMap((post, i) =>
      [0, 1].map((offset) =>
        prisma.comment.create({
          data: {
            postId: post.id,
            authorId: users[(i + offset) % users.length].id,
            content: commentTexts[(i + offset) % commentTexts.length],
          },
        }),
      ),
    ),
  );
  console.log('Created comments');

  // Interests
  const interestList = ['Food', 'Skincare', 'Beauty', 'Technology', 'Fashion'];
  await Promise.all(
    users.flatMap((user, i) =>
      [0, 1, 2].map((offset) =>
        prisma.userInterest.create({
          data: {
            userId: user.id,
            interest: interestList[(i + offset) % interestList.length],
          },
        }),
      ),
    ),
  );
  console.log('Created interests');

  // Ads
  await Promise.all(adData.map((ad) => prisma.advertisement.create({ data: ad })));
  console.log(`Created ${adData.length} ads`);

  console.log('\nAll done! Demo credentials:');
  userData.forEach((u) => console.log(`  ${u.email} / Demo@1234`));
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