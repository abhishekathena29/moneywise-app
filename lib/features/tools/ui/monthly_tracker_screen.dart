import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/models/app_models.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/tools_provider.dart';
import 'tool_shared.dart';

class MonthlyTrackerScreen extends StatelessWidget {
  const MonthlyTrackerScreen({super.key});

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
              title: 'Monthly Tracker',
              onBack: () =>
                  context.read<NavigationProvider>().openTab(MainTab.tools),
            ),
            const SizedBox(height: 16),
            SurfaceCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionEyebrow('Current balance'),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${tools.monthlyBalance.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(color: kBrandPrimary),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F8F0),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up_rounded,
                              color: Color(0xFF2BB673),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '+12%',
                              style: TextStyle(
                                color: Color(0xFF2BB673),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    icon: Icons.arrow_downward_rounded,
                    label: 'Income',
                    value: '+₹${tools.monthlyIncome.toStringAsFixed(0)}',
                    color: const Color(0xFF2BB673),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    icon: Icons.arrow_upward_rounded,
                    label: 'Spent',
                    value: '-₹${tools.monthlySpent.toStringAsFixed(0)}',
                    color: const Color(0xFFE8A33D),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SurfaceCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where it goes',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ...tools.monthlyCategories.map(
                    (item) => _SpendBar(item: item),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: () => _showAddEntry(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ...tools.monthlyEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _HistoryTile(entry: entry),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddEntry(BuildContext context) async {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    var isIncome = false;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 18,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: StatefulBuilder(
            builder: (ctx, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6EAF0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Add entry',
                  style: Theme.of(ctx).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _TypeChip(
                        label: 'Expense',
                        selected: !isIncome,
                        onTap: () => setState(() => isIncome = false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _TypeChip(
                        label: 'Income',
                        selected: isIncome,
                        onTap: () => setState(() => isIncome = true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Save entry',
                  icon: Icons.check_rounded,
                  onPressed: () async {
                    final amount =
                        double.tryParse(amountController.text.trim()) ?? 0;
                    if (titleController.text.trim().isEmpty || amount <= 0) {
                      Navigator.of(ctx).pop();
                      return;
                    }
                    await context.read<ToolsProvider>().addMonthlyEntry(
                      title: titleController.text.trim(),
                      amount: amount,
                      isIncome: isIncome,
                    );
                    if (ctx.mounted) Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? kBrandPrimary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? kBrandPrimary : const Color(0xFFE6EAF0),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : kBrandInk,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SpendBar extends StatelessWidget {
  const _SpendBar({required this.item});

  final SpendCategory item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: item.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: kBrandInk,
                    ),
                  ),
                ],
              ),
              Text(
                '${item.percent.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: kBrandMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: item.percent / 100,
              backgroundColor: const Color(0xFFEFF3F8),
              valueColor: AlwaysStoppedAnimation(item.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});

  final TrackerEntry entry;

  @override
  Widget build(BuildContext context) {
    final positive = entry.isIncome;
    final color =
        positive ? const Color(0xFF2BB673) : const Color(0xFFE8A33D);
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              positive
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  entry.day,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '${positive ? '+' : '-'}₹${entry.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
