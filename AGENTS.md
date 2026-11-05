# Project: Daily Sales Management App

## Project Overview
Build a Daily Sales Management application.

The application allows users to:
- Manage products
- Record daily sales
- Calculate revenue and profit
- Track expenses
- View daily, weekly, and monthly reports
- View sales statistics on a dashboard

## Technology Stack

### Mobile
- Flutter
- Dart
- BLoC state management
- Feature-based Clean Architecture
- Dio for API requests

### Backend
- Node.js
- Express.js
- TypeScript
- Prisma ORM
- SQLite for local development
- Zod validation
- JWT authentication

## Architecture Rules

- Keep mobile and backend independent.
- Use REST API for communication.
- Follow Clean Architecture in Flutter.
- Use feature-based modules.
- Keep business logic out of UI widgets.
- Use BLoC for state management.
- Keep database operations inside backend repositories.
- Use DTOs for API requests and responses.
- Validate all backend inputs.
- Use environment variables for configuration.

## Business Rules

- Product has name, SKU, cost price, selling price and stock quantity.
- Sales can contain multiple products.
- Each sale item stores product name and price snapshots.
- Calculate total revenue from sale items.
- Calculate profit using cost price snapshots.
- Support discounts.
- Track expenses separately.
- Allow sales history filtering by date.
- Store timestamps consistently.

## Development Rules

- Windows is the primary development environment.
- Backend must run locally without a cloud server.
- Use SQLite for local testing.
- Never hardcode secrets.
- Never commit .env files.
- Provide .env.example.
- Write clean, maintainable, reusable code.
- Add error handling and loading states.
- Write tests for important business logic.
- Update README.md when setup instructions change.

## AI Coding Agent Rules

1. Inspect existing project structure before modifying files.
2. Never delete existing files without permission.
3. Do not recreate an existing Flutter or Node.js project.
4. Explain the implementation plan before major changes.
5. Work in small, testable phases.
6. Run relevant tests after implementation.
7. Fix errors before moving to the next phase.
8. Do not implement unnecessary features.
9. Ask before introducing additional technologies.
10. Report modified files and commands to run.
