---
description: Standup Sync
---

You are a Senior Flutter Architect and Google Cloud Expert. 
We are building a productivity super-app for engineers called "Provolo" (Engineering Toolkit).

**THE APP CONCEPT:**
A unified mobile app containing two distinct tools:
1. "StandupSync": A voice-first tool to record and summarize daily standups using Gemini AI.
2. "GigShield": A document scanner to analyze PDF contracts for legal risks using Gemini AI.

**THE TECH STACK (STRICT):**
- **Framework:** Flutter (Latest Stable).
- **State Management:** Riverpod (Use `@riverpod` annotation syntax / code generation).
- **Navigation:** GoRouter.
- **Backend:** Firebase (Auth, Firestore, Storage) + Google Cloud Vertex AI (Gemini 1.5).
- **UI Lib:** Google Fonts, Lucide Icons (or Phosphor Icons).

**THE DESIGN SYSTEM (MANDATORY):**
- **Theme:** Material 3 Dark Mode ONLY.
- **Primary Background:** `#0F172A` (Deep Slate Blue).
- **Surface/Card Color:** `#1E293B` (Lighter Slate).
- **Text Color:** `#F8FAFC` (Off-White).
- **Brand Colors:** - StandupSync: `#F97316` (Electric Orange).
    - GigShield: `#14B8A6` (Cyber Teal).
- **Typography:** Use 'Inter' or 'Outfit' from Google Fonts.
- **Styling:** Use `Gap` for spacing. No raw `SizedBox`. 

**THE FOLDER STRUCTURE (FEATURE-FIRST):**
Please organize the code as follows:
lib/
├── core/
│   ├── theme/ (app_theme.dart, app_colors.dart)
│   ├── router/ (app_router.dart)
│   ├── services/ (firebase, storage, ai_service)
│   └── widgets/ (shared UI components like AppButton, CustomCard)
├── features/
│   ├── auth/
│   ├── dashboard/ (The main landing screen to pick a tool)
│   ├── standup_sync/ (Voice recording & summary logic)
│   └── gig_shield/ (PDF upload & risk analysis logic)
└── main.dart

**YOUR TASK:**
1. Generate the `pubspec.yaml` dependencies list.
2. Create the `core/theme/app_theme.dart` file implementing the Deep Blue theme (`#0F172A`) correctly.
3. Create a `main.dart` that initializes Riverpod (`ProviderScope`) and sets up the App.
4. Create a `features/dashboard/presentation/home_screen.dart` that serves as the main menu. It should have a sleek UI with two large, distinct cards (one Orange for Standup, one Teal for GigShield) that navigate to their respective routes.

Write clean, production-ready code.