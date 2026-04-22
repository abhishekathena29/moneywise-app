import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/models/app_models.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/learning_provider.dart';

class LearningModulesScreen extends StatelessWidget {
  const LearningModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final learning = context.watch<LearningProvider>();
    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassTopBar(
              title: 'Lessons',
              leading: _Avatar(name: auth.userName),
              trailing: IconCircleButton(
                icon: Icons.emoji_events_rounded,
                onTap: () =>
                    context.read<NavigationProvider>().goTo(AppRoute.profile),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Pick up where\nyou left off',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Short, guided lessons to build strong money habits.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            for (var i = 0; i < learning.modules.length; i++) ...[
              _ModuleCard(module: learning.modules[i]),
              if (i != learning.modules.length - 1)
                const SizedBox(height: 10),
            ],
            const SizedBox(height: 20),
            SurfaceCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionEyebrow('Weekly challenge'),
                  const SizedBox(height: 8),
                  Text(
                    'Save ₹500 this week',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Start your streak and unlock the Golden Piggy badge.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'Start challenge',
                    icon: Icons.arrow_forward_rounded,
                    expanded: false,
                    onPressed: () => context
                        .read<NavigationProvider>()
                        .goTo(AppRoute.savingsGoalCalculator),
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

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.module});

  final ModuleProgress module;

  @override
  Widget build(BuildContext context) {
    final locked = module.isLocked;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: locked
            ? null
            : () =>
                context.read<NavigationProvider>().openLesson(module.title),
        child: SurfaceCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (locked ? kBrandMuted : module.accent)
                      .withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  locked ? Icons.lock_rounded : module.icon,
                  color: locked ? kBrandMuted : module.accent,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      module.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    if (locked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: kBrandSoft,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          'Locked',
                          style: TextStyle(
                            color: kBrandMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: LinearProgressIndicator(
                                minHeight: 6,
                                value: module.progress,
                                backgroundColor: const Color(0xFFEFF3F8),
                                valueColor:
                                    AlwaysStoppedAnimation(module.accent),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${(module.progress * 100).round()}%',
                            style: const TextStyle(
                              color: kBrandMuted,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: locked ? kBrandMuted : kBrandInk,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
