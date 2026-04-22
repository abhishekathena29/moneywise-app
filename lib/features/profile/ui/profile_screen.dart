import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../../user_data/providers/user_data_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final dashboard = context.watch<DashboardProvider>();
    final profile = context.watch<ProfileProvider>();
    final userData = context.watch<UserDataProvider>().data;
    final profileName = userData?.profile.name ?? auth.userName;
    final impactScore = userData?.profile.impactScore ?? 850;

    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlassTopBar(title: 'Profile'),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: kBrandPrimary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      profileName.isEmpty
                          ? '?'
                          : profileName.characters.first.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profileName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level 12 · Financial Explorer',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SurfaceCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionEyebrow('Impact score'),
                  const SizedBox(height: 6),
                  Text(
                    '$impactScore',
                    style: Theme.of(context).textTheme.displayMedium
                        ?.copyWith(color: kBrandPrimary),
                  ),
                  Text(
                    'Keep learning to raise your score.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricTile(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Day streak',
                    value: '${dashboard.streakDays}',
                    color: const Color(0xFFE8A33D),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _MetricTile(
                    icon: Icons.savings_rounded,
                    label: 'Saved',
                    value:
                        '₹${(dashboard.savingsCurrent + 127.5).toStringAsFixed(0)}',
                    color: const Color(0xFF2BB673),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Badges',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns =
                    (constraints.maxWidth / 120).floor().clamp(3, 6);
                return GridView.builder(
                  itemCount: profile.badges.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    final badge = profile.badges[index];
                    return SurfaceCard(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: badge.color.withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child:
                                Icon(badge.icon, color: badge.color, size: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            badge.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: kBrandInk,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            SurfaceCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SupportTile(
                    icon: Icons.favorite_outline_rounded,
                    label: 'Saved goals',
                    onTap: () => context
                        .read<NavigationProvider>()
                        .goTo(AppRoute.savingsGoalCalculator),
                  ),
                  const Divider(height: 1),
                  _SupportTile(
                    icon: Icons.grid_view_rounded,
                    label: 'Tools',
                    onTap: () =>
                        context.read<NavigationProvider>().openTab(MainTab.tools),
                  ),
                  const Divider(height: 1),
                  _SupportTile(
                    icon: Icons.info_outline_rounded,
                    label: 'About the app',
                    onTap: () =>
                        context.read<NavigationProvider>().goTo(AppRoute.about),
                  ),
                  const Divider(height: 1),
                  _SupportTile(
                    icon: Icons.logout_rounded,
                    label: 'Sign out',
                    isDestructive: true,
                    onTap: () async {
                      final authProvider = context.read<AuthProvider>();
                      final navigation = context.read<NavigationProvider>();
                      await authProvider.signOut();
                      navigation.goTo(AppRoute.splash);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  const _SupportTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFBA1A1A) : kBrandInk;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
