import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/tools_provider.dart';
import 'tool_shared.dart';

class FamilyBudgetSimulatorScreen extends StatelessWidget {
  const FamilyBudgetSimulatorScreen({super.key});

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
              title: 'Family Budget Simulator',
              onBack: () =>
                  context.read<NavigationProvider>().openTab(MainTab.tools),
            ),
            const SizedBox(height: 24),
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionEyebrow('Practice Budget'),
                  const SizedBox(height: 8),
                  Text(
                    '₹${tools.familyBudgetTotal.toStringAsFixed(0)} total',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFF006184),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...tools.familyBudget.entries.map(
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
                          value: entry.value / tools.familyBudgetTotal,
                          backgroundColor: const Color(0xFFE7EEFF),
                          valueColor: AlwaysStoppedAnimation(
                            entry.key == 'Needs'
                                ? const Color(0xFF006184)
                                : entry.key == 'Wants'
                                ? const Color(0xFFA06600)
                                : const Color(0xFF006B5F),
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
