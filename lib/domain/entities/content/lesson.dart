import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_block.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

/// Lesson entity
@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    /// Unique lesson identifier
    required String id,
    
    /// Parent course ID
    required String courseId,
    
    /// Parent module ID
    required String moduleId,
    
    /// Lesson title
    required String title,
    
    /// Lesson description/summary
    String? description,
    
    /// Lesson content blocks
    required List<ContentBlock> content,
    
    /// Estimated read time in minutes
    required int estimatedMinutes,
    
    /// Language/locale code
    required String locale,
    
    /// Order within module
    required int order,
    
    /// Learning objectives for this lesson
    @Default([]) List<String> objectives,
    
    /// Key takeaways
    @Default([]) List<String> keyTakeaways,
    
    /// Prerequisites (lesson IDs)
    @Default([]) List<String> prerequisites,
    
    /// Related lessons
    @Default([]) List<String> relatedLessons,
    
    /// Tags
    @Default([]) List<String> tags,
    
    /// Quiz ID for this lesson (optional)
    String? quizId,
    
    /// Downloadable resources
    @Default([]) List<LessonResource> resources,
    
    /// Lesson metadata
    LessonMetadata? metadata,
    
    /// Creation date
    DateTime? createdAt,
    
    /// Last update date
    DateTime? updatedAt,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) =>
      _$LessonFromJson(json);
}

@freezed
class LessonResource with _$LessonResource {
  const factory LessonResource({
    /// Resource ID
    required String id,
    
    /// Resource title
    required String title,
    
    /// Resource type
    required ResourceType type,
    
    /// Resource URL or path
    required String url,
    
    /// File size in bytes
    int? sizeBytes,
    
    /// Description
    String? description,
  }) = _LessonResource;

  factory LessonResource.fromJson(Map<String, dynamic> json) =>
      _$LessonResourceFromJson(json);
}

enum ResourceType {
  @JsonValue('pdf')
  pdf,
  
  @JsonValue('code')
  code,
  
  @JsonValue('document')
  document,
  
  @JsonValue('link')
  link,
  
  @JsonValue('video')
  video,
  
  @JsonValue('other')
  other,
}

@freezed
class LessonMetadata with _$LessonMetadata {
  const factory LessonMetadata({
    /// Author
    String? author,
    
    /// Content version
    String? version,
    
    /// Completion count
    int? completionCount,
    
    /// Average time spent in minutes
    double? averageTimeSpent,
    
    /// Custom metadata
    Map<String, dynamic>? custom,
  }) = _LessonMetadata;

  factory LessonMetadata.fromJson(Map<String, dynamic> json) =>
      _$LessonMetadataFromJson(json);
}
