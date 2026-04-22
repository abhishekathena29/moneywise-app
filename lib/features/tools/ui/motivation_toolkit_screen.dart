import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/tools_provider.dart';
import 'tool_shared.dart';

class MotivationToolkitScreen extends StatelessWidget {
  const MotivationToolkitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = context.watch<ToolsProvider>();
    final wide = isWideLayout(context, 920);
    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolHeader(
              title: 'Motivation Toolkit',
              onBack: () =>
                  context.read<NavigationProvider>().openTab(MainTab.tools),
            ),
            const SizedBox(height: 24),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _VisualRemindersCard(tools: tools)),
                  const SizedBox(width: 14),
                  Expanded(child: _SupportSystemCard(tools: tools)),
                ],
              )
            else ...[
              _VisualRemindersCard(tools: tools),
              const SizedBox(height: 14),
              _SupportSystemCard(tools: tools),
            ],
            const SizedBox(height: 14),
            _SelfRewardsCard(tools: tools),
            const SizedBox(height: 20),
            Text(
              'Rate Saving Methods (1-5 stars)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Column(
                children: [
                  _RatingHeaderRow(),
                  const Divider(),
                  for (var i = 0; i < tools.methodRatings.length; i++) ...[
                    _RatingRow(index: i),
                    if (i != tools.methodRatings.length - 1) const Divider(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisualRemindersCard extends StatelessWidget {
  const _VisualRemindersCard({required this.tools});

  final ToolsProvider tools;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visual Reminders',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Picture of my goal item',
            value: tools.goalItemPicture,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(goalItemPictureValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Where I’ll put it',
            value: tools.goalPictureLocation,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(goalPictureLocationValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Progress chart location',
            value: tools.progressChartLocation,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(progressChartLocationValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Motivational quote',
            value: tools.motivationalQuote,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(motivationalQuoteValue: value),
          ),
        ],
      ),
    );
  }
}

class _SupportSystemCard extends StatelessWidget {
  const _SupportSystemCard({required this.tools});

  final ToolsProvider tools;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Support System', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Person who will encourage me',
            value: tools.supportPerson,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(supportPersonValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'How often they’ll check in',
            value: tools.supportCheckin,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(supportCheckinValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'What they should ask me',
            value: tools.supportQuestion,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(supportQuestionValue: value),
          ),
        ],
      ),
    );
  }
}

class _SelfRewardsCard extends StatelessWidget {
  const _SelfRewardsCard({required this.tools});

  final ToolsProvider tools;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      color: const Color(0xFFF0F3FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Self-Rewards', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Daily reward for saving',
            value: tools.dailyReward,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(dailyRewardValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Weekly reward for meeting goal',
            value: tools.weeklyReward,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(weeklyRewardValue: value),
          ),
          const SizedBox(height: 12),
          _ToolkitField(
            label: 'Monthly progress celebration',
            value: tools.monthlyCelebration,
            onChanged: (value) => context
                .read<ToolsProvider>()
                .updateMotivationField(monthlyCelebrationValue: value),
          ),
        ],
      ),
    );
  }
}

class _ToolkitField extends StatelessWidget {
  const _ToolkitField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _RatingHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Method')),
          Expanded(flex: 2, child: Text('Easy to Use')),
          Expanded(flex: 2, child: Text('Motivating')),
          Expanded(flex: 2, child: Text('Avoid Spending')),
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final rating = context.watch<ToolsProvider>().methodRatings[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 760) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rating.method,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                _CompactRating(
                  label: 'Easy to Use',
                  value: rating.easyToUse,
                  onChanged: (value) => context
                      .read<ToolsProvider>()
                      .updateMethodRating(index: index, easyToUse: value),
                ),
                _CompactRating(
                  label: 'Motivating',
                  value: rating.motivating,
                  onChanged: (value) => context
                      .read<ToolsProvider>()
                      .updateMethodRating(index: index, motivating: value),
                ),
                _CompactRating(
                  label: 'Avoid Spending',
                  value: rating.helpsAvoidSpending,
                  onChanged: (value) =>
                      context.read<ToolsProvider>().updateMethodRating(
                        index: index,
                        helpsAvoidSpending: value,
                      ),
                ),
              ],
            );
          }
          return Row(
            children: [
              Expanded(flex: 3, child: Text(rating.method)),
              Expanded(
                flex: 2,
                child: StarRatingField(
                  value: rating.easyToUse,
                  onChanged: (value) => context
                      .read<ToolsProvider>()
                      .updateMethodRating(index: index, easyToUse: value),
                ),
              ),
              Expanded(
                flex: 2,
                child: StarRatingField(
                  value: rating.motivating,
                  onChanged: (value) => context
                      .read<ToolsProvider>()
                      .updateMethodRating(index: index, motivating: value),
                ),
              ),
              Expanded(
                flex: 2,
                child: StarRatingField(
                  value: rating.helpsAvoidSpending,
                  onChanged: (value) =>
                      context.read<ToolsProvider>().updateMethodRating(
                        index: index,
                        helpsAvoidSpending: value,
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CompactRating extends StatelessWidget {
  const _CompactRating({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          StarRatingField(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
