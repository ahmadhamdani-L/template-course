import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

/// Quiz/Assessment entity
@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    /// Unique quiz identifier
    required String id,
    
    /// Associated lesson ID (optional)
    String? lessonId,
    
    /// Associated course ID (optional)
    String? courseId,
    
    /// Quiz title
    required String title,
    
    /// Quiz description
    String? description,
    
    /// Quiz type
    @Default(QuizType.practice) QuizType type,
    
    /// Language/locale code
    required String locale,
    
    /// Question pool
    required List<Question> questions,
    
    /// Quiz configuration
    required QuizConfig config,
    
    /// Quiz metadata
    QuizMetadata? metadata,
    
    /// Creation date
    DateTime? createdAt,
    
    /// Last update date
    DateTime? updatedAt,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) =>
      _$QuizFromJson(json);
}

enum QuizType {
  @JsonValue('practice')
  practice,
  
  @JsonValue('assessment')
  assessment,
  
  @JsonValue('exam')
  exam,
  
  @JsonValue('challenge')
  challenge,
}

@freezed
class QuizConfig with _$QuizConfig {
  const factory QuizConfig({
    /// Number of questions to select (null = all)
    int? questionCount,
    
    /// Time limit in minutes (null = no limit)
    int? timeLimitMinutes,
    
    /// Passing threshold (0.0 to 1.0)
    @Default(0.7) double passingThreshold,
    
    /// Randomize question order
    @Default(true) bool randomizeQuestions,
    
    /// Randomize answer choices
    @Default(true) bool randomizeAnswers,
    
    /// Show explanations after submission
    @Default(true) bool showExplanations,
    
    /// Show correct answers after submission
    @Default(true) bool showCorrectAnswers,
    
    /// Allow review of answers
    @Default(true) bool allowReview,
    
    /// Maximum attempts allowed (null = unlimited)
    int? maxAttempts,
    
    /// Retry delay in hours (null = immediate)
    int? retryDelayHours,
    
    /// Partial credit enabled
    @Default(false) bool partialCredit,
    
    /// Points per question (null = equal weight)
    Map<String, int>? questionPoints,
  }) = _QuizConfig;

  factory QuizConfig.fromJson(Map<String, dynamic> json) =>
      _$QuizConfigFromJson(json);
}

@freezed
class QuizMetadata with _$QuizMetadata {
  const factory QuizMetadata({
    /// Author
    String? author,
    
    /// Content version
    String? version,
    
    /// Difficulty level
    String? difficulty,
    
    /// Total attempts count
    int? totalAttempts,
    
    /// Average score
    double? averageScore,
    
    /// Pass rate
    double? passRate,
    
    /// Custom metadata
    Map<String, dynamic>? custom,
  }) = _QuizMetadata;

  factory QuizMetadata.fromJson(Map<String, dynamic> json) =>
      _$QuizMetadataFromJson(json);
}

/// Quiz attempt (user's quiz session)
@freezed
class QuizAttempt with _$QuizAttempt {
  const factory QuizAttempt({
    /// Attempt identifier
    required String id,
    
    /// Quiz ID
    required String quizId,
    
    /// User ID (if authenticated)
    String? userId,
    
    /// User answers
    required Map<String, QuestionAnswer> answers,
    
    /// Start time
    required DateTime startedAt,
    
    /// Submission time
    DateTime? submittedAt,
    
    /// Quiz score (0.0 to 1.0)
    double? score,
    
    /// Points earned
    int? pointsEarned,
    
    /// Maximum points
    int? maxPoints,
    
    /// Passed flag
    bool? passed,
    
    /// Time spent in seconds
    int? timeSpentSeconds,
    
    /// Attempt number
    @Default(1) int attemptNumber,
  }) = _QuizAttempt;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptFromJson(json);
}

@freezed
class QuestionAnswer with _$QuestionAnswer {
  const factory QuestionAnswer({
    /// Question ID
    required String questionId,
    
    /// User's answer (format depends on question type)
    required dynamic answer,
    
    /// Is correct
    bool? isCorrect,
    
    /// Points earned
    int? pointsEarned,
    
    /// Time spent on question in seconds
    int? timeSpent,
  }) = _QuestionAnswer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);
}
