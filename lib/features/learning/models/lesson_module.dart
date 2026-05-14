import 'package:flutter/material.dart';

class LessonModule {
  const LessonModule({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.topics,
    required this.learningObjectives,
    required this.colorTheme,
    required this.badgeTitle,
    required this.badgeType,
    required this.sections,
    required this.quizParts,
    required this.icon,
    required this.accent,
  });

  final String id;
  final String title;
  final String shortTitle;
  final String description;
  final String duration;
  final String difficulty;
  final List<String> topics;
  final List<String> learningObjectives;
  final String colorTheme;
  final String badgeTitle;
  final String badgeType;
  final List<LessonSection> sections;
  final List<QuizPart> quizParts;
  final IconData icon;
  final Color accent;

  /// All gradable (MCQ-style) questions across every part. The unlock gate
  /// (>50%) is calculated only against these.
  List<QuizItem> get gradableQuestions => [
        for (final part in quizParts)
          for (final item in part.items)
            if (item.type == QuizItemType.mcq && item.correctIndex != null)
              item
      ];

  int get totalSteps => sections.length + 1; // +1 for the quiz
}

class LessonSection {
  const LessonSection({
    required this.id,
    required this.title,
    required this.type,
    required this.duration,
    required this.text,
    required this.image,
    required this.keyPoints,
    required this.activity,
    required this.reward,
    required this.downloadLink,
    required this.downloadText,
  });

  final String id;
  final String title;
  final String type;
  final String duration;
  final String text;
  final String image;
  final List<String> keyPoints;
  final String activity;
  final String reward;
  final String downloadLink;
  final String downloadText;

  bool get isActivity => type == 'activity';
  bool get isQuiz => type == 'quiz';

  factory LessonSection.fromJson(Map<String, dynamic> json) {
    final content =
        Map<String, dynamic>.from(json['content'] as Map? ?? const {});
    return LessonSection(
      id: (json['id'] ?? '') as String,
      title: (json['title'] ?? '') as String,
      type: (json['type'] ?? 'content') as String,
      duration: (json['duration'] ?? '') as String,
      text: (content['text'] ?? '') as String,
      image: (content['image'] ?? '') as String,
      keyPoints: ((content['keyPoints'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      activity: (content['activity'] ?? '') as String,
      reward: (content['reward'] ?? '') as String,
      downloadLink: (content['downloadLink'] ?? '') as String,
      downloadText: (content['downloadText'] ?? '') as String,
    );
  }
}

/// One labelled section of the worksheet (e.g. "Part A: Multiple Choice").
class QuizPart {
  const QuizPart({
    required this.id,
    required this.title,
    required this.emoji,
    this.intro = '',
    required this.items,
  });

  final String id;
  final String title;
  final String emoji;
  final String intro;
  final List<QuizItem> items;
}

enum QuizItemType {
  /// Single-correct multiple choice — auto-graded toward the unlock gate.
  mcq,

  /// True / False — also auto-graded if a correctIndex is provided.
  trueFalse,

  /// Free-form short answer (one text field).
  shortAnswer,

  /// Free-form long answer (multi-line text field).
  longAnswer,

  /// Multiple labelled blanks the learner fills in (a, b, c …).
  fillBlanks,

  /// A list of items that the learner classifies (e.g. Want / Need / Both).
  classify,

  /// A numeric or short text field for a calculation.
  numeric,

  /// A 1-5 self-rating row.
  rating,

  /// Pure prompt with no input — used for instructions / scenario intros.
  prompt,
}

class QuizItem {
  const QuizItem({
    required this.id,
    required this.type,
    required this.prompt,
    this.subtitle = '',
    this.options = const [],
    this.correctIndex,
    this.blankLabels = const [],
    this.classifyOptions = const [],
    this.explanation = '',
    this.helper = '',
  });

  /// Multiple choice helper.
  const QuizItem.mcq({
    required String id,
    required String prompt,
    required List<String> options,
    required int correctIndex,
    String explanation = '',
  }) : this(
          id: id,
          type: QuizItemType.mcq,
          prompt: prompt,
          options: options,
          correctIndex: correctIndex,
          explanation: explanation,
        );

  const QuizItem.trueFalse({
    required String id,
    required String prompt,
    required int correctIndex,
    String explanation = '',
  }) : this(
          id: id,
          type: QuizItemType.trueFalse,
          prompt: prompt,
          options: const ['True', 'False'],
          correctIndex: correctIndex,
          explanation: explanation,
        );

  const QuizItem.shortAnswer({
    required String id,
    required String prompt,
    String helper = '',
  }) : this(
          id: id,
          type: QuizItemType.shortAnswer,
          prompt: prompt,
          helper: helper,
        );

  const QuizItem.longAnswer({
    required String id,
    required String prompt,
    String helper = '',
  }) : this(
          id: id,
          type: QuizItemType.longAnswer,
          prompt: prompt,
          helper: helper,
        );

  const QuizItem.fillBlanks({
    required String id,
    required String prompt,
    required List<String> blankLabels,
    String helper = '',
  }) : this(
          id: id,
          type: QuizItemType.fillBlanks,
          prompt: prompt,
          blankLabels: blankLabels,
          helper: helper,
        );

  const QuizItem.classify({
    required String id,
    required String prompt,
    required List<String> blankLabels,
    required List<String> classifyOptions,
    String helper = '',
  }) : this(
          id: id,
          type: QuizItemType.classify,
          prompt: prompt,
          blankLabels: blankLabels,
          classifyOptions: classifyOptions,
          helper: helper,
        );

  const QuizItem.numeric({
    required String id,
    required String prompt,
    required List<String> blankLabels,
    String helper = '',
  }) : this(
          id: id,
          type: QuizItemType.numeric,
          prompt: prompt,
          blankLabels: blankLabels,
          helper: helper,
        );

  const QuizItem.rating({
    required String id,
    required String prompt,
    required List<String> blankLabels,
    String helper = '',
  }) : this(
          id: id,
          type: QuizItemType.rating,
          prompt: prompt,
          blankLabels: blankLabels,
          helper: helper,
        );

  const QuizItem.prompt({
    required String id,
    required String prompt,
    String subtitle = '',
  }) : this(
          id: id,
          type: QuizItemType.prompt,
          prompt: prompt,
          subtitle: subtitle,
        );

  final String id;
  final QuizItemType type;
  final String prompt;
  final String subtitle;
  final List<String> options;
  final int? correctIndex;
  final List<String> blankLabels;
  final List<String> classifyOptions;
  final String explanation;
  final String helper;

  bool get isGraded => type == QuizItemType.mcq && correctIndex != null;
}

/// Backwards-compatible alias so older imports (`QuizQuestion`) still work.
typedef QuizQuestion = QuizItem;
