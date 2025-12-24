# Koders Test - Flutter App

A Flutter mobile app built with Clean Architecture. Works on Android right now, and the code is ready for iOS builds too.

## What's Inside

This app has a simple login system (mock auth for demo), fetches posts from a public API, and shows them in a list with pagination. You can tap on any post to see the details.

## Features

- Login screen with email/password validation
- Session management (remembers you're logged in)
- Posts list that loads 20 items at a time when you scroll
- Pull to refresh the list
- Post detail screen
- Loading states, error handling, and empty states
- Dark mode support (follows your system settings)

## Tech Stack

I used Clean Architecture here, so the code is split into three main layers:

- **Domain layer**: Business logic, entities, use cases, and repository interfaces. This part doesn't know anything about Flutter or HTTP - it's just pure Dart code.

- **Data layer**: Handles API calls using the `http` package, stores stuff locally with `shared_preferences`, and implements the repository interfaces from the domain layer.

- **Presentation layer**: The UI stuff - screens, widgets, and state management using `provider`.

There's also a `core` folder with shared utilities like constants, themes, validators, and dependency injection setup.

## Dependencies

Main packages:
- `provider` - for state management
- `http` - for API calls
- `shared_preferences` - to store login session

That's pretty much it. I kept it simple and didn't use any heavy frameworks.

## Getting Started

Make sure you have Flutter installed. Then:

```bash
flutter pub get
flutter run
```

That's it. The app should run on Android right away.

For iOS, you'll need a Mac with Xcode, but the code itself is ready - no platform-specific hacks or anything.

## Login Credentials

Since this is a demo app, I set up mock authentication:
- Email: `user@example.com`
- Password: `password123`

Just use these to log in and test the app.

## How It Works

The app fetches posts from JSONPlaceholder API (it's a public test API). When you first open the app, it loads 20 posts. Scroll down and when you get near the bottom, it automatically loads the next 20. You'll see a loading indicator while it fetches more.

You can pull down to refresh the list, and tap on any post to see the full details.

The authentication is mocked - it just checks if the email and password match the demo credentials. If they do, it saves a token locally and keeps you logged in until you log out.

## Project Structure

The code is organized like this:

- `lib/core/` - Shared stuff (constants, themes, validators, error handling, dependency injection)
- `lib/domain/` - Business logic (entities, use cases, repository interfaces)
- `lib/data/` - Data handling (API calls, local storage, repository implementations)
- `lib/presentation/` - UI (screens, widgets, providers for state management)

The key thing is that the UI never directly calls APIs. Everything goes through use cases, which call repositories, which handle the actual data fetching. This makes the code easier to test and maintain.

## State Management

I'm using Provider for state management. There are two main providers:
- `AuthProvider` - handles login/logout and session state
- `PostProvider` - manages the posts list and pagination

## API Details

The app uses JSONPlaceholder API:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoint: `/posts`

Since this API doesn't support server-side pagination, I implemented client-side pagination. It fetches all posts once and then slices them into pages of 20 items each.

## Running Tests

```bash
flutter test
```

## Platform Support

- **Android**: Fully working, just run `flutter run`
- **iOS**: Code is ready, but you need macOS to build it. No code changes needed.

## Notes

- The authentication is mocked for demo purposes
- All posts data comes from JSONPlaceholder (public test API)
- Session is stored locally using SharedPreferences
- The app follows Clean Architecture principles, so business logic is separated from UI and data sources
- Error handling is done through custom Failure classes
- Loading and empty states are handled properly throughout the app

## Troubleshooting


For build errors, make sure your Flutter SDK is up to date.

iOS builds require macOS with Xcode - can't do much about that on Windows.

That's about it. The code is pretty straightforward and follows standard Flutter practices.
