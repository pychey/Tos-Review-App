# TosReview

A product review mobile app built with Flutter and NestJS. Users can post, rate, and review local and international products.

## Tech Stack

- **Frontend:** Flutter
- **Backend:** NestJS + Prisma + PostgreSQL
- **Storage:** Cloudinary
- **Auth:** JWT, Google OAuth

## Getting Started

### Prerequisites
- Node.js 18+
- Flutter SDK
- PostgreSQL

### Backend

```bash
cd server
cp .env.example .env       # fill in your env variables
npm install
npx prisma generate
npx prisma migrate dev
npx ts-node prisma/seed.ts # seed demo data
npm run start:dev
```

### Frontend

```bash
cd client
flutter pub get
flutter run
```

> Update `baseUrl` in `lib/services/api_client.dart` to your machine's IP.

## Demo Accounts

All accounts use password: `Demo@1234`

| Name | Email |
|------|-------|
| Sophea Meas | sophea@demo.com |
| Dara Keo | dara@demo.com |
| Sreymom Chan | sreymom@demo.com |
| Visal Noun | visal@demo.com |
| Bopha Ly | bopha@demo.com |
| Ratanak Pich | ratanak@demo.com |
| Channary Som | channary@demo.com |
| Menghour Ros | menghour@demo.com |

## Features

- Email & Google authentication
- Personalized feed with ad injection
- Post reviews with images, ratings, price and location
- Like, save, comment and rate posts
- Follow system
- Notifications
- Search with category filters
- Anonymous posting
- View history
- Report posts
- Admin panel