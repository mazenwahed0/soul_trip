# Soul Trip: Wellness Tourism App

![Status](https://img.shields.io/badge/status-in_development-blue) ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black) ![Bloc](https://img.shields.io/badge/Bloc-8A2BE2?style=for-the-badge&logo=bloc&logoColor=white)

---

## 📝 Project Overview

**Soul Trip** is a specialized Flutter application designed to be the ultimate gateway to wellness tourism in Egypt. It connects international travelers and locals with expert therapists and diverse healing sanctuaries nationwide.

The project is built with scalability in mind, utilizing **Clean Architecture**, **Dependency Injection**, and **Functional Error Handling** to ensure a robust user experience from Onboarding to Booking.

---

## 👥 Soul Trip Team Members

### Flutter Developers Team

| Name               | Role                                                    |
| :----------------- | :------------------------------------------------------ |
| **Mazen Wahed**    | Full-Stack (Splash, Onboarding, Firebase Auth, Profile) |
| **Mina Yasser**    | Full-Stack (Home, Categories, Search, Notification)     |
| **Safwa Ibrahim**  | Full-Stack (Trip Details Screen, Orders, Checkout)      |
| **Youssef Hesham** | Full-Stack (Wishlist, Reviews Screens)                  |
| **Mariam Naeem**   | Full-Stack (Expert Screen, Booking Appointments)        |

### UI/UX Designers Team

| Name               |
| :----------------- |
| **Manar Ahmed**    |
| **Walaa Hatem**    |
| **Walaa Elhawary** |
| **Ibtehal Thabet** |
| **Mai Emara**      |

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
- **Backend:** Firebase (Auth, Firestore), Vercel (OTP Forgot Password)
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

| Date       | Member         | Update                                                                       |
| :--------- | :------------- | :--------------------------------------------------------------------------- |
| 2025-11-18 | Mazen Wahed    | Initialized project & Added font                                             |
| 2025-11-19 | Safwa Ibrahim  | Added Theme & Colors                                                         |
| 2025-11-20 | Mina Yasser    | Added Core Files                                                             |
| 2025-11-20 | Mazen Wahed    | Added Icons                                                                  |
| 2025-11-20 | Mina Yasser    | Setup Firebase & Layout View                                                 |
| 2025-11-21 | Mazen Wahed    | Update V0.1 (Added Assets & Reusable Widgets)                                |
| 2025-11-22 | Mina Yasser    | Added Home Header & Search UI Structure                                      |
| 2025-11-23 | Mazen Wahed    | Update V0.1.1 (Authentication Firebase + Added New Files)                    |
| 2025-11-23 | Mariam Naeem   | Added Static Expert & Booking Screens                                        |
| 2025-11-24 | Mina Yasser    | Implemented Banners, Categories & Most Popular Sections                      |
| 2025-11-25 | Mariam Naeem   | Fetched Experts Data from Firebase & Implemented Search                      |
| 2025-11-26 | Mazen Wahed    | Update V0.1.2 (Profile, Race Condition Fix, Dev Tools)                       |
| 2025-11-26 | Mina Yasser    | Created Search Filter & Results Screens                                      |
| 2025-11-27 | Safwa Ibrahim  | Implemented Trip Details Widgets                                             |
| 2025-11-28 | Mazen Wahed    | Update V0.1.3 (Merge Auth, Home/Search Features & UI Enhancements)           |
| 2025-11-29 | Safwa Ibrahim  | Finalized Trip Details Screen UI                                             |
| 2025-11-29 | Mariam Naeem   | Expert Screen Updates & Internet Connection Check                            |
| 2025-11-30 | Mariam Naeem   | Implemented Booking Validation (Prevent Double Booking)                      |
| 2025-11-30 | Safwa Ibrahim  | Fixed Trip Details Scroll Issue                                              |
| 2025-11-30 | Mina Yasser    | Finish Like in Home (Banner and Trips of Categories)                         |
| 2025-12-01 | Safwa Ibrahim  | Created Payment Screen UI                                                    |
| 2025-12-01 | Mina Yasser    | Implement Notifications Screen                                               |
| 2025-12-02 | Mina Yasser    | Implement Favorite Like in Category & Search Result View                     |
| 2025-12-03 | Mazen Wahed    | Update Readme & Adding New Assets                                            |
| 2025-12-04 | Youssef Hesham | Update V0.1.4 (Implemented Reviews Feature)                                  |
| 2025-12-04 | Mazen Wahed    | Update V0.1.4b (Added Image Picker, Refactored Reviews & Bug Fixes)          |
| 2025-12-05 | Mina Yasser    | Update V0.1.5 (Implemented Notification Screen & Likes Logic (Cubits/Repos)) |
| 2025-12-05 | Mazen Wahed    | Merged Reviews, Search, and Notification Features                            |
| 2025-12-05 | Mazen Wahed    | Update V0.1.6 (OTP Forgot Password)                                          |
| 2025-12-06 | Mina Yasser    | Update V0.1.7 (Notification System Overhaul & Likes Architecture)            |
| 2025-12-06 | Youssef Hesham | Implemented Wishlist Feature                                                 |
| 2025-12-07 | Mariam Naeem   | Implemented Expert Filter Screen & Solved UI Issues                          |
| 2025-12-07 | Safwa Ibrahim  | Completed Add Card Screen UI                                                 |
| 2025-12-08 | Mina Yasser    | Update V0.1.8 (Merged Experts Integration & Trip Details)                    |
| 2025-12-09 | Mazen Wahed    | Update V0.1.9 (Merged Wishlist Feature)                                      |
| 2025-12-09 | Mazen Wahed    | Update V0.2 (Expert Details UX & Bug Fixes)                                  |
| 2025-12-09 | Mazen Wahed    | Update V0.2.1 (Filter Module UX & Bug Fixes)                                 |

---

### 2. Version History (Changelog)

#### V0.2.1 (Experts Filter Module & UI Polish)

This update brings the Experts Module to production-level fidelity, standardizes trip cards across the app, and unifies feedback mechanisms using the new Bottom Sheet system.

**Experts Module:**

- **Search Integration:** Refactored `HomeSearchBarWidget` to be reusable, allowing the Experts screen to use specific White/Grey styling and custom shadows distinct from the Home screen.

**Filter Screen Refactor:**

- **UI Polish:** Updated filter chips to use the "Choice Chip" style (Grey default / Blue selected) with conditional logic to display Star Icons only on rating chips.

- **Horizontal Scrolling:** Converted the "Location" filter from a static wrap to a scrollable horizontal list.

- **Logic Fixes:** Fixed the "Reset All" button state (now disabled when no filters are active) and resolved navigation crashes by properly injecting `ExpertFilterCubit` via `AppRouter`.

**Home & Categories**

- **Card Standardization:**

  - **Home Trips:** Rebuilt `HomeTripsCardWidget` to match the "Trip Details 4" Figma spec (Horizontal layout, floating heart icon, specific shadows).

  - **Category Trips:** Updated `CategoryTripItemCardWidget` to share the exact same modern UI as Home cards for consistency.

**Profile & UX**

- **Account Info:** Replaced standard loaders/snackbars with the `StatusBottomSheet` for success states.

**Bug Fixes & Clean Code**

- **Routing Safety:** Fixed a critical `Null Check Operator` crash in `FilterExpertsScreen` by removing unsafe arguments and relying on Dependency Injection in `AppRouter`.

---

#### V0.2 (Experts Module & Booking System)

This update significantly refactors the Expert Details UI to match high-fidelity Figma designs, cleans up the codebase by removing redundant legacy files, and fixes critical scrolling/layout bugs across the app.

**Experts Module:**

- **Visual Redesign:** Completely rebuilt `ExpertdetailsView` to match Figma specifications.

  - **Glassmorphism:** Implemented gradient overlays and glass-style cards for the doctor's info.
  - **Sticky Booking Action:** pinned the "Book Appointment" button to the bottom while content scrolls behind it.
  - **Typography:** Updated fonts to `Poppins` with precise weights (SemiBold, Medium) and colors (`#262626`,` #898989`).
  - **Heavy Borders:** Enhanced AboutDoctor card with distinct `#EBEBEB` borders.

- **Custom Booking System (New):**

  - **Custom Calendar:** Replaced the native date picker with a fully custom-built Calendar UI (`CalendarGrid`, `CalendarHeader`) matching the design language.
  - **Logic Integration:** Connected the "Book Appointment" button to `BookingCubit` to handle real API calls.
  - **Success Feedback:** Integrated `StatusBottomSheet` to display a "Booking Successful" confirmation with navigation logic back to Home.

- **Date & Time Logic:** Refactored `TimeSelector` and `DateSelector` to support a cohesive vertical layout with horizontal scrolling chips for time slots.
- **Image Handling:** Optimized ExpertImage scaling (`420h`) and alignment (`topCenter`) to ensure subjects are perfectly visible.
- **State Management:** Cleanup: Deleted redundant files and folders (`widgets/filter_expert, expertBody.dart, etc.`) to streamline the project structure.

**UI/UX Polish & Bug Fixes:**

- **Material 3 Fix:** Fixed the "Bluish Tint" issue on `CustomAppBar` by forcing `surfaceTintColor: Colors.transparent.`
- **Scroll Visibility:** Resolved the "Hidden Last Item" bug by adding dynamic bottom padding (`100.h`) to `Wishlist`, `Profile`, and `Reviews screens`, ensuring content clears the transparent Bottom Navigation Bar.
- **Layout Safety:** Fixed `RenderFlex` overflow errors in `FilterExperts` and `AboutDoctor` widgets by replacing rigid columns/rows with flexible layouts (`Wrap`, `Expanded`).
- **Navigation Sync:** Fixed issue where the Bottom Navigation Bar state did not update when navigating programmatically via `GoRouter`.

- **Bug Fixes & Clean Code**

  - **Refactoring:** Enforced strict `snake_case` file naming conventions (renamed `ExpertDetailsView widget.dart ` -> `expert_details_view.dart`).
  - **Cleanup:** Deleted redundant files and folders (e.g., duplicate `StarsWidget`) to streamline the project structure.

---

#### V0.1.9 (Wishlist Implementation)

This update finalizes the "Saved Trips" functionality, allowing users to view and manage their favorite destinations in a dedicated screen.

**Wishlist Module:**

- **Wishlist Screen:** Added `WishlistScreen` to display the user's liked trips.
- **Data Fetching Logic:** Implemented `WishlistCubit` to:
  - Fetch the list of Liked IDs from `Users/{uid}/likes`.
  - Retrieve the full `HomeTripModel` details for each ID from the `HomeTrips` collection.
- **Empty State Handling:** Created a polished EmptyWishlist widget with a call-to-action button redirecting users to the Home screen when they have no saved trips.
- **State Management:** Handled loading, loaded (list populated), and error states to ensure a smooth user experience.

---

#### V0.1.8 (Experts Module & Trip Details Integration)

This update integrates the "Experts" feature and Trip Details logic, finalizing the core browsing and booking flows.

**Experts Directory & Filtering:**

- **Experts Screen:** Merged `feature/expert-screens` (PR #7). Implemented `ExpertsScreen` using `BlocProvider` to inject `ExpertCubit` and `ExpertsRepository`.
- **Advanced Filtering:** Added `FilterExperts` screen allowing users to filter professionals by Category, Availability, Rating, and Budget.
- **Booking Validation:** Implemented logic to prevent double booking of appointments.
- **Data Layer:** Created `ExpertsRepository` to fetch and stream expert data from the `experts` Firestore collection.

**Trip Details & Payment Flow:**

- **Trip Details Screen:** Fully implemented the `TripDetailsScreen` with custom widgets for pricing, reviews, and expert information.
- **Payment UI:** Added `PaymentScreen` and `AddCardScreen` to handle the checkout process for booking trips.
- **Scroll Handling:** Optimized scrolling behavior within the Trip Details view.

**Refactoring:**

- **Layout Constants:** Updated `layout_constants.dart` to support new navigation routes.

---

#### V0.1.7 (Engagement & Real-time Interaction)

This update introduces a robust notification center powered by Firebase Cloud Messaging (FCM) and refactors the "Favorites" logic into a scalable, real-time architecture.

**Notification System:**

- **FCM Service Integration:** Implemented `FCMService` to handle foreground/background messaging and token syncing.
- **Notification UI:** Added fully functional `NotificationScreen` that gates access based on authentication state and groups alerts by time (Today, Yesterday, Older).
- **Logic:** Created `NotificationCubit` and `NotificationRepository` to stream user-specific notifications from Firestore.

**Centralized Likes Architecture:**

- **Dedicated Cubits:** Migrated from ad-hoc state management to specific Cubits (`TripsLikesCubit`, `SearchLikesCubit`) for handling likes across different features.
- **Optimistic UI:** Implemented immediate visual feedback (heart turns red instantly) while Firestore writes occur in the background.

---

#### V0.1.6 (Custom OTP Backend & Advanced Auth Refactoring)

This update introduces a fully custom serverless backend to handle secure password resets, bypassing Firebase's standard link limitations, along with significant architectural refactoring.

**Serverless Backend Architecture (Vercel + Node.js):**

- **Custom API:** Deployed a Node.js backend on Vercel to handle sensitive Admin SDK operations without exposing credentials.
- **OTP Logic:** Implemented a secure 4-digit OTP system using `Nodemailer` (Gmail SMTP) and Firestore for temporary code storage (5-minute expiry).
- **Endpoints:** Created three dedicated secure endpoints:
  - `/send-otp`: Verifies user existence and dispatches email.
  - `/verify-otp`: Validates code before allowing password change access.
  - `/reset-password`: Force-updates user credentials via Firebase Admin SDK.

**Forgot Password UX (Wizard Flow):**

- **3-Step Wizard:** Implemented `EmailScreen` → `OtpScreen` → `NewPasswordScreen` with smooth transitions.
- **Smart Timer:** Added a 60-second countdown for resending OTPs with visual feedback.
- **Navigation Logic:** Implemented smart "Back" navigation:
  - Going back from OTP clears the input.
  - Going back from New Password resets the entire flow to prevent stale state.
- **Enhanced Validation:** Added strict password strength checks and confirmation matching before API calls.

**Refactoring & Clean Architecture:**

- **Repository Pattern:** Refactored `AuthenticationRepository` to use a generic `_postRequest` helper, strictly adhering to DRY (Don't Repeat Yourself) principles.
- **Theme Extraction:** Moved `Pinput` styling to a dedicated `CustomPinTheme` class in `core/theme`.
- **Utility Extraction:** Created `format_timer.dart` for reusable time formatting logic.
- **State Management Fixes:** Solved a state-looping bug in `ForgetPasswordCubit` where the success Snackbar would trigger repeatedly during the timer countdown.

---

#### V0.1.5 (Likes & Notifications Features)

This update focuses on user engagement, introducing a fully synchronized **Favorites System** across the app and a robust **Notification Center** powered by FCM.

**Real-time Favorites System:**

- **Centralized Logic:** Replaced local state "heart" toggles with a dedicated architecture using specific Cubits (`BannerLikesCubit`, `TripsLikesCubit`, `CategoryTripsLikesCubit`, `SearchLikesCubit`).
- **Optimistic UI:** Implemented instant visual feedback (heart turns red immediately) while performing the asynchronous Firestore write in the background.
- **Cross-View Sync:** Liking a trip in the "Search" view now instantly updates its status in the "Home" view and "Saved" lists via Firestore streams.
- **Data Structure:** Likes are now persisted in a scalable sub-collection structure: `Users/{userId}/likes/{type}/{itemId}`.

**Notification Center:**

- **Full UI Implementation:** Replaced the placeholder screen with a grouped list view (Today, Yesterday, Older).
- **Interactive Actions:** Added functionality to **Mark as Read** and **Delete** notifications via a bottom sheet menu.
- **FCM Integration:** Implemented `FCMService` to handle:
  - **Foreground:** Showing `FlutterLocalNotifications` when the app is open.
  - **Background/Terminated:** Handling notification taps to navigate users to specific trips.
- **Real-time Stream:** `NotificationCubit` listens to the user's notification collection for live updates.

**UI & Refactoring:**

- **Refactored Cards:** Updated `BannerCardWidget`, `CategoryTripItemCardWidget`, and `SearchTripFavoriteButton` to consume the new Likes Cubits.
- **Assets:** Added new icons and assets to support the notification and empty state UIs.

---

#### V0.1.4b (Refactoring & Stability Polish)

This patch focuses on architectural cleanup, bug fixes, and unifying the UI consistency across the Reviews and Profile modules.

**Reviews & Community Module:**

- **Media Integration:** Added **Image Picker** functionality, allowing users to select and preview photos from their gallery before posting reviews.

**Bug Fixes & Stability:**

- **Stream Subscription Safety:** Standardized stream handling across all Cubits (`HomeTripsCubit`, `BannerCubit`, `ReviewCubit`, etc.). Implemented explicit `StreamSubscription` cancellation in `close()` to prevent memory leaks and "Bad State" crashes when navigating away during data loading.
- **Async State Safety:** Fixed `StateError` in `UserCubit` by adding `isClosed` checks to all asynchronous operations, preventing crashes when navigating away during uploads.
- **Layout Constraints:** Resolved `BoxConstraints` infinite width crash in `WriteReviewWidget` by overriding the global button theme constraints.
- **Time Logic:** Fixed negative duration calculation in `getTimeAgo`, ensuring post timestamps correctly show "Just now" for server-synced times.
- **Broken Image Handling:** Implemented `CachedNetworkImage` with error widgets in `ReviewSection` to gracefully handle 404 errors (e.g., deleted images).

**UI/UX Enhancements:**

- **Live Author Sync:** Logic added to `ReviewSection` to check if the reviewer is the current user. If true, it displays live profile data (Name/Photo) from `AuthCubit` instead of stale snapshot data.
- **Unified Search:** Refactored `ReviewsScreen` to use the shared `HomeSearchBarWidget`, ensuring visual consistency with Home and Search screens.
- **Loading Architecture:** Created `LoadingHelper` to centralize `EasyLoading` configuration (White theme, rounded corners) and fixed `MaterialApp.router` builder conflicts in `main.dart`.
- **Iconography:** Standardized icon usage, switching between `Soultrip` font icons and SVGs where appropriate for better visual balance (e.g., Bottom Navigation, Action Buttons).

**Refactoring:**

- **Stateless UI:** Refactored `ReviewsScreen` to `StatelessWidget` by moving UI state (Tabs, Search Visibility) into a dedicated `ReviewsUiCubit`.
- **Header Cleanup:** Removed redundant background attributes from `HomeHeaderWidget` for a cleaner look.
- **Dependency Injection:** Finalized dependencies and routing configurations for the Reviews and Search features.

---

#### V0.1.4 (Reviews & Social Community)

This update introduces the community aspect of Soul Trip, allowing users to share their experiences and interact with others.

**Reviews & Community Module:**

- **Interactive Feed:** Implemented `ReviewsScreen` featuring a dynamic list of user reviews with "Discover", "My Timeline", and "Saved" tabs.
- **Social Interactions:**
  - **Real-time Like System:** Users can like reviews with immediate optimistic UI updates (local state updates instantly while Firestore syncs in the background).
  - **Save for Later:** Functionality to bookmark reviews to the "Saved" tab using `toggleSave` logic.
  - **Search Reviews:** Local search capability to filter reviews by caption or user name.
- **Post Creation:**
  - **Write Review Widget:** A dedicated input section with validation (prevents empty posts) and visual feedback.
  - **Firestore Integration:** `WriteReviewCubit` handles creating new documents in the `reviews` collection with timestamps, user data, and initial stats.

**Architecture & State Management:**

- **Dual Cubit Strategy:** Separated logic into `ReviewCubit` (for fetching and interactions) and `WriteReviewCubit` (for posting), ensuring separation of concerns.
- **Global Access:** Registered Review cubits in `main.dart` and `set_up_dependencies.dart` to ensure state persists across navigation.
- **Optimized Performance:** Used `ListView.builder` with `BouncingScrollPhysics` for a smooth scrolling experience even with large datasets.

**UI Enhancements:**

- **Dynamic Header:** Integrated the reusable `HomeHeaderWidget` into the Reviews screen, featuring a toggleable Search bar.
- **Action Items:** Created reusable `ActionItem`, `FavCircleButton`, and `SaveCircleButton` widgets to standardize social interaction buttons.

---

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

---

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

---

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

---

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

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (3.x.x)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone [https://github.com/mazenwahed0/soul_trip](https://github.com/mazenwahed0/soul_trip)
   cd soul-trip
   ```
