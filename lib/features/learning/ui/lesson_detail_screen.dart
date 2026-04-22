import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/models/app_models.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/learning_provider.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title =
        context.watch<NavigationProvider>().selectedLessonTitle ?? '';
    final module = context
        .watch<LearningProvider>()
        .modules
        .firstWhere(
          (m) => m.title == title,
          orElse: () => const ModuleProgress(
            title: 'Lesson',
            description: '',
            progress: 0,
            icon: Icons.school_rounded,
            accent: kBrandPrimary,
            isLocked: false,
          ),
        );

    final sections = _sectionsFor(module.title);

    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassTopBar(
              title: module.title,
              leading: IconCircleButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => context
                    .read<NavigationProvider>()
                    .openTab(MainTab.lessons),
              ),
            ),
            const SizedBox(height: 16),
            SurfaceCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: module.accent.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(module.icon, color: module.accent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              module.title,
                              style:
                                  Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${(module.progress * 100).round()}% complete',
                              style:
                                  Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: module.progress,
                      backgroundColor: const Color(0xFFEFF3F8),
                      valueColor: AlwaysStoppedAnimation(module.accent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'About this lesson',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              module.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            Text(
              'Chapters',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < sections.length; i++) ...[
              _ChapterTile(
                index: i + 1,
                title: sections[i],
                completed: i / sections.length < module.progress,
              ),
              if (i != sections.length - 1) const SizedBox(height: 8),
            ],
            const SizedBox(height: 20),
            PrimaryButton(
              label: module.progress >= 1 ? 'Review lesson' : 'Continue lesson',
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                final next = (module.progress + .1).clamp(0.0, 1.0);
                context
                    .read<LearningProvider>()
                    .updateModuleProgress(module.title, next);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> _sectionsFor(String title) {
    switch (title) {
      case 'Money Basics':
        return const [
          'What money is',
          'How money moves',
          'Earning and spending',
          'Saving basics',
        ];
      case 'Saving & Budgeting':
        return const [
          'Setting a goal',
          'Making a simple plan',
          'Weekly check-ins',
          'Celebrating progress',
        ];
      case 'Needs vs Wants':
        return const [
          'Telling them apart',
          'Everyday choices',
          'Smart trade-offs',
        ];
      default:
        return const [
          'Introduction',
          'Core idea',
          'Practice',
          'Summary',
        ];
    }
  }
}

class _ChapterTile extends StatelessWidget {
  const _ChapterTile({
    required this.index,
    required this.title,
    required this.completed,
  });

  final int index;
  final String title;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: completed ? kBrandPrimary : kBrandSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              completed ? Icons.check_rounded : Icons.play_arrow_rounded,
              color: completed ? Colors.white : kBrandPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Chapter $index · $title',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
