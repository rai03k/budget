# CLAUDE.md
日本語で全て回答してください。
またアーキテクチャはMVVMとriverpod_annotation、freezedを使用してください。
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Flutter Commands
```bash
# Build the app
flutter build apk              # Android APK
flutter build ios             # iOS build
flutter build web             # Web build

# Run the app
flutter run                    # Run on connected device
flutter run -d chrome         # Run on Chrome (web)
flutter run --release         # Run in release mode

# Development
flutter pub get               # Install dependencies
flutter pub upgrade           # Update dependencies
flutter analyze              # Analyze code for issues
flutter test                 # Run tests

# Code Generation (Required after model/provider changes)
flutter packages pub run build_runner build        # Generate code once
flutter packages pub run build_runner watch        # Watch for changes
flutter packages pub run build_runner build --delete-conflicting-outputs  # Clean rebuild
```

### Firebase Commands (from functions/ directory)
```bash
# Firebase Functions
npm run serve                 # Start local emulator
npm run deploy               # Deploy to Firebase
npm run logs                 # View function logs
```

## Project Architecture

This is a Flutter budget tracking app using **Clean Architecture** with **MVVM pattern** and **Riverpod** state management.

### Core Architecture Layers

1. **Data Layer** (`lib/data/`): Drift SQL database with table definitions and DAOs
2. **Domain Layer** (`lib/domain/`): Business logic models using Freezed for immutability
3. **Service Layer** (`lib/service/`): IsarService (NoSQL) and ReceiptAnalysisService (AI)
4. **Repository Layer** (`lib/repository/`): Data access abstraction
5. **Provider Layer** (`lib/provider/`): Riverpod providers with code generation
6. **Presentation Layer** (`lib/views/`): MVVM with Page/State/ViewModel per feature

### Key Technologies

- **State Management**: Flutter Riverpod with `@riverpod` code generation
- **Navigation**: GoRouter with StatefulShellRoute for bottom navigation
- **Database**: Drift (SQL) with type-safe operations and generated DAOs
- **Code Generation**: Freezed for models, build_runner for providers/DAOs
- **AI Integration**: Firebase AI (Gemini 2.5) for receipt scanning
- **UI**: Custom themes, HugeIcons, Google Fonts, Flutter Animate

### Database Schema (Drift Tables)

- **BudgetTable**: Budget management with monthly/yearly periods
- **CategoryTable**: Expense categories with custom icons and colors  
- **TransactionTable**: Financial transactions linked to categories with foreign keys

### App Features

1. **Transaction Input**: Manual entry + AI-powered receipt scanning
2. **Budget Management**: Category-based budget allocation and tracking
3. **Calendar View**: Date-based transaction visualization
4. **Category Management**: Create/edit categories with custom icons/colors
5. **Savings Tracking**: Goal tracking with progress visualization
6. **Weekly Review**: Expense analysis and insights
7. **Settings**: App configuration and preferences

### Important Development Notes

- **Code Generation Required**: After modifying models, providers, or database schemas, run `flutter packages pub run build_runner build`
- **State Pattern**: All state classes use `@freezed` for immutability
- **Navigation**: Use `AppRoutes` constants for route management
- **Database**: Uses Drift (SQL) database with generated DAOs and repositories
- **Localization**: Japanese locale initialized in main.dart (`ja_JP`)
- **Firebase**: App uses Firebase Core, AI services configured in `firebase_options.dart`
- **Database Migration**: Successfully migrated from Isar (NoSQL) to Drift (SQL)

### Testing

- Test files located in `test/` directory
- Run tests with `flutter test`
- Widget tests for UI components
- Unit tests for business logic

### Build Configuration

- **Android**: Gradle build files in `android/`, minSdk determined by Flutter
- **iOS**: Xcode project in `ios/`, uses CocoaPods for dependencies
- **Web**: Build artifacts in `web/`
- **Firebase**: Firestore rules in `firestore.rules`, functions in `functions/`