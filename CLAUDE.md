# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app (debug)
flutter run

# Run on specific device
flutter run -d ios
flutter run -d android
flutter run -d macos

# Build release
flutter build ios
flutter build apk
flutter build macos

# Analyze code
flutter analyze

# Run tests
flutter test

# Run single test file
flutter test test/widget_test.dart

# Code generation (after modifying Freezed models)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs
```

## Architecture

This is a Flutter app using a **feature-first architecture** with Riverpod for state management.

### Layer Structure (per feature)

```
features/{feature}/
├── controllers/     # StateNotifier controllers managing UI state
├── models/          # Freezed state classes (e.g., LoginState)
├── views/           # Screen widgets
├── widgets/         # Feature-specific widgets
├── utils/           # Feature-specific helpers/handlers
└── data/
    ├── data_sources/   # Firebase/API implementations
    ├── models/         # Freezed data models with Firestore serialization
    └── repositories/   # Abstract data access layer
```

### State Management Pattern

- **Riverpod providers** defined in `lib/core/providers/` for global state (auth, selected fridge, products)
- **Feature controllers** extend `StateNotifier<T>` where T is a Freezed state class
- Controllers are exposed via `StateNotifierProvider` defined at bottom of controller files
- Repositories abstract data sources and are injected into controllers

### Data Flow

1. Screens use `ConsumerWidget`/`ConsumerStatefulWidget` and `ref.watch()` for reactive state
2. User actions call controller methods via `ref.read(controllerProvider.notifier).method()`
3. Controllers update state, which triggers UI rebuild
4. Data persistence flows: Controller → Repository → DataSource → Firebase

### Routing

- GoRouter with declarative redirect logic in `lib/core/router/app_router.dart`
- Route constants in `lib/core/router/app_routes.dart`
- Redirect guards handle: unauthenticated users → login, authenticated without fridge → fridge selection

### Models with Freezed

Models use Freezed for immutability and code generation:
- Add `@freezed` annotation to class
- Define factory constructor with `const factory`
- Run `dart run build_runner build` to generate `.freezed.dart` and `.g.dart` files
- Firestore models have manual `toFirestore()` and `fromFirestore()` factory methods

### Firebase Structure

- **Authentication**: Firebase Auth with email/password
- **Firestore Collections**: `users`, `fridges`, `products`
- Products are filtered by `fridgeId` field, fridges by `memberIds` array containing user ID
