import 'package:flutter/material.dart';

import '../../../core/models/user_app_data.dart';
import '../../user_data/providers/user_data_provider.dart';

class DashboardProvider extends ChangeNotifier {
  UserDataProvider? _userDataProvider;

  DashboardData get _dashboard =>
      _userDataProvider?.data?.dashboard ??
      AppUserData.initial(email: '', name: 'Alex').dashboard;

  int get streakDays => _dashboard.streakDays;
  int get coins => _dashboard.coins;
  int get dailyGoalTarget => _dashboard.dailyGoalTarget;
  int get dailyGoalCompleted => _dashboard.dailyGoalCompleted;
  double get savingsCurrent => _dashboard.savingsCurrent;
  double get savingsTarget => _dashboard.savingsTarget;
  String get savingsTitle => _dashboard.savingsTitle;

  double get goalProgress =>
      (savingsCurrent / savingsTarget).clamp(0, 1).toDouble();

  void bind(UserDataProvider provider) {
    _userDataProvider = provider;
    notifyListeners();
  }

  Future<void> addSavings([double amount = 5]) async {
    final updated = _dashboard.copyWith(
      savingsCurrent: (savingsCurrent + amount)
          .clamp(0, savingsTarget)
          .toDouble(),
      coins: coins + amount.round(),
    );
    await _userDataProvider?.updateDashboard(updated);
  }

  Future<void> applySavingsGoal({
    required String title,
    required double target,
    required double initialSaved,
  }) async {
    await _userDataProvider?.updateDashboard(
      _dashboard.copyWith(
        savingsTitle: title,
        savingsTarget: target,
        savingsCurrent: initialSaved.clamp(0, target).toDouble(),
      ),
    );
  }

  Future<void> rewardWorkshopSuccess() async {
    await _userDataProvider?.updateDashboard(
      _dashboard.copyWith(coins: coins + 20, streakDays: streakDays + 1),
    );
  }
}
