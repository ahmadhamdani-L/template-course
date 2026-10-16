# Getting Started Guide

## Welcome to the Universal Dynamic Android Application Engine!

This guide will help you get up and running quickly with the platform.

---

## Prerequisites

Before you begin, ensure you have:

- **Flutter SDK** (3.0.0 or later) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **Android SDK** (will be configured by Flutter)
- Basic knowledge of **Flutter/Dart** and **JSON**

---

## Quick Start (5 Minutes)

### Step 1: Install Dependencies

```bash
# Navigate to project directory
cd template

# Get Flutter packages
flutter pub get
```

**Expected Output:**
```
Running "flutter pub get" in template...
Resolving dependencies... (10.2s)
+ flutter_riverpod 2.4.9
+ go_router 13.0.0
+ freezed_annotation 2.4.1
...
Got dependencies!
```

### Step 2: Generate Code

```bash
# Generate Freezed models and JSON serialization
dart run build_runner build --delete-conflicting-outputs
```

**Expected Output:**
```
[INFO] Generating build script...
[INFO] Running build...
[INFO] 1.2s elapsed, 0/3 actions completed.
[INFO] 12.5s elapsed, 25/25 actions completed.
[INFO] Succeeded after 12.6s with 50 outputs
```

### Step 3: Validate Configuration

```bash
# Validate Go Academy profile
dart run tool/validate_config.dart go_academy
```

**Expected Output:**
```
🔍 Validating configuration profile: go_academy
📁 Path: assets/config/profiles/go_academy.json

✅ VALIDATION PASSED

Profile Summary:
  App Key: go_academy
  Display Name: Go Programming Academy
  Version: 1.0.0
  Locales: [en, id]
```

### Step 4: Run the App

```bash
# Run Go Academy profile (default)
flutter run
```

**Or specify a profile:**
```bash
# Run Docker Mastery
flutter run --dart-define=APP_PROFILE=docker_mastery
```

**Expected Result:** App launches on your device/emulator

---

## Understanding the Project

### Project Structure

```
template/
├── lib/                          # Main application code
│   ├── app/                      # App setup and bootstrap
│   ├── core/                     # Core infrastructure
│   │   ├── config/               # Configuration system ⭐
│   │   ├── localization/         # Translations
│   │   └── theme/                # Dynamic theme engine
│   ├── domain/                   # Business entities
│   │   └── entities/             # Course, Lesson, Quiz models
│   ├── features/                 # Feature modules (UI)
│   │   ├── dashboard/
│   │   ├── courses/
│   │   ├── lessons/
│   │   ├── profile/
│   │   └── settings/
│   └── main.dart                 # Entry point
├── assets/                       # Static assets
│   └── config/
│       └── profiles/             # Application configurations ⭐
│           ├── go_academy.json
│           ├── docker_mastery.json
│           └── default.json
├── android/                      # Android native code
├── test/                         # Tests
├── tool/                         # CLI tools
│   └── validate_config.dart      # Configuration validator
└── docs/                         # Documentation
```

⭐ = Most important directories to understand

### Key Concepts

#### 1. Application Profile

A JSON file that defines an application's complete identity:

```json
{
  "schemaVersion": "1.0",
  "appKey": "my_app",
  "identity": { /* Name, version, publisher */ },
  "branding": { /* Colors, fonts, spacing */ },
  "navigation": { /* Bottom nav, dashboard */ },
  "features": { /* What's enabled */ },
  "localization": { /* Languages */ },
  "content": { /* Content sources */ }
}
```

#### 2. Feature Flags

Enable/disable entire features:

```json
{
  "features": {
    "courseCatalog": true,      // ✅ Shown in UI
    "quizEngine": true,          // ✅ Shown in UI
    "achievements": false,       // ❌ Hidden from UI
    "cloudSync": false          // ❌ Not available
  }
}
```

#### 3. Dynamic Theme

Theme is generated from configuration:

```json
{
  "branding": {
    "colors": {
      "primary": "#00ADD8",     // Go cyan
      "secondary": "#5DC9E2"
    }
  }
}
```

Result: Entire app uses these colors

---

## Your First Custom Application

Let's create a "Python Learning Studio" app!

### Step 1: Create Configuration

```bash
# Copy default profile
cp assets/config/profiles/default.json assets/config/profiles/python_studio.json
```

### Step 2: Edit Configuration

Open `assets/config/profiles/python_studio.json`:

```json
{
  "schemaVersion": "1.0",
  "appKey": "python_studio",
  "identity": {
    "displayName": "Python Learning Studio",
    "shortName": "Python",
    "subtitle": "Master Python Programming",
    "description": "Learn Python from basics to advanced with hands-on projects",
    "publisher": {
      "name": "Your Name",
      "supportEmail": "support@example.com"
    },
    "version": "1.0.0",
    "buildNumber": 1
  },
  "branding": {
    "preset": "python_yellow",
    "colors": {
      "primary": "#FFD43B",
      "secondary": "#3776AB"
    },
    "typography": {
      "fontFamily": "Inter"
    },
    "spacing": {},
    "borderRadius": {},
    "assets": {
      "logo": "assets/branding/python_logo.png"
    }
  },
  "navigation": {
    "type": "bottom_nav",
    "destinations": [
      {
        "id": "home",
        "labelKey": "home",
        "icon": "home",
        "route": "/",
        "enabled": true
      },
      {
        "id": "courses",
        "labelKey": "courses",
        "icon": "courses",
        "route": "/courses",
        "enabled": true
      },
      {
        "id": "profile",
        "labelKey": "profile",
        "icon": "profile",
        "route": "/profile",
        "enabled": true
      }
    ],
    "dashboard": {
      "sections": [
        {
          "id": "continue_learning",
          "type": "continue_learning",
          "titleKey": "continue_learning",
          "maxItems": 5,
          "displayStyle": "list",
          "enabled": true,
          "order": 1
        },
        {
          "id": "recommended_courses",
          "type": "recommended_courses",
          "titleKey": "recommended_courses",
          "maxItems": 5,
          "displayStyle": "carousel",
          "enabled": true,
          "order": 2
        }
      ],
      "enableSearch": true,
      "showWelcomeHeader": true
    },
    "initialRoute": "/"
  },
  "features": {
    "courseCatalog": true,
    "lessonReader": true,
    "quizEngine": true,
    "progressTracking": true,
    "learningPaths": true,
    "bookmarks": true,
    "notes": true,
    "search": true,
    "interactiveExercises": true,
    "codePlayground": false
  },
  "localization": {
    "defaultLocale": "en",
    "supportedLocales": ["en", "id"],
    "fallbackLocale": "en"
  },
  "content": {
    "bundledEnabled": true
  }
}
```

### Step 3: Validate

```bash
dart run tool/validate_config.dart python_studio
```

Should output:
```
✅ VALIDATION PASSED
```

### Step 4: Run Your App!

```bash
flutter run --dart-define=APP_PROFILE=python_studio
```

**Result:** A Python-themed app with yellow branding! 🎉

### Step 5: Build APK

```bash
flutter build apk --dart-define=APP_PROFILE=python_studio
```

Your APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

---

## Common Tasks

### Change App Colors

Edit your profile's `branding.colors`:

```json
{
  "branding": {
    "colors": {
      "primary": "#YOUR_COLOR",
      "secondary": "#YOUR_COLOR"
    }
  }
}
```

### Enable/Disable Features

Edit your profile's `features`:

```json
{
  "features": {
    "achievements": true,        // Enable achievements
    "learningStreaks": false,    // Disable streaks
    "notes": true                // Enable note-taking
  }
}
```

### Customize Dashboard

Edit your profile's `navigation.dashboard.sections`:

```json
{
  "dashboard": {
    "sections": [
      {
        "id": "continue_learning",
        "type": "continue_learning",
        "titleKey": "continue_learning",
        "order": 1,
        "enabled": true
      },
      {
        "id": "weekly_progress",
        "type": "weekly_progress",
        "titleKey": "weekly_progress",
        "order": 2,
        "enabled": false            // Disable this section
      }
    ]
  }
}
```

### Add Navigation Destination

Edit your profile's `navigation.destinations`:

```json
{
  "destinations": [
    {
      "id": "bookmarks",
      "labelKey": "bookmarks",
      "icon": "bookmark",
      "route": "/bookmarks",
      "requiredFeatures": ["bookmarks"],
      "enabled": true
    }
  ]
}
```

### Switch Language

1. Run the app
2. Go to Profile → Settings
3. Tap "Language"
4. Select "Bahasa Indonesia" or "English"

### Switch Theme

1. Run the app
2. Go to Profile → Settings
3. Tap "Theme"
4. Select "Light", "Dark", or "System"

---

## Development Workflow

### Daily Development

```bash
# 1. Start development
flutter run

# 2. Hot reload after code changes
# Press 'r' in terminal or use IDE button

# 3. Hot restart after model changes
# Press 'R' in terminal

# 4. Regenerate code after model changes
dart run build_runner build --delete-conflicting-outputs

# 5. Run tests
flutter test

# 6. Check for issues
flutter analyze
```

### Before Committing Code

```bash
# 1. Format code
dart format lib/

# 2. Run static analysis
flutter analyze

# 3. Run tests
flutter test

# 4. Validate all profiles
dart run tool/validate_config.dart go_academy
dart run tool/validate_config.dart docker_mastery
dart run tool/validate_config.dart python_studio

# 5. Test build
flutter build apk --dart-define=APP_PROFILE=go_academy
```

---

## Troubleshooting

### Problem: "Configuration validation failed"

**Solution:** Check the validation errors:
```bash
dart run tool/validate_config.dart your_profile
```

Common issues:
- Missing required fields
- Invalid hex color format
- Default locale not in supported locales
- Feature dependencies not satisfied

### Problem: "Build fails with Freezed errors"

**Solution:** Regenerate code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Problem: "Hot reload doesn't work"

**Solution:** Hot restart instead (press 'R') or:
```bash
flutter run --dart-define=APP_PROFILE=your_profile
```

### Problem: "App crashes on startup"

**Solution:** Check logs:
```bash
flutter run --dart-define=APP_PROFILE=your_profile --verbose
```

Look for configuration errors in console output.

### Problem: "Colors don't change"

**Solution:** 
1. Check your hex colors are valid (6 or 8 characters after #)
2. Restart the app (not just hot reload)
3. Check theme provider is reading your config

---

## Next Steps

### 1. Learn the Architecture

Read `ARCHITECTURE.md` to understand:
- How configuration loading works
- The theme generation system
- Feature flag dependencies
- Content block rendering

### 2. Create Your Own Application

Follow the "Your First Custom Application" section above to create:
- SQL Academy
- Rust Learning Lab
- JavaScript Mastery
- Any educational topic!

### 3. Add Custom Content

(Phase 2 - Coming Soon)
- Create course JSON files
- Add lessons with content blocks
- Build quizzes and assessments

### 4. Contribute Features

(Phase 2+)
- Implement new dashboard sections
- Add new content block types
- Build advanced features

---

## Resources

- **README.md** - Project overview and commands
- **ARCHITECTURE.md** - Technical deep dive
- **IMPLEMENTATION_REPORT.md** - What's implemented
- **PROJECT_STATUS.md** - Current status and roadmap
- **Flutter Documentation** - https://flutter.dev/docs
- **Riverpod Documentation** - https://riverpod.dev
- **Material 3 Guidelines** - https://m3.material.io

---

## Getting Help

### Check Documentation First

1. README.md - Quick commands
2. ARCHITECTURE.md - How things work
3. IMPLEMENTATION_REPORT.md - What's done
4. Inline code comments - Implementation details

### Common Questions

**Q: How do I add a new feature?**
A: See ARCHITECTURE.md → Feature Registry section

**Q: How do I change the app theme?**
A: Edit your profile's `branding.colors`

**Q: How do I add a new language?**
A: Add to `lib/core/localization/localizations_<code>.dart`

**Q: Can I use this for non-educational apps?**
A: Yes! The architecture is flexible. Adapt content models to your domain.

**Q: How do I deploy to production?**
A: See README.md → Build System section

---

## Success Checklist

- ✅ Flutter installed and working
- ✅ Dependencies downloaded (`flutter pub get`)
- ✅ Code generated (`build_runner build`)
- ✅ Go Academy runs successfully
- ✅ Docker Mastery runs successfully
- ✅ Configuration validation works
- ✅ Tests pass (`flutter test`)
- ✅ Static analysis clean (`flutter analyze`)
- ✅ Created first custom profile
- ✅ Built first APK

---

**Welcome aboard! You're now ready to build multiple educational apps from one codebase! 🚀**
