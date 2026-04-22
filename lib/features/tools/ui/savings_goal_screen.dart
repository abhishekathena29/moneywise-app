import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../providers/tools_provider.dart';
import 'tool_shared.dart';

class SavingsGoalScreen extends StatelessWidget {
  const SavingsGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = context.watch<ToolsProvider>();
    final wide = isWideLayout(context, 980);

    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolHeader(
              title: 'Savings Goal Calculator',
              onBack: () =>
                  context.read<NavigationProvider>().openTab(MainTab.tools),
            ),
            const SizedBox(height: 24),
            const SectionEyebrow('Dream Big, Save Smart'),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'The Savings ',
                children: [
                  TextSpan(
                    text: 'Goal Builder',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFFA06600),
                    ),
                  ),
                ],
              ),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFF006184),
              ),
            ),
            const SizedBox(height: 22),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: _GoalInputCard(tools: tools)),
                  const SizedBox(width: 16),
                  Expanded(flex: 5, child: _GoalSideCards(tools: tools)),
                ],
              )
            else ...[
              _GoalInputCard(tools: tools),
              const SizedBox(height: 16),
              _GoalSideCards(tools: tools),
            ],
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'Start This Journey',
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                context.read<DashboardProvider>().applySavingsGoal(
                  title: tools.goalName,
                  target: tools.goalAmount,
                  initialSaved: tools.goalAmount * .25,
                );
                context.read<NavigationProvider>().openTab(MainTab.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalInputCard extends StatelessWidget {
  const _GoalInputCard({required this.tools});

  final ToolsProvider tools;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EEFF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.sports_esports_rounded,
                  color: Color(0xFF006184),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: TextFormField(
                  initialValue: tools.goalName,
                  onChanged: context.read<ToolsProvider>().setGoalName,
                  decoration: const InputDecoration(
                    labelText: 'What are you saving for?',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFF006184),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _SliderBlock(
            label: 'Target Price',
            value: '₹${tools.goalAmount.toStringAsFixed(0)}',
            minLabel: '₹1',
            maxLabel: '₹500',
            currentValue: tools.goalAmount,
            min: 1,
            max: 500,
            onChanged: context.read<ToolsProvider>().setGoalAmount,
          ),
          const SizedBox(height: 28),
          _SliderBlock(
            label: 'How fast do you want it?',
            value: '${tools.goalWeeks.toStringAsFixed(0)} Weeks',
            minLabel: '1 week',
            maxLabel: '52 weeks',
            currentValue: tools.goalWeeks,
            min: 1,
            max: 52,
            onChanged: context.read<ToolsProvider>().setGoalWeeks,
          ),
        ],
      ),
    );
  }
}

class _GoalSideCards extends StatelessWidget {
  const _GoalSideCards({required this.tools});

  final ToolsProvider tools;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SurfaceCard(
          color: const Color(0xFFFFF2E2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Financial Fact!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFA06600),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Saving a little every week feels smaller and works better than waiting for one big deposit.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF653E00),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SurfaceCard(
          color: const Color(0xFFE7FFF7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionEyebrow('Weekly Savings Required'),
              const SizedBox(height: 10),
              Text(
                '₹${tools.weeklySavingRequired.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: const Color(0xFF006B5F),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'That’s your pace to hit this goal on time.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF3F484E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SliderBlock extends StatelessWidget {
  const _SliderBlock({
    required this.label,
    required this.value,
    required this.minLabel,
    required this.maxLabel,
    required this.currentValue,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String minLabel;
  final String maxLabel;
  final double currentValue;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: const Color(0xFF3F484E)),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF006184),
              ),
            ),
          ],
        ),
        Slider(
          value: currentValue,
          min: min,
          max: max,
          activeColor: const Color(0xFF006184),
          inactiveColor: const Color(0xFF76F4E0),
          onChanged: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              minLabel,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFF3F484E)),
            ),
            Text(
              maxLabel,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFF3F484E)),
            ),
          ],
        ),
      ],
    );
  }
}
