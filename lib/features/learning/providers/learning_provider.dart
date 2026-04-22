import 'package:flutter/material.dart';

import '../../../core/models/app_models.dart';
import '../../../core/models/user_app_data.dart';
import '../../user_data/providers/user_data_provider.dart';

class LearningProvider extends ChangeNotifier {
  static const List<ModuleProgress> _baseModules = [
    ModuleProgress(
      title: 'Money Basics',
      description:
          'Discover what money is and how it moves through daily life.',
      progress: 0.85,
      icon: Icons.payments_rounded,
      accent: Color(0xFF006B5F),
      isLocked: false,
    ),
    ModuleProgress(
      title: 'Saving & Budgeting',
      description:
          'Build smart habits with goals, plans, and weekly check-ins.',
      progress: 0.62,
      icon: Icons.savings_rounded,
      accent: Color(0xFF006184),
      isLocked: false,
    ),
    ModuleProgress(
      title: 'Needs vs Wants',
      description: 'Practice making stronger spending choices every day.',
      progress: 0.34,
      icon: Icons.balance_rounded,
      accent: Color(0xFFA06600),
      isLocked: false,
    ),
    ModuleProgress(
      title: 'Mini Investor Lab',
      description: 'Advanced lessons about growth, patience, and value.',
      progress: 0.0,
      icon: Icons.auto_graph_rounded,
      accent: Color(0xFF6F787F),
      isLocked: true,
    ),
  ];

  UserDataProvider? _userDataProvider;

  LearningData get _learning =>
      _userDataProvider?.data?.learning ??
      AppUserData.initial(email: '', name: 'Alex').learning;

  List<ModuleProgress> get modules => _baseModules
      .map(
        (module) => ModuleProgress(
          title: module.title,
          description: module.description,
          progress: _learning.moduleProgress[module.title] ?? module.progress,
          icon: module.icon,
          accent: module.accent,
          isLocked: module.isLocked,
        ),
      )
      .toList(growable: false);

  void bind(UserDataProvider provider) {
    _userDataProvider = provider;
    notifyListeners();
  }

  Future<void> updateModuleProgress(String title, double progress) async {
    final updated = Map<String, double>.from(_learning.moduleProgress)
      ..[title] = progress;
    await _userDataProvider?.updateLearning(
      _learning.copyWith(moduleProgress: updated),
    );
  }
}
