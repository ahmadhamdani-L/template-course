import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

/// User's course progress
@freezed
class CourseProgress with _$CourseProgress {
  const factory CourseProgress({
    /// Course ID
    required String courseId,
    
    /// User ID (null for local/anonymous)
    String? userId,
    
    /// Enrollment date
    required DateTime enrolledAt,
    
    /// Last accessed date
    required DateTime lastAccessedAt,
    
    /// Completion percentage (0.0 to 1.0)
    @Default(0.0) double completionPercentage,
    
    /// Completed lesson IDs
    @Default([]) List<String> completedLessons,
    
    /// Current/in-progress lesson ID
    String? currentLessonId,
    
    /// Module progress
    @Default({}) Map<String, ModuleProgress> moduleProgress,
    
    /// Total time spent in minutes
    @Default(0) int totalTimeMinutes,
    
    /// Course completed flag
    @Default(false) bool completed,
    
    /// Completion date
    DateTime? completedAt,
    
    /// Certificate issued
    @Default(false) bool certificateIssued,
  }) = _CourseProgress;

  factory CourseProgress.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressFromJson(json);
}

@freezed
class ModuleProgress with _$ModuleProgress {
  const factory ModuleProgress({
    /// Module ID
    required String moduleId,
    
    /// Completion percentage (0.0 to 1.0)
    @Default(0.0) double completionPercentage,
    
    /// Completed lesson IDs in this module
    @Default([]) List<String> completedLessons,
    
    /// Module completed flag
    @Default(false) bool completed,
    
    /// Completion date
    DateTime? completedAt,
  }) = _ModuleProgress;

  factory ModuleProgress.fromJson(Map<String, dynamic> json) =>
      _$ModuleProgressFromJson(json);
}

/// User's lesson progress
@freezed
class LessonProgress with _$LessonProgress {
  const factory LessonProgress({
    /// Lesson ID
    required String lessonId,
    
    /// Course ID
    required String courseId,
    
    /// User ID (null for local/anonymous)
    String? userId,
    
    /// First accessed date
    required DateTime firstAccessedAt,
    
    /// Last accessed date
    required DateTime lastAccessedAt,
    
    /// Lesson completed flag
    @Default(false) bool completed,
    
    /// Completion date
    DateTime? completedAt,
    
    /// Time spent in minutes
    @Default(0) int timeSpentMinutes,
    
    /// Read percentage (0.0 to 1.0)
    @Default(0.0) double readPercentage,
    
    /// Last scroll position (for resuming)
    @Default(0) int lastScrollPosition,
    
    /// Bookmarked flag
    @Default(false) bool bookmarked,
    
    /// Quiz completed (if applicable)
    @Default(false) bool quizCompleted,
    
    /// Quiz score (if applicable)
    double? quizScore,
  }) = _LessonProgress;

  factory LessonProgress.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressFromJson(json);
}

/// User's overall learning statistics
@freezed
class LearningStats with _$LearningStats {
  const factory LearningStats({
    /// User ID (null for local/anonymous)
    String? userId,
    
    /// Total courses enrolled
    @Default(0) int totalCoursesEnrolled,
    
    /// Total courses completed
    @Default(0) int totalCoursesCompleted,
    
    /// Total lessons completed
    @Default(0) int totalLessonsCompleted,
    
    /// Total quizzes completed
    @Default(0) int totalQuizzesCompleted,
    
    /// Total time spent in minutes
    @Default(0) int totalTimeMinutes,
    
    /// Current learning streak in days
    @Default(0) int currentStreak,
    
    /// Longest learning streak in days
    @Default(0) int longestStreak,
    
    /// Last activity date
    DateTime? lastActivityAt,
    
    /// Total points earned
    @Default(0) int totalPoints,
    
    /// Achievements unlocked
    @Default([]) List<String> achievements,
    
    /// Daily activity log
    @Default({}) Map<String, DailyActivity> dailyActivity,
  }) = _LearningStats;

  factory LearningStats.fromJson(Map<String, dynamic> json) =>
      _$LearningStatsFromJson(json);
}

@freezed
class DailyActivity with _$DailyActivity {
  const factory DailyActivity({
    /// Date (YYYY-MM-DD)
    required String date,
    
    /// Lessons completed
    @Default(0) int lessonsCompleted,
    
    /// Quizzes completed
    @Default(0) int quizzesCompleted,
    
    /// Time spent in minutes
    @Default(0) int timeSpentMinutes,
    
    /// Points earned
    @Default(0) int pointsEarned,
  }) = _DailyActivity;

  factory DailyActivity.fromJson(Map<String, dynamic> json) =>
      _$DailyActivityFromJson(json);
}

/// Bookmark entity
@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    /// Bookmark ID
    required String id,
    
    /// User ID (null for local/anonymous)
    String? userId,
    
    /// Lesson ID
    required String lessonId,
    
    /// Course ID
    required String courseId,
    
    /// Bookmark note
    String? note,
    
    /// Created date
    required DateTime createdAt,
    
    /// Updated date
    DateTime? updatedAt,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
}
