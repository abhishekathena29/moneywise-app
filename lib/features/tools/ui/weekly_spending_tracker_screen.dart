import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/tools_provider.dart';
import 'tool_shared.dart';

class WeeklySpendingTrackerScreen extends StatelessWidget {
  const WeeklySpendingTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = context.watch<ToolsProvider>();
    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolHeader(
              title: 'Weekly Spending Tracker',
              onBack: () =>
                  context.read<NavigationProvider>().openTab(MainTab.tools),
            ),
            const SizedBox(height: 24),
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionEyebrow('Weekly Total'),
                  const SizedBox(height: 8),
                  Text(
                    '₹${tools.weeklyTotal.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFF006184),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...tools.weeklySpending.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '₹${entry.value.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: const Color(0xFF006184)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          minHeight: 12,
                          value: entry.value / tools.weeklyTotal,
                          backgroundColor: const Color(0xFFE7EEFF),
                          valueColor: const AlwaysStoppedAnimation(
                            Color(0xFF006184),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
