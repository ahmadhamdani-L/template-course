import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_block.freezed.dart';
part 'content_block.g.dart';

/// Universal content block for flexible lesson rendering
@freezed
class ContentBlock with _$ContentBlock {
  const factory ContentBlock({
    /// Block identifier (unique within lesson)
    required String id,
    
    /// Block type
    required ContentBlockType type,
    
    /// Block content (type-specific)
    required Map<String, dynamic> data,
    
    /// Block metadata
    ContentBlockMetadata? metadata,
  }) = _ContentBlock;

  factory ContentBlock.fromJson(Map<String, dynamic> json) =>
      _$ContentBlockFromJson(json);
}

enum ContentBlockType {
  // Text Content
  @JsonValue('heading')
  heading,
  
  @JsonValue('paragraph')
  paragraph,
  
  @JsonValue('markdown')
  markdown,
  
  @JsonValue('list')
  list,
  
  @JsonValue('quote')
  quote,
  
  @JsonValue('callout')
  callout,
  
  // Code & Technical
  @JsonValue('code')
  code,
  
  @JsonValue('terminal')
  terminal,
  
  @JsonValue('command')
  command,
  
  @JsonValue('output')
  output,
  
  // Visual Content
  @JsonValue('image')
  image,
  
  @JsonValue('diagram')
  diagram,
  
  @JsonValue('table')
  table,
  
  @JsonValue('comparison')
  comparison,
  
  // Interactive Content
  @JsonValue('quiz_embed')
  quizEmbed,
  
  @JsonValue('exercise')
  exercise,
  
  @JsonValue('interactive_demo')
  interactiveDemo,
  
  // Organizational
  @JsonValue('steps')
  steps,
  
  @JsonValue('timeline')
  timeline,
  
  @JsonValue('tabs')
  tabs,
  
  @JsonValue('accordion')
  accordion,
  
  // Media
  @JsonValue('video')
  video,
  
  @JsonValue('audio')
  audio,
  
  // Reference & Navigation
  @JsonValue('link')
  link,
  
  @JsonValue('reference')
  reference,
  
  @JsonValue('related_content')
  relatedContent,
  
  // Special
  @JsonValue('divider')
  divider,
  
  @JsonValue('spacer')
  spacer,
  
  @JsonValue('custom')
  custom,
}

@freezed
class ContentBlockMetadata with _$ContentBlockMetadata {
  const factory ContentBlockMetadata({
    /// Accessibility label
    String? accessibilityLabel,
    
    /// Block can be collapsed
    @Default(false) bool collapsible,
    
    /// Block initially collapsed
    @Default(false) bool defaultCollapsed,
    
    /// Block is highlighted
    @Default(false) bool highlighted,
    
    /// Custom CSS classes (for theming)
    List<String>? classes,
    
    /// Additional custom properties
    Map<String, dynamic>? custom,
  }) = _ContentBlockMetadata;

  factory ContentBlockMetadata.fromJson(Map<String, dynamic> json) =>
      _$ContentBlockMetadataFromJson(json);
}

// Specific block data models for type safety

@freezed
class HeadingBlockData with _$HeadingBlockData {
  const factory HeadingBlockData({
    required String text,
    @Default(2) int level, // h1=1, h2=2, etc.
    String? id, // For anchor links
  }) = _HeadingBlockData;

  factory HeadingBlockData.fromJson(Map<String, dynamic> json) =>
      _$HeadingBlockDataFromJson(json);
}

@freezed
class ParagraphBlockData with _$ParagraphBlockData {
  const factory ParagraphBlockData({
    required String text,
    TextAlign? align,
  }) = _ParagraphBlockData;

  factory ParagraphBlockData.fromJson(Map<String, dynamic> json) =>
      _$ParagraphBlockDataFromJson(json);
}

enum TextAlign {
  @JsonValue('left')
  left,
  
  @JsonValue('center')
  center,
  
  @JsonValue('right')
  right,
  
  @JsonValue('justify')
  justify,
}

@freezed
class CodeBlockData with _$CodeBlockData {
  const factory CodeBlockData({
    required String code,
    String? language,
    String? filename,
    bool? showLineNumbers,
    List<int>? highlightLines,
    String? caption,
  }) = _CodeBlockData;

  factory CodeBlockData.fromJson(Map<String, dynamic> json) =>
      _$CodeBlockDataFromJson(json);
}

@freezed
class CalloutBlockData with _$CalloutBlockData {
  const factory CalloutBlockData({
    required String content,
    @Default(CalloutType.info) CalloutType type,
    String? title,
  }) = _CalloutBlockData;

  factory CalloutBlockData.fromJson(Map<String, dynamic> json) =>
      _$CalloutBlockDataFromJson(json);
}

enum CalloutType {
  @JsonValue('info')
  info,
  
  @JsonValue('tip')
  tip,
  
  @JsonValue('warning')
  warning,
  
  @JsonValue('danger')
  danger,
  
  @JsonValue('success')
  success,
  
  @JsonValue('note')
  note,
}

@freezed
class ImageBlockData with _$ImageBlockData {
  const factory ImageBlockData({
    required String url,
    String? alt,
    String? caption,
    int? width,
    int? height,
  }) = _ImageBlockData;

  factory ImageBlockData.fromJson(Map<String, dynamic> json) =>
      _$ImageBlockDataFromJson(json);
}

@freezed
class ListBlockData with _$ListBlockData {
  const factory ListBlockData({
    required List<String> items,
    @Default(ListType.unordered) ListType type,
  }) = _ListBlockData;

  factory ListBlockData.fromJson(Map<String, dynamic> json) =>
      _$ListBlockDataFromJson(json);
}

enum ListType {
  @JsonValue('ordered')
  ordered,
  
  @JsonValue('unordered')
  unordered,
  
  @JsonValue('checklist')
  checklist,
}

@freezed
class QuoteBlockData with _$QuoteBlockData {
  const factory QuoteBlockData({
    required String text,
    String? author,
    String? source,
  }) = _QuoteBlockData;

  factory QuoteBlockData.fromJson(Map<String, dynamic> json) =>
      _$QuoteBlockDataFromJson(json);
}

@freezed
class TableBlockData with _$TableBlockData {
  const factory TableBlockData({
    required List<String> headers,
    required List<List<String>> rows,
    String? caption,
  }) = _TableBlockData;

  factory TableBlockData.fromJson(Map<String, dynamic> json) =>
      _$TableBlockDataFromJson(json);
}

@freezed
class StepsBlockData with _$StepsBlockData {
  const factory StepsBlockData({
    required List<StepItem> steps,
  }) = _StepsBlockData;

  factory StepsBlockData.fromJson(Map<String, dynamic> json) =>
      _$StepsBlockDataFromJson(json);
}

@freezed
class StepItem with _$StepItem {
  const factory StepItem({
    required String title,
    required String content,
    String? code,
  }) = _StepItem;

  factory StepItem.fromJson(Map<String, dynamic> json) =>
      _$StepItemFromJson(json);
}
