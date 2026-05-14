import 'package:flutter/material.dart';

import '../../../core/models/user_app_data.dart';
import '../../user_data/providers/user_data_provider.dart';
import '../data/lesson_repository.dart';
import '../models/lesson_module.dart' show LessonModule;

class LearningProvider extends ChangeNotifier {
  LearningProvider() {
    _loadModules();
  }

  UserDataProvider? _userDataProvider;
  List<LessonModule> _modules = const [];
  bool _isLoading = true;

  List<LessonModule> get modules => _modules;
  bool get isLoading => _isLoading;

  LearningData get _learning =>
      _userDataProvider?.data?.learning ?? LearningData.initial();

  Future<void> _loadModules() async {
    try {
      _modules = await LessonRepository.instance.load();
    } catch (_) {
      _modules = const [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void bind(UserDataProvider provider) {
    _userDataProvider = provider;
    notifyListeners();
  }

  // ---------- Gate logic ----------

  bool isModuleUnlocked(String moduleId) {
    if (_modules.isEmpty) return false;
    final index = _modules.indexWhere((m) => m.id == moduleId);
    if (index <= 0) return true; // first module always unlocked
    final previous = _modules[index - 1];
    return _learning.passedModuleIds.contains(previous.id);
  }

  bool isModulePassed(String moduleId) =>
      _learning.passedModuleIds.contains(moduleId);

  double progressFor(String moduleId) =>
      _learning.moduleProgress[moduleId] ?? 0.0;

  List<String> completedSectionsFor(String moduleId) =>
      List<String>.from(_learning.completedSectionIds[moduleId] ?? const []);

  double? quizScoreFor(String moduleId) => _learning.quizScores[moduleId];

  bool get allModulesPassed =>
      _modules.isNotEmpty &&
      _modules.every((m) => _learning.passedModuleIds.contains(m.id));

  bool get hasCertificate => _learning.certificateIssuedAt != null;
  String? get certificateIssuedAt => _learning.certificateIssuedAt;

  // ---------- Mutations ----------

  Future<void> markSectionComplete(String moduleId, String sectionId) async {
    final module = _modules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => throw StateError('Module $moduleId not found'),
    );
    final current = Set<String>.from(_learning.completedSectionIds[moduleId] ??
        const <String>[]);
    if (!current.add(sectionId)) {
      return; // already complete
    }
    final allSectionIds = module.sections.map((s) => s.id).toSet();
    final sectionsDone = current.intersection(allSectionIds).length;
    final passed = _learning.passedModuleIds.contains(moduleId);
    // Each section is 1/totalSteps; quiz counts as the final step.
    final progress = (sectionsDone + (passed ? 1 : 0)) / module.totalSteps;
    final completed =
        Map<String, List<String>>.from(_learning.completedSectionIds)
          ..[moduleId] = current.toList();
    final progresses = Map<String, double>.from(_learning.moduleProgress)
      ..[moduleId] = progress.clamp(0.0, 1.0);
    await _userDataProvider?.updateLearning(
      _learning.copyWith(
        completedSectionIds: completed,
        moduleProgress: progresses,
      ),
    );
  }

  /// Records a quiz result. Returns true when score is > 50% (the unlock gate).
  Future<bool> submitQuizResult(String moduleId, double scorePercent) async {
    final module = _modules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => throw StateError('Module $moduleId not found'),
    );
    final passed = scorePercent > 50;
    final scores = Map<String, double>.from(_learning.quizScores)
      ..[moduleId] = scorePercent;
    final passedIds =
        Set<String>.from(_learning.passedModuleIds);
    if (passed) {
      passedIds.add(moduleId);
    } else {
      passedIds.remove(moduleId);
    }
    final sectionsDone =
        (_learning.completedSectionIds[moduleId] ?? const <String>[]).length;
    final progresses = Map<String, double>.from(_learning.moduleProgress);
    progresses[moduleId] =
        ((sectionsDone + (passed ? 1 : 0)) / module.totalSteps)
            .clamp(0.0, 1.0);

    String? certificate = _learning.certificateIssuedAt;
    final allPassed = _modules.every((m) => passedIds.contains(m.id));
    if (allPassed && certificate == null) {
      certificate = DateTime.now().toIso8601String();
    }

    await _userDataProvider?.updateLearning(
      _learning.copyWith(
        quizScores: scores,
        passedModuleIds: passedIds.toList(),
        moduleProgress: progresses,
        certificateIssuedAt: certificate,
      ),
    );
    return passed;
  }
}
