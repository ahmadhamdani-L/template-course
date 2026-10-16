import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// Question entity
@freezed
class Question with _$Question {
  const factory Question({
    /// Unique question identifier
    required String id,
    
    /// Question type
    required QuestionType type,
    
    /// Question text
    required String text,
    
    /// Question data (type-specific)
    required Map<String, dynamic> data,
    
    /// Correct answer(s) - format depends on type
    required dynamic correctAnswer,
    
    /// Explanation for the answer
    String? explanation,
    
    /// Hints
    @Default([]) List<String> hints,
    
    /// Points value
    @Default(1) int points,
    
    /// Difficulty level
    String? difficulty,
    
    /// Tags
    @Default([]) List<String> tags,
    
    /// Question metadata
    QuestionMetadata? metadata,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

enum QuestionType {
  @JsonValue('single_choice')
  singleChoice,
  
  @JsonValue('multiple_choice')
  multipleChoice,
  
  @JsonValue('true_false')
  trueFalse,
  
  @JsonValue('fill_blank')
  fillBlank,
  
  @JsonValue('short_answer')
  shortAnswer,
  
  @JsonValue('matching')
  matching,
  
  @JsonValue('ordering')
  ordering,
  
  @JsonValue('code_output')
  codeOutput,
  
  @JsonValue('code_review')
  codeReview,
}

@freezed
class QuestionMetadata with _$QuestionMetadata {
  const factory QuestionMetadata({
    /// Topic/concept covered
    String? topic,
    
    /// Learning objective
    String? objective,
    
    /// Bloom's taxonomy level
    String? bloomLevel,
    
    /// Custom metadata
    Map<String, dynamic>? custom,
  }) = _QuestionMetadata;

  factory QuestionMetadata.fromJson(Map<String, dynamic> json) =>
      _$QuestionMetadataFromJson(json);
}

// Type-specific question data models

@freezed
class SingleChoiceData with _$SingleChoiceData {
  const factory SingleChoiceData({
    required List<AnswerChoice> choices,
  }) = _SingleChoiceData;

  factory SingleChoiceData.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceDataFromJson(json);
}

@freezed
class MultipleChoiceData with _$MultipleChoiceData {
  const factory MultipleChoiceData({
    required List<AnswerChoice> choices,
    int? minSelections,
    int? maxSelections,
  }) = _MultipleChoiceData;

  factory MultipleChoiceData.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceDataFromJson(json);
}

@freezed
class AnswerChoice with _$AnswerChoice {
  const factory AnswerChoice({
    required String id,
    required String text,
    String? explanation,
  }) = _AnswerChoice;

  factory AnswerChoice.fromJson(Map<String, dynamic> json) =>
      _$AnswerChoiceFromJson(json);
}

@freezed
class FillBlankData with _$FillBlankData {
  const factory FillBlankData({
    /// Text with blanks marked as {blank}
    required String template,
    
    /// Blank configurations
    required List<BlankConfig> blanks,
  }) = _FillBlankData;

  factory FillBlankData.fromJson(Map<String, dynamic> json) =>
      _$FillBlankDataFromJson(json);
}

@freezed
class BlankConfig with _$BlankConfig {
  const factory BlankConfig({
    required String id,
    
    /// Accepted answers
    required List<String> acceptedAnswers,
    
    /// Case sensitive
    @Default(false) bool caseSensitive,
    
    /// Placeholder text
    String? placeholder,
  }) = _BlankConfig;

  factory BlankConfig.fromJson(Map<String, dynamic> json) =>
      _$BlankConfigFromJson(json);
}

@freezed
class MatchingData with _$MatchingData {
  const factory MatchingData({
    required List<MatchingPair> pairs,
    
    /// Show all items or partial matching
    @Default(true) bool showAllItems,
  }) = _MatchingData;

  factory MatchingData.fromJson(Map<String, dynamic> json) =>
      _$MatchingDataFromJson(json);
}

@freezed
class MatchingPair with _$MatchingPair {
  const factory MatchingPair({
    required String id,
    required String left,
    required String right,
  }) = _MatchingPair;

  factory MatchingPair.fromJson(Map<String, dynamic> json) =>
      _$MatchingPairFromJson(json);
}

@freezed
class OrderingData with _$OrderingData {
  const factory OrderingData({
    /// Items to be ordered
    required List<OrderingItem> items,
  }) = _OrderingData;

  factory OrderingData.fromJson(Map<String, dynamic> json) =>
      _$OrderingDataFromJson(json);
}

@freezed
class OrderingItem with _$OrderingItem {
  const factory OrderingItem({
    required String id,
    required String text,
    required int correctPosition,
  }) = _OrderingItem;

  factory OrderingItem.fromJson(Map<String, dynamic> json) =>
      _$OrderingItemFromJson(json);
}

@freezed
class CodeOutputData with _$CodeOutputData {
  const factory CodeOutputData({
    /// Code snippet
    required String code,
    
    /// Programming language
    String? language,
    
    /// Accepted outputs
    required List<String> acceptedOutputs,
    
    /// Exact match required
    @Default(true) bool exactMatch,
  }) = _CodeOutputData;

  factory CodeOutputData.fromJson(Map<String, dynamic> json) =>
      _$CodeOutputDataFromJson(json);
}
