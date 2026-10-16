import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// Course entity
@freezed
class Course with _$Course {
  const factory Course({
    /// Unique course identifier
    required String id,
    
    /// Course title
    required String title,
    
    /// Short description
    required String description,
    
    /// Detailed overview (markdown)
    String? overview,
    
    /// Difficulty level
    required DifficultyLevel difficulty,
    
    /// Estimated duration in minutes
    required int estimatedMinutes,
    
    /// Language/locale code
    required String locale,
    
    /// Course status
    @Default(ContentStatus.published) ContentStatus status,
    
    /// Tags for categorization
    @Default([]) List<String> tags,
    
    /// Prerequisites (course IDs)
    @Default([]) List<String> prerequisites,
    
    /// Learning objectives
    @Default([]) List<String> learningObjectives,
    
    /// Thumbnail image path
    String? thumbnail,
    
    /// Cover image path
    String? coverImage,
    
    /// Icon identifier
    String? icon,
    
    /// Module/chapter list
    required List<CourseModule> modules,
    
    /// Course metadata
    CourseMetadata? metadata,
    
    /// Creation date
    DateTime? createdAt,
    
    /// Last update date
    DateTime? updatedAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);
}

@freezed
class CourseModule with _$CourseModule {
  const factory CourseModule({
    /// Module identifier
    required String id,
    
    /// Module title
    required String title,
    
    /// Module description
    String? description,
    
    /// Order index
    required int order,
    
    /// Lessons in this module
    required List<String> lessonIds,
    
    /// Module is locked until prerequisites complete
    @Default(false) bool locked,
    
    /// Prerequisites (module IDs)
    @Default([]) List<String> prerequisites,
  }) = _CourseModule;

  factory CourseModule.fromJson(Map<String, dynamic> json) =>
      _$CourseModuleFromJson(json);
}

@freezed
class CourseMetadata with _$CourseMetadata {
  const factory CourseMetadata({
    /// Author/instructor name
    String? author,
    
    /// Content version
    String? version,
    
    /// Total lessons count
    int? totalLessons,
    
    /// Total quizzes count
    int? totalQuizzes,
    
    /// Completion rate (0.0 to 1.0)
    double? averageCompletion,
    
    /// Average rating (1.0 to 5.0)
    double? averageRating,
    
    /// Total enrollments
    int? enrollmentCount,
    
    /// Additional custom metadata
    Map<String, dynamic>? custom,
  }) = _CourseMetadata;

  factory CourseMetadata.fromJson(Map<String, dynamic> json) =>
      _$CourseMetadataFromJson(json);
}

enum DifficultyLevel {
  @JsonValue('beginner')
  beginner,
  
  @JsonValue('intermediate')
  intermediate,
  
  @JsonValue('advanced')
  advanced,
  
  @JsonValue('expert')
  expert,
}

enum ContentStatus {
  @JsonValue('draft')
  draft,
  
  @JsonValue('published')
  published,
  
  @JsonValue('archived')
  archived,
}
