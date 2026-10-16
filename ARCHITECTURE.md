# Architecture Documentation

## System Overview

The Universal Dynamic Android Application Engine is a **configurable platform** that generates multiple independent educational applications from a single codebase. This document describes the technical architecture, design decisions, and implementation patterns.

## Core Architectural Principles

### 1. Configuration Over Code

The system uses strongly-typed, versioned JSON configuration to define application behavior rather than hardcoding business logic. This enables:

- Creating new applications without copying code
- Changing app identity, branding, and features through configuration
- Validating configuration before runtime
- Safe defaults with explicit overrides

### 2. Separation of Concerns

Five distinct layers prevent coupling and enable independent evolution:

**Layer A: Engine** - Reusable infrastructure
- State management (Riverpod)
- Routing (GoRouter)
- Theme system
- Localization
- Persistence
- Content rendering
- Assessment engine

**Layer B: Application Profile** - Brand identity
- Visual design
- Navigation structure
- Feature flags
- Content sources
- Localization settings

**Layer C: Build Configuration** - Deployment settings
- Application ID
- Environment (dev/staging/prod)
- Native assets
- Signing configuration

**Layer D: Content** - Educational material
- Courses and modules
- Lessons and content blocks
- Quizzes and questions
- Media and resources

**Layer E: Runtime State** - User data
- Progress tracking
- Preferences
- Bookmarks
- Downloaded content

### 3. Type Safety and Validation

All configuration uses Freezed for immutability and JSON serialization. The ConfigValidator performs:

- Required field validation
- Type checking
- Range validation
- Reference integrity
- Feature dependency resolution
- Hex color validation
- Locale consistency

## Configuration System Architecture

### Schema Versioning

```dart
{
  "schemaVersion": "1.0",  // Enables migration logic
  ...
}
```

The schema version allows:
- Breaking changes with migration paths
- Backward compatibility detection
- Automatic config transformation

### Configuration Precedence

```
User Preferences (highest)
  ↓
Runtime Remote Config
  ↓
Build Environment Variables
  ↓
Application Profile
  ↓
Engine Defaults (lowest)
```

### Configuration Loading Process

```
1. Bootstrap → Parse APP_PROFILE environment variable
2. ConfigLoader → Load profile JSON from assets
3. ConfigValidator → Validate schema and dependencies
4. AppConfig → Construct typed configuration object
5. ProviderContainer → Override appConfigProvider
6. Application Start → Theme, nav, features initialized
```

## Feature Registry Pattern

Features are not simple boolean flags. The FeatureRegistry provides:

**Feature Metadata:**
- Unique identifier
- Human-readable name
- Description
- Dependencies (requires other features)
- Conflicts (incompatible with other features)
- Backend requirement flag
- Native setup requirement flag

**Validation:**
```dart
FeatureRegistry.validateFeatures(config)
  → Check all dependencies are enabled
  → Check no conflicting features enabled
  → Return validation errors
```

**Example:**
```dart
cloudSync (enabled) requires userAccounts (enabled)
advertisements (enabled) conflicts with premiumFeatures (enabled)
```

## Content Management Architecture

### Content Block System

Content is rendered using a **registry-based renderer pattern**:

```
ContentBlock (type + data)
  ↓
ContentBlockRegistry.getRenderer(type)
  ↓
TypeSpecificRenderer (HeadingRenderer, CodeRenderer, etc.)
  ↓
Flutter Widget
```

This allows:
- Adding new block types without modifying existing renderers
- Type-safe data structures per block type
- Safe handling of unknown block types
- Consistent error boundaries

### Supported Content Blocks

**Text Content:**
- Heading (with level 1-6)
- Paragraph (with alignment)
- Markdown (full markdown support)
- List (ordered, unordered, checklist)
- Quote (with author and source)
- Callout (info, tip, warning, danger, success, note)

**Code & Technical:**
- Code (with syntax highlighting, line numbers, filename)
- Terminal (command-line interface appearance)
- Command (emphasizes commands)
- Output (expected output display)

**Visual:**
- Image (with caption, alt text)
- Diagram (SVG or image-based)
- Table (with headers and caption)
- Comparison (side-by-side)

**Interactive:**
- Quiz Embed (inline assessments)
- Exercise (practice activities)
- Interactive Demo (simulations)

**Organizational:**
- Steps (numbered procedures)
- Timeline (chronological events)
- Tabs (multiple views)
- Accordion (collapsible sections)

### Content Schema Evolution

Content uses semantic versioning:
```json
{
  "contentVersion": "1.2.3",
  "course": {
    "schemaVersion": "1.0",
    ...
  }
}
```

Migration strategy:
1. Detect schema version mismatch
2. Apply transformation rules
3. Validate transformed content
4. Cache migrated version
5. Log migration for monitoring

## Assessment Engine

### Question Types

**Single Choice:**
```dart
{
  "type": "single_choice",
  "choices": [...],
  "correctAnswer": "choice_id"
}
```

**Multiple Choice:**
```dart
{
  "type": "multiple_choice",
  "choices": [...],
  "correctAnswer": ["choice_id1", "choice_id2"],
  "minSelections": 2,
  "maxSelections": 3
}
```

**Fill in the Blank:**
```dart
{
  "type": "fill_blank",
  "template": "Go uses {blank} for concurrency",
  "blanks": [{
    "id": "blank1",
    "acceptedAnswers": ["goroutines", "go routines"],
    "caseSensitive": false
  }]
}
```

**Code Output:**
```dart
{
  "type": "code_output",
  "code": "fmt.Println(\"Hello\")",
  "language": "go",
  "acceptedOutputs": ["Hello", "Hello\\n"],
  "exactMatch": false
}
```

### Scoring Engine

**Deterministic scoring:**
1. Parse user answer based on question type
2. Apply type-specific comparison logic
3. Check against correct answer(s)
4. Calculate points (with partial credit if configured)
5. Return detailed result with explanation

**Quiz attempt tracking:**
```dart
QuizAttempt {
  answers: Map<questionId, userAnswer>,
  score: 0.0 to 1.0,
  pointsEarned: int,
  passed: bool,
  timeSpent: seconds
}
```

### Quiz Configuration

```dart
QuizConfig {
  questionCount: int?,           // Random selection
  timeLimitMinutes: int?,        // Countdown timer
  passingThreshold: 0.7,         // 70% to pass
  randomizeQuestions: true,      // Shuffle order
  randomizeAnswers: true,        // Shuffle choices
  showExplanations: true,        // After submission
  showCorrectAnswers: true,      // Review mode
  maxAttempts: 3,                // Retry limit
  retryDelayHours: 24,           // Cooldown period
  partialCredit: false,          // All-or-nothing vs partial
}
```

## Theme Engine

### Dynamic Theme Generation

The theme system generates complete Material 3 themes from branding configuration:

```dart
BrandingConfig
  ↓
AppTheme.buildLightTheme(branding)
AppTheme.buildDarkTheme(branding)
  ↓
ColorScheme.fromSeed(primary, secondary)
  ↓
ThemeData with custom component themes
  ↓
MaterialApp theme/darkTheme
```

### Design Token System

```dart
Spacing:     xs, sm, md, lg, xl, xxl
BorderRadius: sm, md, lg, xl, xxl
Typography:   fontFamily, codeFontFamily, scales
Colors:       primary, secondary, accent, semantic colors
```

All values are configurable per application profile, enabling distinct visual identities.

### Theme Persistence

```dart
ThemeModeNotifier (StateNotifier)
  ↔
SharedPreferences ('theme_mode')
  ↔
User Selection (Settings)
```

## Navigation Architecture

### Dynamic Navigation Structure

Navigation is built from configuration, not hardcoded routes:

```dart
NavigationConfig
  ↓
List<NavDestination> (filtered by enabled)
  ↓
NavigationBar with dynamic destinations
  ↓
GoRouter routes
```

### Navigation Types

- **Bottom Navigation**: 2-5 primary destinations
- **Drawer**: 5+ destinations, hierarchical
- **Rail**: Tablet/desktop layout

### Conditional Navigation

Destinations can require features:
```json
{
  "id": "bookmarks",
  "requiredFeatures": ["bookmarks"],
  "enabled": true
}
```

If `bookmarks` feature is disabled, destination is hidden.

## Dashboard Composition Engine

### Section-Based Layout

```dart
DashboardConfig
  ↓
List<DashboardSection> (filtered, sorted by order)
  ↓
SectionBuilder for each type
  ↓
Dynamic widget tree
```

### Section Types

- **Continue Learning**: Resume last lesson
- **Recommended Courses**: Personalized suggestions
- **Learning Streak**: Daily activity tracking
- **Weekly Progress**: Statistics summary
- **Daily Challenge**: Single focused task
- **Recent Lessons**: History
- **Bookmarks**: Saved content
- **New Content**: Recently published
- **Featured Paths**: Curated sequences
- **Achievements**: Unlocked badges

### Display Styles

- **List**: Vertical scrolling
- **Grid**: 2-column layout
- **Carousel**: Horizontal scrolling
- **Card**: Single featured item

## Localization System

### Translation Loading

```dart
Locale (from user preference or config)
  ↓
AppLocalizations.delegate.load(locale)
  ↓
Switch on languageCode
  ↓
Return localized strings map
  ↓
AppLocalizations instance
```

### Fallback Strategy

```
1. Try user's selected locale
2. Try app's default locale
3. Try fallback locale (usually 'en')
4. Return key as-is
```

### Content Localization

Content files are locale-specific:
```
assets/content/courses/go_basics_en.json
assets/content/courses/go_basics_id.json
```

Missing translations show indicator and fallback content.

## State Management

### Riverpod Providers

**Configuration:**
```dart
appConfigProvider → AppConfig (overridden at bootstrap)
```

**Theme:**
```dart
themeModeProvider → StateNotifier<ThemeMode> (persisted)
lightThemeProvider → ThemeData (computed from config)
darkThemeProvider → ThemeData (computed from config)
```

**Localization:**
```dart
currentLocaleProvider → StateNotifier<Locale> (persisted)
```

**Content:**
```dart
coursesProvider → AsyncValue<List<Course>>
lessonProvider(id) → AsyncValue<Lesson>
quizProvider(id) → AsyncValue<Quiz>
```

**Progress:**
```dart
courseProgressProvider(id) → AsyncValue<CourseProgress>
learningStatsProvider → AsyncValue<LearningStats>
```

### Provider Lifecycle

1. **Bootstrap** - Override config provider
2. **App Start** - Initialize theme and locale notifiers
3. **Load State** - Restore from SharedPreferences
4. **User Action** - Update state via notifier
5. **Persist** - Save to SharedPreferences
6. **Rebuild** - UI reacts to provider changes

## Persistence Layer

### Local Storage Strategy

**SharedPreferences:**
- Theme mode
- Locale preference
- Last selected profile
- Simple key-value pairs

**SQLite (planned):**
- Course progress
- Lesson completion
- Quiz attempts
- Bookmarks
- Learning history
- Downloaded content metadata

### Database Schema (planned)

```sql
CREATE TABLE courses (
  id TEXT PRIMARY KEY,
  enrolled_at INTEGER,
  last_accessed_at INTEGER,
  completion_percentage REAL,
  completed INTEGER DEFAULT 0
);

CREATE TABLE lessons (
  id TEXT PRIMARY KEY,
  course_id TEXT,
  completed INTEGER DEFAULT 0,
  time_spent INTEGER DEFAULT 0,
  last_scroll_position INTEGER DEFAULT 0,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE quiz_attempts (
  id TEXT PRIMARY KEY,
  quiz_id TEXT,
  started_at INTEGER,
  submitted_at INTEGER,
  score REAL,
  passed INTEGER
);
```

## Build System

### Environment Variables

```bash
APP_PROFILE          # Profile name (go_academy, docker_mastery)
APP_ENV              # Environment (development, staging, production)
APP_DEFAULT_LOCALE   # Default language
```

### Build Process

```
1. Parse environment variables
2. Select application profile JSON
3. Validate configuration
4. Generate Android application ID
5. Copy native assets (launcher icons)
6. Run Flutter build
7. Generate signed APK/AAB
8. Create build report
```

### Application ID Generation

```dart
Profile: go_academy
→ Android ID: com.eduapp.go.academy

Profile: docker_mastery
→ Android ID: com.eduapp.docker.mastery
```

## Security Model

### Configuration Safety

- ✅ JSON parsing with type safety
- ✅ Validation before application
- ✅ No code execution from config
- ✅ Whitelisted block types
- ✅ Safe rendering boundaries

### Content Safety

- ✅ Predefined renderer registry
- ✅ No arbitrary HTML/JavaScript
- ✅ Sandboxed content blocks
- ✅ Size limits on content
- ✅ Error boundaries prevent crashes

### Data Protection

- ⚠️ Build variables not secure for secrets
- ⚠️ Local data not encrypted (consider SQLCipher)
- ⚠️ API keys visible in APK (use backend proxy)

## Performance Considerations

### Configuration Loading

- Loaded once at app start
- Cached in memory
- Validation errors fail fast
- Fallback to default profile

### Content Rendering

- Lazy loading of lessons
- Pagination for large lists
- Image caching (cached_network_image)
- Markdown parsing on demand

### State Management

- Riverpod automatic disposal
- Provider caching
- Minimal rebuilds
- Efficient selectors

## Testing Strategy

### Unit Tests

- Configuration validation logic
- Feature dependency resolution
- Scoring algorithms
- Content parsing
- State notifiers

### Widget Tests

- Dashboard composition
- Navigation behavior
- Theme switching
- Locale switching
- Content block rendering

### Integration Tests

- Complete user flows
- Multi-profile builds
- Configuration validation
- Progress persistence

## Deployment Pipeline

```
1. Code committed to git
2. CI runs static analysis (flutter analyze)
3. CI runs tests (flutter test)
4. CI validates configurations (dart run tool/validate_config.dart)
5. For each profile:
   a. Build APK with profile
   b. Run integration tests
   c. Generate build report
   d. Archive artifacts
6. Deploy to Google Play (manual or automated)
```

## Future Enhancements

### Phase 2: Advanced Content
- Real-time code execution sandbox
- Interactive diagrams
- Video player integration
- Audio lessons
- Downloadable resources

### Phase 3: Backend Integration
- User authentication (Firebase Auth)
- Cloud Firestore for progress sync
- Remote configuration (Firebase Remote Config)
- Content CMS
- Analytics dashboard

### Phase 4: Advanced Features
- Spaced repetition algorithm
- AI-powered recommendations
- Social learning features
- Gamification system
- Certificate generation

### Phase 5: Platform Expansion
- iOS application
- Web application
- Desktop applications
- TV application

## Conclusion

This architecture prioritizes:
1. **Configurability** over hardcoding
2. **Type safety** over dynamic typing
3. **Validation** over runtime errors
4. **Reusability** over duplication
5. **Extensibility** over modification

The result is a genuine application platform capable of generating multiple distinct products from one codebase.
