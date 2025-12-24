# Koders Test - Flutter Mobile App

A production-ready Flutter mobile application built with Clean Architecture, following best practices and industry standards.

## 📱 Features

- **Mock Authentication**: Email/password login with validation and session management
- **REST API Integration**: Consumes JSONPlaceholder API for posts data
- **List Screen**: Posts list with pull-to-refresh and pagination
- **Detail Screen**: Post details with navigation and data passing
- **State Management**: Loading, empty, and error states properly handled
- **Clean UI**: Responsive design with reusable widgets
- **Platform Support**: Android (ready now) and iOS (ready for macOS build)

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Shared utilities and configurations
│   ├── constants/          # App-wide constants
│   ├── di/                 # Dependency injection
│   ├── error/              # Error handling (Failures)
│   ├── theme/              # App themes
│   └── utils/              # Utility classes (Validators, Result)
│
├── data/                    # Data Layer
│   ├── datasources/        # Data sources (Remote & Local)
│   │   ├── local/         # Local storage (SharedPreferences)
│   │   └── remote/        # API calls (HTTP)
│   ├── models/             # Data models (extend entities)
│   └── repositories/       # Repository implementations
│
├── domain/                  # Domain Layer (Business Logic)
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces (abstractions)
│   └── usecases/           # Use cases (business logic)
│       ├── auth/           # Authentication use cases
│       └── posts/          # Posts use cases
│
└── presentation/            # Presentation Layer (UI)
    ├── providers/          # State management (Provider)
    ├── screens/            # UI screens
    └── widgets/            # Reusable UI components
```

### Architecture Principles

1. **Dependency Rule**: Dependencies point inward
   - Presentation → Domain ← Data
   - UI never calls APIs directly
   - Providers use use cases
   - Repositories are abstracted

2. **Separation of Concerns**:
   - **Domain**: Pure business logic, no dependencies on Flutter or external libraries
   - **Data**: Handles data sources (API, local storage), implements domain interfaces
   - **Presentation**: UI layer, depends on domain layer only

3. **Dependency Injection**: Centralized in `core/di/dependency_injection.dart`

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- Android Studio / VS Code with Flutter extensions
- For iOS: macOS with Xcode (for later iOS builds)

### Installation Steps

1. **Clone the repository** (if applicable) or navigate to the project directory

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Demo Credentials

For testing the authentication feature:
- **Email**: `user@example.com`
- **Password**: `password123`

## 📦 Dependencies

### Production Dependencies
- `flutter`: Flutter SDK
- `provider: ^6.1.1`: State management
- `http: ^1.2.0`: HTTP client for API calls
- `shared_preferences: ^2.2.2`: Local storage for session management
- `cupertino_icons: ^1.0.8`: iOS-style icons

### Development Dependencies
- `flutter_test`: Flutter testing framework
- `flutter_lints: ^5.0.0`: Linting rules

## 🎨 UI/UX Features

- **Material Design 3**: Modern, responsive UI
- **Dark Mode Support**: Automatic theme switching based on system preferences
- **Loading States**: Proper loading indicators during data fetching
- **Error Handling**: User-friendly error messages with retry options
- **Empty States**: Informative empty state widgets
- **Pull-to-Refresh**: Refresh posts list by pulling down
- **Pagination**: Automatic loading of more posts when scrolling
- **Navigation**: Smooth navigation between screens with proper data passing

## 🔐 Authentication Flow

1. **Login Screen**: User enters email and password
2. **Validation**: Client-side validation using `Validators` utility
3. **Mock Authentication**: Validates against mock credentials
4. **Session Management**: Stores auth token and user email in SharedPreferences
5. **Auto-login**: Checks authentication status on app startup
6. **Logout**: Clears session data and returns to login screen

## 📡 API Integration

The app consumes the **JSONPlaceholder** API:
- **Base URL**: `https://jsonplaceholder.typicode.com`
- **Endpoint**: `/posts`
- **Method**: GET

### API Features
- Proper error handling (network errors, server errors)
- Timeout handling (30 seconds)
- JSON parsing with proper model classes
- Client-side pagination

## 🧩 Key Components

### Use Cases
- `LoginUseCase`: Handles user authentication with validation
- `LogoutUseCase`: Handles user logout
- `GetCurrentUserUseCase`: Retrieves current logged-in user
- `GetPostsUseCase`: Fetches posts with pagination
- `GetPostByIdUseCase`: Fetches a single post by ID

### Providers
- `AuthProvider`: Manages authentication state
- `PostProvider`: Manages posts state with pagination

### Reusable Widgets
- `LoadingWidget`: Loading indicator with optional message
- `ErrorDisplayWidget`: Error display with retry button
- `EmptyWidget`: Empty state display
- `PostCard`: Reusable post card widget

## 🧪 Testing

To run tests:
```bash
flutter test
```

## 📱 Platform Support

### Android
- ✅ Fully supported and tested
- Minimum SDK: As per Flutter defaults
- Ready to build and run

### iOS
- ✅ Code is iOS-safe (no platform-specific hacks)
- ⚠️ Requires macOS for building
- All code is ready; just needs to be built on macOS

## 🏃 Running the App

### Android
```bash
flutter run
```

### iOS (on macOS)
```bash
flutter run -d ios
```

## 📝 Code Quality

- **Linting**: Follows Flutter/Dart linting rules
- **Architecture**: Clean Architecture with proper separation
- **Error Handling**: Comprehensive error handling with custom Failure classes
- **Type Safety**: Strong typing throughout the codebase
- **Null Safety**: Full null safety support

## 🔄 State Management

The app uses **Provider** for state management:
- `ChangeNotifier` for state classes
- `Consumer` widgets for reactive UI updates
- Proper state lifecycle management

## 🎯 Best Practices Implemented

1. ✅ UI never calls APIs directly
2. ✅ Providers use use cases
3. ✅ Repositories are abstracted
4. ✅ Centralized themes, constants, and styles
5. ✅ iOS-safe code (no platform-specific hacks)
6. ✅ Proper error handling
7. ✅ Loading and empty states
8. ✅ Reusable widgets
9. ✅ Clean code structure
10. ✅ Dependency injection

## 📄 License

This project is created for demonstration purposes.

## 👨‍💻 Development Notes

- The app uses mock authentication for demonstration
- API calls are made to JSONPlaceholder (public test API)
- Session is persisted using SharedPreferences
- All business logic is in the domain layer
- UI is completely separated from data sources

## 🐛 Troubleshooting

### Common Issues

1. **Dependencies not found**: Run `flutter pub get`
2. **Build errors**: Ensure Flutter SDK is up to date
3. **iOS build issues**: Requires macOS with Xcode installed

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

**Built with ❤️ using Flutter**
