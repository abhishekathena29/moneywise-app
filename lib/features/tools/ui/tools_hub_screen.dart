import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/tools_provider.dart';

class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final tools = context.watch<ToolsProvider>();

    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassTopBar(
              title: 'Tools',
              leading: _Avatar(name: auth.userName),
            ),
            const SizedBox(height: 16),
            Text(
              'Money tools',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Plan, track, and practice good money habits.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            for (var i = 0; i < tools.tools.length; i++) ...[
              _ToolTile(
                title: tools.tools[i].title,
                subtitle: tools.tools[i].subtitle,
                icon: tools.tools[i].icon,
                onTap: () => _openTool(context, i),
              ),
              if (i != tools.tools.length - 1) const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  void _openTool(BuildContext context, int index) {
    final route = switch (index) {
      0 => AppRoute.monthlyTracker,
      1 => AppRoute.savingsGoalCalculator,
      2 => AppRoute.weeklySpendingTracker,
      3 => AppRoute.familyBudgetSimulator,
      4 => AppRoute.impulseBuyingPlan,
      5 => AppRoute.paymentMethodScenarios,
      _ => AppRoute.motivationToolkit,
    };
    context.read<NavigationProvider>().goTo(route);
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

class _ToolTile extends StatelessWidget {
  const _ToolTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: SurfaceCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: kBrandSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: kBrandPrimary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded, color: kBrandInk),
            ],
          ),
        ),
      ),
    );
  }
}
