import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final dashboard = context.watch<DashboardProvider>();

    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassTopBar(
              title: 'Home',
              leading: _Avatar(name: auth.userName),
              trailing: IconCircleButton(
                icon: Icons.emoji_events_rounded,
                onTap: () => context
                    .read<NavigationProvider>()
                    .openTab(MainTab.profile),
              ),
            ),
            const SizedBox(height: 18),
            const SectionEyebrow('Good to see you'),
            const SizedBox(height: 6),
            Text(
              'Hi ${auth.userName} 👋',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    icon: Icons.local_fire_department_rounded,
                    value: '${dashboard.streakDays}',
                    label: 'DAY STREAK',
                    color: const Color(0xFFE8A33D),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _MetricCard(
                    icon: Icons.monetization_on_rounded,
                    value: '${dashboard.coins}',
                    label: 'COINS',
                    color: const Color(0xFF2BB673),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DailyGoalCard(dashboard: dashboard),
            const SizedBox(height: 12),
            SurfaceCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionEyebrow('Savings goal'),
                            const SizedBox(height: 6),
                            Text(
                              dashboard.savingsTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      ProgressPill(
                        label:
                            '₹${dashboard.savingsCurrent.toStringAsFixed(0)} /',
                        value:
                            '₹${dashboard.savingsTarget.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: dashboard.goalProgress,
                      backgroundColor: const Color(0xFFEFF3F8),
                      valueColor:
                          const AlwaysStoppedAnimation(kBrandPrimary),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Keep it up',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${(dashboard.goalProgress * 100).round()}% saved',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'Add savings',
                    onPressed: context.read<DashboardProvider>().addSavings,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SurfaceCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: kBrandSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: kBrandPrimary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionEyebrow('Current lesson'),
                            const SizedBox(height: 2),
                            Text(
                              'The power of interest',
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'How money can grow while you wait.',
                              style:
                                  Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'Continue lesson',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => context
                        .read<NavigationProvider>()
                        .openTab(MainTab.lessons),
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: kBrandPrimary,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        name.isEmpty ? '?' : name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _DailyGoalCard extends StatelessWidget {
  const _DailyGoalCard({required this.dashboard});

  final DashboardProvider dashboard;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionEyebrow('Daily goal'),
                const SizedBox(height: 6),
                Text(
                  'Learn ${dashboard.dailyGoalTarget} new things',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'So close — one more to go!',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GoalRing(
            progress: dashboard.dailyGoalCompleted / dashboard.dailyGoalTarget,
            label:
                '${dashboard.dailyGoalCompleted}/${dashboard.dailyGoalTarget}',
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
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
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: kBrandMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: .6,
            ),
          ),
        ],
      ),
    );
  }
}
