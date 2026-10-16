# Universal Dynamic Android Application Engine

A highly configurable Flutter-based platform for creating multiple independent educational applications from a single codebase.

## 🎯 Project Overview

This is a **real software engineering project** that implements a configurable application platform, not a conventional mobile app. The architecture supports:

- Multiple application identities from one codebase
- Different educational topics (Go, Docker, SQL, Python, etc.)
- Customizable user journeys and layouts
- Dynamic content and assessment rendering
- Optional features via configuration
- Bilingual support (Indonesian & English)
- Theme customization per brand
- Automated Android builds

## 🏗️ Architecture Principles

The system distinguishes between five separate layers:

1. **Engine**: Shared application infrastructure and reusable functionality
2. **Application configuration**: Branding, layout, navigation, features, policies
3. **Content**: Courses, lessons, questions, exercises, media, translations
4. **Runtime state**: User preferences, progress, bookmarks, history
5. **Build configuration**: Application ID, launcher assets, signing, environment

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.0.0 or later)
- Android Studio or VS Code
- Dart SDK (included with Flutter)

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd template

# Get dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Validate a configuration profile
dart run tool/validate_config.dart go_academy

# Run the app (Go Academy by default)
flutter run

# Run with specific profile
flutter run --dart-define=APP_PROFILE=docker_mastery

# Build APK for specific profile
flutter build apk --dart-define=APP_PROFILE=go_academy
```

## 📱 Demo Applications

### Go Programming Academy
- **Profile**: `go_academy`
- **Theme**: Developer Blue (#00ADD8)
- **Features**: Code examples, syntax highlighting, interactive exercises
- **Dashboard**: Continue learning, streak tracker, recommended courses

**Run:**
```bash
flutter run --dart-define=APP_PROFILE=go_academy
```

### Docker Mastery
- **Profile**: `docker_mastery`
- **Theme**: Docker Cyan (#2496ED)
- **Features**: Container concepts, command examples, certificates
- **Dashboard**: Progress tracking, weekly stats, course grid

**Run:**
```bash
flutter run --dart-define=APP_PROFILE=docker_mastery
```

## 🔧 Configuration System

### Configuration Layers

1. **Engine Defaults** (lib/core/config/)
2. **Application Profile** (assets/config/profiles/)
3. **Build Profile** (environment variables)
4. **Remote Configuration** (optional, not implemented)
5. **User Preferences** (SharedPreferences)

### Creating a New Application Profile

1. Create configuration file:
```bash
assets/config/profiles/your_app.json
```

2. Define application identity, branding, navigation, and features

3. Validate configuration:
```bash
dart run tool/validate_config.dart your_app
```

4. Build application:
```bash
flutter build apk --dart-define=APP_PROFILE=your_app
```

### Configuration Schema

See `lib/core/config/models/` for complete schema definitions:

- `app_config.dart` - Root configuration
- `branding_config.dart` - Visual identity
- `navigation_config.dart` - Layout and navigation
- `feature_config.dart` - Feature flags
- `localization_config.dart` - Language settings
- `monetization_config.dart` - Ads and premium features

## 📚 Content Management

### Content Schema

Courses, lessons, and assessments are defined using JSON schemas:

- **Course**: Title, modules, metadata, difficulty
- **Lesson**: Content blocks, objectives, prerequisites
- **Quiz**: Questions, configuration, scoring rules
- **ContentBlock**: Type-based rendering (text, code, image, etc.)

### Supported Content Block Types

- Text: heading, paragraph, markdown, list, quote, callout
- Code: code, terminal, command, output
- Visual: image, diagram, table, comparison
- Interactive: quiz_embed, exercise, interactive_demo
- Organizational: steps, timeline, tabs, accordion
- Media: video, audio
- Reference: link, reference, related_content

### Adding New Content

Content can be added without editing Dart code:

1. Create course JSON in `assets/content/courses/`
2. Create lesson JSON in `assets/content/lessons/`
3. Create quiz JSON in `assets/content/quizzes/`
4. Reference in course manifest

## 🎨 Theming and Branding

Each application profile can define:

- Primary, secondary, and accent colors
- Typography (font family, sizes, weights)
- Spacing scale
- Border radius values
- Asset paths (logo, icons, illustrations)
- Light and dark theme variants

The theme engine generates complete Material 3 themes from configuration.

## 🌐 Localization

### Supported Languages

- English (en)
- Indonesian (id)

### Adding Translations

1. Add locale to profile configuration
2. Create translations in `lib/core/localization/localizations_<code>.dart`
3. Add content translations in content JSON files

## ✅ Feature Registry

Features can be enabled/disabled per application profile:

**Core Learning:**
- Course catalog, lesson reader, quiz engine, progress tracking

**Content Organization:**
- Learning paths, bookmarks, notes, search

**Assessment:**
- Multiple question types, flashcards, spaced repetition

**Progress & Motivation:**
- History, achievements, streaks, challenges, certificates

**Offline:**
- Offline mode, downloads, cloud sync

**Monetization:**
- Premium features, advertisements (AdMob)

See `lib/core/config/models/feature_config.dart` for complete list.

## 🔨 Build System

### Environment Variables

```bash
APP_PROFILE=go_academy          # Application profile to load
APP_ENV=development             # Environment (development, staging, production)
APP_DEFAULT_LOCALE=en           # Default locale
```

### Build Commands

```bash
# Development build
flutter build apk --dart-define=APP_PROFILE=go_academy

# Release build
flutter build apk --release --dart-define=APP_PROFILE=go_academy

# Build Android App Bundle
flutter build appbundle --dart-define=APP_PROFILE=docker_mastery
```

## 🧪 Testing

### Run Tests

```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/core/config/config_validator_test.dart
```

### Test Categories

- **Unit Tests**: Configuration, validation, scoring, content parsing
- **Widget Tests**: Dashboard, navigation, theme, content blocks
- **Integration Tests**: Complete user flows

## 📁 Project Structure

```
lib/
├── app/                    # Application setup
│   ├── bootstrap.dart      # Initialization
│   ├── app.dart           # Root widget
│   ├── routing/           # Navigation
│   └── scaffold/          # Shell layout
├── core/                   # Core infrastructure
│   ├── config/            # Configuration system
│   ├── localization/      # i18n
│   ├── theme/             # Theme engine
│   └── utilities/         # Helpers
├── domain/                 # Domain models
│   └── entities/          # Business entities
│       ├── content/       # Course, Lesson, ContentBlock
│       ├── assessment/    # Quiz, Question
│       └── progress/      # UserProgress, Stats
├── features/              # Feature modules
│   ├── dashboard/         # Home dashboard
│   ├── courses/           # Course catalog
│   ├── lessons/           # Lesson reader
│   ├── profile/           # User profile
│   └── settings/          # Settings
└── main.dart              # Entry point

assets/
├── config/
│   └── profiles/          # Application configurations
├── content/               # Bundled content
├── branding/              # Logos and assets
└── fonts/                 # Typography

tool/
└── validate_config.dart   # Configuration validator

test/
├── unit/                  # Unit tests
├── widget/                # Widget tests
└── integration/           # Integration tests
```

## 🔐 Security Considerations

- Configuration cannot execute arbitrary code
- Content rendering uses safe, predefined components
- Remote content validation before application
- Build-time variables are not secure secret storage
- AdMob IDs use development/production separation

## 📋 Known Limitations

- Android only (iOS requires native setup)
- No backend implementation (interfaces defined)
- Code playground requires separate sandbox service
- Push notifications require native setup
- Cloud sync requires backend integration
- Content authoring tool not included
- No automated UI tests yet

## 🛣️ Roadmap

### Phase 1: Foundation (Complete)
- ✅ Configuration system
- ✅ Content models
- ✅ Theme engine
- ✅ Basic UI
- ✅ Two demo profiles

### Phase 2: Content Rendering (In Progress)
- ⏳ Dynamic content block renderer
- ⏳ Code syntax highlighting
- ⏳ Assessment engine
- ⏳ Progress persistence

### Phase 3: Advanced Features
- ⏳ Offline content downloads
- ⏳ Search functionality
- ⏳ Bookmarks and notes
- ⏳ Learning streaks
- ⏳ Achievements

### Phase 4: Backend Integration
- ⏳ Optional REST API
- ⏳ User accounts
- ⏳ Cloud synchronization
- ⏳ Remote content delivery

### Phase 5: Monetization & Analytics
- ⏳ AdMob integration
- ⏳ Premium features
- ⏳ Analytics tracking
- ⏳ A/B testing

## 📝 License

[Specify License]

## 👥 Contributors

[List contributors]

## 📞 Support

For questions or issues, contact: support@example.com

---

**This is a universal application platform, not a single-purpose app. Changing configuration changes the application experience without rewriting code.**
