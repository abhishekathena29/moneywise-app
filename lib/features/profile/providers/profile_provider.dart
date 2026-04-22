import 'package:flutter/material.dart';

import '../../../core/models/app_models.dart';
import '../../../core/models/user_app_data.dart';
import '../../user_data/providers/user_data_provider.dart';

class ProfileProvider extends ChangeNotifier {
  static const List<BadgeItem> _allBadges = [
    BadgeItem('Smart Saver', Icons.stars_rounded, Color(0xFFA06600)),
    BadgeItem('Budget Boss', Icons.pie_chart_rounded, Color(0xFF006184)),
    BadgeItem('Goal Crusher', Icons.rocket_launch_rounded, Color(0xFF006B5F)),
    BadgeItem('Quiz Champ', Icons.psychology_alt_rounded, Color(0xFF007BA7)),
    BadgeItem(
      'Streak Star',
      Icons.local_fire_department_rounded,
      Color(0xFFA06600),
    ),
    BadgeItem(
      'Coin Collector',
      Icons.monetization_on_rounded,
      Color(0xFF006B5F),
    ),
  ];

  UserDataProvider? _userDataProvider;

  ProfileBadgesData get _profileBadges =>
      _userDataProvider?.data?.profileBadges ??
      AppUserData.initial(email: '', name: 'Alex').profileBadges;

  List<BadgeItem> get badges => _allBadges
      .where((badge) => _profileBadges.earnedBadgeTitles.contains(badge.title))
      .toList(growable: false);

  void bind(UserDataProvider provider) {
    _userDataProvider = provider;
    notifyListeners();
  }

  Future<void> awardBadge(String badgeTitle) async {
    final badges = {..._profileBadges.earnedBadgeTitles, badgeTitle}.toList();
    await _userDataProvider?.updateBadges(
      _profileBadges.copyWith(earnedBadgeTitles: badges),
    );
  }
}
