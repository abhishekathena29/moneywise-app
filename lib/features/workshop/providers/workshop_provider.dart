import 'package:flutter/material.dart';

import '../../../core/models/user_app_data.dart';
import '../../user_data/providers/user_data_provider.dart';

class WorkshopProvider extends ChangeNotifier {
  UserDataProvider? _userDataProvider;

  WorkshopData get _workshop =>
      _userDataProvider?.data?.workshop ??
      AppUserData.initial(email: '', name: 'Alex').workshop;

  int get selectedIndex => _workshop.selectedIndex;
  bool get submitted => _workshop.submitted;
  bool get rewardApplied => _workshop.rewardApplied;
  int get step => 4;
  int get totalSteps => 6;
  bool get isCorrect => selectedIndex == 0;

  void bind(UserDataProvider provider) {
    _userDataProvider = provider;
    notifyListeners();
  }

  Future<void> selectOption(int index) async {
    await _userDataProvider?.updateWorkshop(
      _workshop.copyWith(selectedIndex: index),
    );
  }

  Future<bool> submit() async {
    if (selectedIndex == -1) {
      return false;
    }
    await _userDataProvider?.updateWorkshop(
      _workshop.copyWith(submitted: true),
    );
    return true;
  }

  Future<void> markRewardApplied() async {
    await _userDataProvider?.updateWorkshop(
      _workshop.copyWith(rewardApplied: true),
    );
  }

  Future<void> reset() async {
    await _userDataProvider?.updateWorkshop(
      const WorkshopData(
        selectedIndex: -1,
        submitted: false,
        rewardApplied: false,
      ),
    );
  }
}
