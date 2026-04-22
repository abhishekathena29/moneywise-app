import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../providers/workshop_provider.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final workshop = context.watch<WorkshopProvider>();
    final progress = workshop.step / workshop.totalSteps;

    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassTopBar(
              title: 'Workshop',
              leading: _Avatar(name: auth.userName),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionEyebrow('Lesson progress'),
                Text(
                  'Step ${workshop.step} of ${workshop.totalSteps}',
                  style: const TextStyle(
                    color: kBrandPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: progress,
                backgroundColor: const Color(0xFFEFF3F8),
                valueColor: const AlwaysStoppedAnimation(kBrandPrimary),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Saving Challenge',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text:
                    'Leo\'s old school shoes are falling apart. He also wants a new video game. Which one is a ',
                children: [
                  TextSpan(
                    text: 'Need',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: kBrandPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(text: '?'),
                ],
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            _WorkshopOption(
              title: 'New school shoes',
              subtitle:
                  'Something you must have to stay safe at school.',
              badge: 'Essential',
              icon: Icons.checkroom_rounded,
              selected: workshop.selectedIndex == 0,
              onTap: () =>
                  context.read<WorkshopProvider>().selectOption(0),
            ),
            const SizedBox(height: 10),
            _WorkshopOption(
              title: 'Video game',
              subtitle: 'Fun to have, but you can live without it.',
              badge: 'Wishlist',
              icon: Icons.sports_esports_rounded,
              selected: workshop.selectedIndex == 1,
              accent: const Color(0xFFE8A33D),
              onTap: () =>
                  context.read<WorkshopProvider>().selectOption(1),
            ),
            if (workshop.submitted) ...[
              const SizedBox(height: 14),
              SurfaceCard(
                color: workshop.isCorrect
                    ? const Color(0xFFE8F8F0)
                    : const Color(0xFFFFF4E6),
                borderColor: workshop.isCorrect
                    ? const Color(0xFFB7E4CC)
                    : const Color(0xFFF6D9B0),
                child: Row(
                  children: [
                    Icon(
                      workshop.isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.info_rounded,
                      color: workshop.isCorrect
                          ? const Color(0xFF2BB673)
                          : const Color(0xFFE8A33D),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        workshop.isCorrect
                            ? 'Correct. School shoes are a need — you earned 20 bonus coins.'
                            : 'Not quite. A video game is a want; school shoes are the need.',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: kBrandInk),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            PrimaryButton(
              label: workshop.submitted ? 'Continue' : 'Check answer',
              icon: Icons.arrow_forward_rounded,
              onPressed: workshop.selectedIndex == -1 && !workshop.submitted
                  ? null
                  : () async {
                      final workshopProvider =
                          context.read<WorkshopProvider>();
                      final dashboardProvider =
                          context.read<DashboardProvider>();
                      if (workshop.submitted) {
                        await workshopProvider.reset();
                        return;
                      }
                      final didSubmit = await workshopProvider.submit();
                      if (!didSubmit) return;
                      if (workshopProvider.isCorrect &&
                          !workshopProvider.rewardApplied) {
                        await dashboardProvider.rewardWorkshopSuccess();
                        await workshopProvider.markRewardApplied();
                      }
                    },
            ),
            const SizedBox(height: 6),
            Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Hint: Needs keep us safe and healthy.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('I\'m not sure, give me a hint'),
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

class _WorkshopOption extends StatelessWidget {
  const _WorkshopOption({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.accent = kBrandPrimary,
  });

  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: SurfaceCard(
          padding: const EdgeInsets.all(14),
          borderColor: selected ? accent : const Color(0xFFE6EAF0),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected ? accent : kBrandMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
