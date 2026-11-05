# Daily Sales Management App

Flutter mobile application with Node.js backend for managing daily shop sales.

## Project Structure

- `mobile/` — Flutter application
- `backend/` — Node.js API (Express + Prisma + SQLite)

## Requirements

- Flutter SDK (3.47+)
- Dart SDK (3.13+)
- Node.js (18+) and npm
- Android Studio (for Android builds)

## Local Development

### Backend

```bash
cd backend
cp .env.example .env   # Windows: copy .env.example .env
npm install
npx prisma migrate dev
npm run dev
```

API base URL: `http://localhost:3000/api/v1`

### Mobile

```bash
cd mobile
flutter pub get
flutter run
```

> Android emulator reaches the host backend via `http://10.0.2.2:3000/api/v1`.
> iOS simulator uses `http://localhost:3000/api/v1` (update `ApiConstants.baseUrl`).

## Database

SQLite via Prisma ORM. The dev database file is `backend/prisma/dev.db` (gitignored).

## Tests

Backend:
```bash
cd backend
npm test
```

Mobile:
```bash
cd mobile
flutter analyze
flutter test
```

## Features

Authentication, product management, sales recording (multi-item, discounts, profit), dashboard, daily/weekly/monthly reports, expense tracking, settings.