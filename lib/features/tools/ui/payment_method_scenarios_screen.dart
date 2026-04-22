import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/tools_provider.dart';
import 'tool_shared.dart';

class PaymentMethodScenariosScreen extends StatelessWidget {
  const PaymentMethodScenariosScreen({super.key});

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
              title: 'Payment Method Scenarios',
              onBack: () =>
                  context.read<NavigationProvider>().openTab(MainTab.tools),
            ),
            const SizedBox(height: 24),
            Text(
              'Choose the best payment method for each scenario',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < tools.paymentScenarios.length; i++) ...[
              _PaymentScenarioCard(index: i),
              const SizedBox(height: 14),
            ],
            const SizedBox(height: 8),
            Text(
              'Safety Scenarios',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < tools.safetyScenarios.length; i++) ...[
              _SafetyScenarioCard(index: i),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _PaymentScenarioCard extends StatelessWidget {
  const _PaymentScenarioCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final scenario = context.watch<ToolsProvider>().paymentScenarios[index];
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(scenario.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            scenario.prompt,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3F484E)),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: scenario.paymentChoice.isEmpty
                ? null
                : scenario.paymentChoice,
            items: const ['Cash', 'UPI', 'Card']
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updatePaymentChoice(index, value ?? ''),
            decoration: const InputDecoration(labelText: 'Payment Choice'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: scenario.reason,
            onChanged: (value) =>
                context.read<ToolsProvider>().updatePaymentReason(index, value),
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Reason'),
          ),
        ],
      ),
    );
  }
}

class _SafetyScenarioCard extends StatelessWidget {
  const _SafetyScenarioCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final scenario = context.watch<ToolsProvider>().safetyScenarios[index];
    return SurfaceCard(
      color: const Color(0xFFF0F3FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(scenario.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            scenario.prompt,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3F484E)),
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: scenario.actionPlan,
            onChanged: (value) =>
                context.read<ToolsProvider>().updateSafetyAction(index, value),
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'What would you do?'),
          ),
        ],
      ),
    );
  }
}
