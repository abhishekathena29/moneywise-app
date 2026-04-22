import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/models/user_app_data.dart';
import '../../../data/repositories/user_data_repository.dart';
import '../../auth/providers/auth_provider.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataProvider(this._repository);

  UserDataProvider.fake()
      : _repository = null,
        _data = AppUserData.initial(email: '', name: 'Alex');

  final UserDataRepository? _repository;

  AppUserData? _data;
  StreamSubscription<AppUserData>? _subscription;
  String? _boundUid;
  bool _loading = false;

  AppUserData? get data => _data;
  bool get isLoading => _loading;
  bool get isReady => _data != null;

  void bindAuth(AuthProvider auth) {
    final uid = auth.uid;
    if (uid == _boundUid) {
      if (uid == null) {
        _data = null;
      }
      return;
    }

    _subscription?.cancel();
    _boundUid = uid;

    if (uid == null) {
      _data = null;
      _loading = false;
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();

    _subscription = _repository?.watchUserData(uid).listen((userData) {
      _data = userData;
      _loading = false;
      notifyListeners();
    });
  }

  Future<void> updateDashboard(DashboardData data) async {
    final uid = _boundUid;
    if (uid == null) return;
    _data = (_data ?? AppUserData.initial(email: '', name: 'Alex')).copyWith(
      dashboard: data,
    );
    notifyListeners();
    await _repository?.updateDashboard(uid, data);
  }

  Future<void> updateLearning(LearningData data) async {
    final uid = _boundUid;
    if (uid == null) return;
    _data = (_data ?? AppUserData.initial(email: '', name: 'Alex')).copyWith(
      learning: data,
    );
    notifyListeners();
    await _repository?.updateLearning(uid, data);
  }

  Future<void> updateTools(ToolsData data) async {
    final uid = _boundUid;
    if (uid == null) return;
    _data = (_data ?? AppUserData.initial(email: '', name: 'Alex')).copyWith(
      tools: data,
    );
    notifyListeners();
    await _repository?.updateTools(uid, data);
  }

  Future<void> updateWorkshop(WorkshopData data) async {
    final uid = _boundUid;
    if (uid == null) return;
    _data = (_data ?? AppUserData.initial(email: '', name: 'Alex')).copyWith(
      workshop: data,
    );
    notifyListeners();
    await _repository?.updateWorkshop(uid, data);
  }

  Future<void> updateBadges(ProfileBadgesData data) async {
    final uid = _boundUid;
    if (uid == null) return;
    _data = (_data ?? AppUserData.initial(email: '', name: 'Alex')).copyWith(
      profileBadges: data,
    );
    notifyListeners();
    await _repository?.updateBadges(uid, data);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
