# Soul Trip: Wellness Tourism App

![Status](https://img.shields.io/badge/status-in_development-blue) ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black) ![Bloc](https://img.shields.io/badge/Bloc-8A2BE2?style=for-the-badge&logo=bloc&logoColor=white)

---

## 📝 Project Overview

**Soul Trip** is a specialized Flutter application designed to be the ultimate gateway to wellness tourism in Egypt. It connects international travelers and locals with expert therapists and diverse healing sanctuaries nationwide.

The project is built with scalability in mind, utilizing **Clean Architecture**, **Dependency Injection**, and **Functional Error Handling** to ensure a robust user experience from Onboarding to Booking.

---

## 👥 Soul Trip Team Members

### Flutter Developers Team

| Name              | Role                                                    |
| :---------------- | :------------------------------------------------------ |
| **Mazen Wahed**   | Full-Stack (Splash, Onboarding, Firebase Auth, Profile) |
| **Mina Yasser**   | Full-Stack (Home, Categories, Search, Notification)     |
| **Safwa Ibrahim** | Full-Stack (Trip Details Screen, Orders, Checkout)      |
| **Mariam Naeem**  | Full-Stack (Expert Screen, Booking Appointments)        |

### UI/UX Designers Team

| Name               |
| :----------------- |
| **Manar Ahmed**    |
| **Walaa Hatem**    |
| **Walaa Elhawary** |
| **Ibtehal Thabet** |

---

## ✨ Key Features

This project meets all core requirements of a full-stack mobile application, including:

- **Advanced Authentication:**
  - Secure Email/Password Login & Registration.
  - **Social Login:** Integration with Google Sign-In.
  - **Route Guarding:** Automatic redirection based on authentication state (using `GoRouter`).
- **Resilient Connectivity:**
  - Real-time internet connection monitoring.
  - dedicated "No Internet" screen with retry logic.
- **Media Management:**
  - Integration with **Cloudinary** for optimized profile picture storage.
  - Cached Network Images for performance.
- **Smart Onboarding:**
  - Interactive onboarding flow for first-time users.
  - Local persistence (Shared Prefs) to remember user sessions.
- **Robust Architecture:**
  - **Dependency Injection** using `GetIt`.
  - **State Management** using `Flutter Bloc` (Cubits).
  - **Functional Error Handling** using `dartz` (Either Pattern).

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Flutter Bloc (Cubit)
- **Navigation:** GoRouter
- **Backend:** Firebase (Auth, Firestore)
- **Local Storage:** Hive & SharedPreferences
- **Cloud Storage:** Cloudinary
- **Dependency Injection:** GetIt

---

## 📂 Project Structure

```
lib/
├── 📁 core/                # Core utilities and shared components
│   ├── 📁 caching/         # Hive & SharedPref helpers
│   ├── 📁 dependency_injection/ # GetIt setup
│   ├── 📁 errors/          # Custom Failures & Exceptions (Dartz integration)
│   ├── 📁 internet_check/  # Connectivity Logic & Cubit
│   ├── 📁 routing/         # AppRouter, RouteGuard, Animations
│   ├── 📁 theme/           # App Colors, TextStyles, Icons
│   └── 📁 widgets/         # Reusable widgets (Buttons, TextFields, Loaders)
│
├── 📁 features/            # Feature-based architecture
│   ├── 📁 authentication/  # Login, Signup, Social Auth logic & UI
│   ├── 📁 experts/         # Experts listing screens
│   ├── 📁 home/            # Home screen UI
│   ├── 📁 layout/          # Bottom Navigation Bar & Layout Cubit
│   ├── 📁 onboarding/      # Onboarding flow & persistence logic
│   ├── 📁 profile/         # User Profile, Image Upload, User Repository
│   ├── 📁 reviews/         # Reviews UI
│   ├── 📁 splash/          # Animated Splash Screen
│   └── 📁 wishlist/        # User Wishlist
│
└── 📄 main.dart            # Entry point & Global Providers
```

---

## 🚀 Project Timeline & Progress

### 1. Progress Log

| Date       | Member        | Update                                                    |
| :--------- | :------------ | :-------------------------------------------------------- |
| 2025-11-18 | Mazen Wahed   | Initialized project & Added font                          |
| 2025-11-19 | Safwa Ibrahim | Added Theme & Colors                                      |
| 2025-11-20 | Mina Yasser   | Added Core Files                                          |
| 2025-11-20 | Mazen Wahed   | Added Icons                                               |
| 2025-11-20 | Mina Yasser   | Setup Firebase & Layout View                              |
| 2025-11-21 | Mazen Wahed   | Update V0.1 (Added Assets & Reusable Widgets)             |
| 2025-11-23 | Mazen Wahed   | Update V0.1.1 (Authentication Firebase + Added New Files) |

---

### 2. Version History (Changelog)

#### V0.1.1 (Major Refactor & Feature Expansion)

- **Architecture & Dependency Injection:**

  - **Service Locator (`GetIt`):** Implemented centralized dependency injection in `lib/core/dependency_injection/set_up_dependencies.dart`.
    - **Singletons:** Registered `AuthenticationRepository`, `UserRepository`, and `CloudinaryService`.
    - **Factories:** Registered independent Cubits (`LoginCubit`, `SignupCubit`, `SocialAuthCubit`, `UserCubit`, `ConnectivityCubit`) to ensure fresh state on screen initialization.
  - **Global State:** Wrapped the root `MaterialApp` in `MultiBlocProvider` to inject global instances of `AuthCubit` and `ConnectivityCubit`.

- **Routing & Navigation (`GoRouter`):**

  - **Persistent Bottom Navigation:** Refactored `AppRouter` to use `ShellRoute`, preserving the state of the Bottom Navigation Bar across `Home`, `Experts`, `Wishlist`, `Reviews`, and `Profile` tabs.
  - **Smart Redirection (`AppRouteGuard`):** Implemented a robust guard class `AppRouteGuard` that automatically redirects users based on their session state:
    - **Splash -> Onboarding:** If the user hasn't seen onboarding (`SharedPrefs`).
    - **Unauthenticated -> Login:** If the user accesses protected routes without being logged in.
    - **Authenticated -> Home:** If a logged-in user tries to access Auth screens.

- **Data Layer & Error Handling:**

  - **Functional Error Handling (`dartz`):** Refactored `AuthenticationRepository` and `UserRepository` to return `Either<Failure, T>` instead of throwing raw exceptions. This ensures explicit handling of `ServerFailure`, `AuthFailure`, and `NetworkFailure` across the app.
  - **Cloud Storage:** Integrated **Cloudinary** via `CloudinaryService` for optimized profile picture uploads using `dio` and `crypto` for secure signature generation.

- **New Features:**

  - **Social Authentication:** Implemented **Google Sign-In** logic within `SocialAuthCubit`, handling the retrieval of Google credentials and automatic creation of new user documents in Firestore.
  - **Connectivity System:** Added real-time internet monitoring using `ConnectivityCubit`. The app now actively listens to network changes and overlays a `NoInternetScreen` or blocks interactions when offline.
  - **Onboarding Module:** Developed a complete Onboarding flow with a `PageView` slider and persistence logic in `OnboardingCubit` to track if the user has completed the intro.

- **UI/UX:**

  - **Responsive Design:** Standardized layout using `flutter_screenutil` and implemented `AdaptiveLayout` for device adaptability.
  - **Animated Splash Screen:** Created a complex entrance animation sequence (`TweenSequence`) in `SplashView` featuring logo reveals and text fading.
  - **Auth UI:** Designed a reusable `AuthLayout` featuring a custom curved background.
  - **Feedback System:** Added `StatusBottomSheet` for consistent success/failure messaging (e.g., "Email Verification Sent").
  - **Reusable Component Library:** Built a set of core widgets including PrimaryShadowButton, CustomAppBar, and CustomBackButton.
  - **Interactive Inputs:** Built `CustomTextFormField` with internal state management for focus border animation and password visibility toggling.

#### V0.1 (Project Init)

- **Initialized Flutter project**
- **Configured Firebase Authentication & Firestore**
- **Setup AppRouter**
- **Basic UI structure, Layout View & Navigation Bar using ShellRoute**
- **Added Assets, Icons and fonts `Poppins`**

---

## 🤝 Contribution Rules

### Update Rules (Important)

1.  **Always pull before pushing**
    - Always run `git pull origin main` before making changes.
    - Resolve any conflicts locally before pushing.
2.  **Branching**
    - Create a new branch for your feature. `(e.g., feat/booking-system)`
3.  **Log progress in the Progress Log table**
    - Add date + short description of what you did.
4.  **Use clear commit messages**
    - Example: `feat: added wishlist UI` or `fix: resolved cart bug`
5.  **Communicate big changes**
    - If you change project structure or shared files, notify the team on WhatsApp.
