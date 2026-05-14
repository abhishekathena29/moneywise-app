import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/lesson_module.dart';
import 'module_catalog.dart';
import 'quiz_bank.dart';

class LessonRepository {
  LessonRepository._();

  static final LessonRepository instance = LessonRepository._();

  List<LessonModule>? _cached;

  Future<List<LessonModule>> load() async {
    if (_cached != null) return _cached!;
    final raw = await rootBundle.loadString('assets/data/modules.json');
    final decoded = json.decode(raw) as Map<String, dynamic>;
    final list = (decoded['modules'] as List)
        .map((item) => _parseModule(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false);
    _cached = list;
    return list;
  }

  LessonModule _parseModule(Map<String, dynamic> json) {
    final id = (json['id'] ?? '') as String;
    final visual = moduleVisuals[id];
    final parts = quizBank[id] ?? const <QuizPart>[];
    // The dataset's free-form "quiz" sections are skipped — they are
    // replaced by curated MCQs in [quizBank].
    final sections = ((json['sections'] as List?) ?? const [])
        .where((s) => (s as Map)['type'] != 'quiz')
        .map((s) => LessonSection.fromJson(Map<String, dynamic>.from(s as Map)))
        .toList(growable: false);
    final badge =
        Map<String, dynamic>.from(json['badge'] as Map? ?? const {});
    return LessonModule(
      id: id,
      title: (json['title'] ?? '') as String,
      shortTitle: visual?.shortTitle ?? (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      duration: (json['duration'] ?? '') as String,
      difficulty: (json['difficulty'] ?? '') as String,
      topics: ((json['topics'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      learningObjectives: ((json['learningObjectives'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      colorTheme: (json['colorTheme'] ?? 'primary') as String,
      badgeTitle: (badge['title'] ?? '') as String,
      badgeType: (badge['type'] ?? '') as String,
      sections: sections,
      quizParts: parts,
      icon: visual?.icon ?? Icons.school_rounded,
      accent: visual?.accent ?? const Color(0xFF006184),
    );
  }
}
