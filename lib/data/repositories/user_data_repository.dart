import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/models/user_app_data.dart';

class UserDataRepository {
  UserDataRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _firestore.collection('users').doc(uid);

  Stream<AppUserData> watchUserData(String uid) {
    return _userDoc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return AppUserData.initial(email: '', name: 'Alex');
      }
      return AppUserData.fromMap(data);
    });
  }

  Future<void> ensureUserDocument({
    required String uid,
    required String email,
    required String name,
  }) async {
    final doc = _userDoc(uid);
    final snapshot = await doc.get();
    if (!snapshot.exists) {
      await doc.set(AppUserData.initial(email: email, name: name).toMap());
      return;
    }
    await doc.set({
      'profile': {'email': email, 'name': name},
    }, SetOptions(merge: true));
  }

  Future<void> updateDashboard(String uid, DashboardData data) async {
    await _userDoc(
      uid,
    ).set({'dashboard': data.toMap()}, SetOptions(merge: true));
  }

  Future<void> updateLearning(String uid, LearningData data) async {
    await _userDoc(
      uid,
    ).set({'learning': data.toMap()}, SetOptions(merge: true));
  }

  Future<void> updateTools(String uid, ToolsData data) async {
    await _userDoc(uid).set({'tools': data.toMap()}, SetOptions(merge: true));
  }

  Future<void> updateWorkshop(String uid, WorkshopData data) async {
    await _userDoc(
      uid,
    ).set({'workshop': data.toMap()}, SetOptions(merge: true));
  }

  Future<void> updateBadges(String uid, ProfileBadgesData data) async {
    await _userDoc(
      uid,
    ).set({'profileBadges': data.toMap()}, SetOptions(merge: true));
  }

  Future<void> updateProfile(String uid, UserProfileData data) async {
    await _userDoc(uid).set({'profile': data.toMap()}, SetOptions(merge: true));
  }
}
