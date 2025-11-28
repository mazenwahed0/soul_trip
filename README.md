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

- **Advanced Search & Discovery:**

  - **Dynamic Filtering:** Search by location, budget range (`RangeSlider`), date, and wellness category.
  - **Smart Home Feed:** Features "Most Popular" trips and category-based grouping using custom filtered lists.
  - **Interactive Banners:** Auto-playing carousel showcasing top-rated destinations with granular widget architecture.

- **Resilient Connectivity:**

  - Real-time internet connection monitoring (`ConnectivityPlus`) with a dedicated animated "No Internet" screen and retry logic.

- **Media & Performance:**

  - **Smart Caching:** Custom `CacheManager` with a 7-day stale period for optimized image loading.
  - **Debouncing:** Utility implementation to optimize search inputs and reduce API calls.
  - Integration with **Cloudinary** for optimized profile picture storage.

- **Local Persistence:**
  - **Hive Database:** Storage for complex objects (User Model) for offline access.
  - **Shared Preferences:** Lightweight storage for flags (Onboarding, Remember Me).

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Flutter Bloc (Cubit)
- **Navigation:** GoRouter
- **Backend:** Firebase (Auth, Firestore)
- **Local Storage:** Hive & SharedPreferences
- **Cloud Storage:** Cloudinary
- **UI/Animations:** Animate_do, Shimmer, Carousel Slider, Solar Icons
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

| Date       | Member        | Update                                                             |
| :--------- | :------------ | :----------------------------------------------------------------- |
| 2025-11-18 | Mazen Wahed   | Initialized project & Added font                                   |
| 2025-11-19 | Safwa Ibrahim | Added Theme & Colors                                               |
| 2025-11-20 | Mina Yasser   | Added Core Files                                                   |
| 2025-11-20 | Mazen Wahed   | Added Icons                                                        |
| 2025-11-20 | Mina Yasser   | Setup Firebase & Layout View                                       |
| 2025-11-21 | Mazen Wahed   | Update V0.1 (Added Assets & Reusable Widgets)                      |
| 2025-11-22 | Mina Yasser   | Added Home Header & Search UI Structure                            |
| 2025-11-23 | Mazen Wahed   | Update V0.1.1 (Authentication Firebase + Added New Files)          |
| 2025-11-24 | Mina Yasser   | Implemented Banners, Categories & Most Popular Sections            |
| 2025-11-26 | Mazen Wahed   | Update V0.1.2 (Profile, Race Condition Fix, Dev Tools)             |
| 2025-11-26 | Mina Yasser   | Created Search Filter & Results Screens                            |
| 2025-11-28 | Mazen Wahed   | Update V0.1.3 (Merge Auth, Home/Search Features & UI Enhancements) |

---

### 2. Version History (Changelog)

#### V0.1.3 (Home, Search & Auth Integration)

This major update unifies the Authentication system with the Home and Search modules, delivering a fully personalized and dynamic user experience.

**Auth & Home Integration (Merge):**

- **Dynamic AppBar:** Successfully merged `AuthCubit` with the Home screen. The AppBar now dynamically fetches and displays the **authenticated user's name and profile picture** from Firestore, replacing static placeholders.
- **Personalized Greeting:** The home header now adapts to the current user's session data.

**Search & Filter Module:**

- **Advanced Filtering Logic:** Implemented `SearchCubit` to handle complex queries in-memory for instant feedback.
- **Multi-Factor Search:** Filter by Location, Wellness Category, Budget Range, Date, and Number of Travellers.
- **Search UI:**
  - **Filter Screen:** dedicated bottom sheet/screen for adjusting search parameters.
  - **Results Screen:** Displays filtered `HomeTripModel` results with empty state handling.

**Dynamic Home Feed:**

- **Live Banners:** Integrated `BannerCubit` to stream promotional banners from Firestore, displayed via an auto-playing `CarouselSlider`.
- **Smart Sections:**
  - **Most Popular:** Horizontal list of high-rated trips with "OFF" badges.
  - **Category Grouping:** Dynamic section generation grouping trips by their category field.

**UI/UX Refactoring & Design System:**

- **Reusable Button Architecture:**
  - **`SecondaryButton`:** Created a generic button widget that handles "Default" (Blue) and "Disabled" (Grey) states automatically, ensuring consistency across Profile, Search, and Dialogs.
  - **`CustomCircleButton`:** Standardized all circular actions (Back Button, Notification, Filter) into a single scalable widget.
- **Smart Search UI:**
  - **Split Search Bar:** Implemented a custom text field with a distinct "Filter" button segment and specific border radii to match Figma specs.
  - **Dynamic Reset:** The "Reset All" button in filters now auto-disables (turns grey) when no filters are active, preventing useless clicks.
- **Layout Improvements:**
  - **Sticky Footers:** Refactored `AccountInfoScreen` to pin the "Save Changes" button to the bottom, separating it from the scrollable form for better UX.

**Core Enhancements:**

- **Dependency Injection:** Registered new repositories (`HomeTripsRepository`, `SearchRepository`, `BannerRepository`) in `getIt`.
- **Unified Routing:** Connected Auth flows (Login/Signup) with the Main App Shell (Home/Profile) using `GoRouter` and `AppRouteGuard`.

#### V0.1.2 (Profile, Settings & Stability Improvements)

This update brings significant improvements to user profile management, completes the authentication suite, and adds essential developer utilities.

**Architecture & Critical Fixes:**

- **Race Condition Resolution:** Implemented a **"Gatekeeper" pattern** in `UserRepository` (`ensureUserRecordExists`). The app now guarantees that user data exists in Firestore _before_ navigating to Home, fixing the "Empty Profile" bug on fresh Social Logins.
- **Separation of Concerns:** Refactored `SocialAuthCubit` to handle _only_ the sign-in action, delegating user creation and data fetching to the global `AuthCubit`.
- **Reactive Data Sync:** Removed redundant manual data refresh calls in UI listeners. The app now relies entirely on `AuthCubit` streams to keep the UI in sync with Firebase.

**Profile & Account Management:**

- **Account Info Screen:** Added a new screen for updating personal details, fully integrated with Firestore.
- **"Save & Snap" Logic:** Implemented UI logic to immediately format phone numbers (e.g., `+20 10...`) upon saving, ensuring the UI reflects the exact data stored in the database.
- **Input Validation:** Extended `TextFieldModel` to support `TextInputFormatter`, strictly restricting phone fields to numeric inputs only.
- **Smart Profile Picture Upload:** Refactored image logic to automatically **delete the old profile picture** from Cloudinary before uploading a new one.
- **Logout Experience:** Added a dedicated **LogoutStatusSheet** with a Red Warning UI for a safer exit flow.

**Authentication Enhancements:**

- **"Remember Me":** Added local credential persistence using `SharedPrefHelper`. Users can save email/password for faster logins.
- **Forgot Password:** Implemented full password reset flow via Firebase Authentication.
- **Reactive Navigation:** Integrated `GoRouterRefreshStream` to instantly handle redirects (e.g., auto-logout) based on auth state changes.

**Developer Tools (Data Seeding):**

- **Load Data Screen:** Added a hidden developer tool to upload static assets (like Onboarding images) to **Cloudinary**.
- **Upload Architecture:** Created `DataUploadRepository` to handle asset conversion and bulk uploading to Firestore.

**UI/UX & Refactoring:**

- **Advanced Snackbars (`Loaders`):** Replaced generic toasts with a custom **Loaders** class (Success, Error, Warning) featuring animated pulsing icons.
- **Phone Formatting Utility:** Added `formatEgyptianPhoneNumber` to standardize phone number display app-wide.
- **Widget Refactoring:**
  - **StatusBottomSheet:** Streamlined for generic success messages.
  - **CustomAppBar:** Created a versatile, reusable app bar.
  - **CustomBackButton:** Standardized navigation buttons.

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
