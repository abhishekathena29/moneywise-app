import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/onboarding_provider.dart';

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalPages = context.watch<OnboardingProvider>().totalPages;
    return AppScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassTopBar(
                      title: 'MoneyWise Junior',
                      trailing: TextButton(
                        onPressed:
                            context.read<NavigationProvider>().openSignup,
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: kBrandMuted),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SectionEyebrow('Step 01 / 0$totalPages'),
                    const SizedBox(height: 12),
                    Text(
                      'Learn money habits\nthrough play.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Bite-size lessons, small wins, and tools that make saving feel simple.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    const _OnboardFeature(
                      icon: Icons.savings_rounded,
                      title: 'Savings',
                      subtitle: 'Set goals and build streaks.',
                    ),
                    const SizedBox(height: 10),
                    const _OnboardFeature(
                      icon: Icons.workspace_premium_rounded,
                      title: 'Rewards',
                      subtitle: 'Earn coins and badges as you learn.',
                    ),
                    const SizedBox(height: 10),
                    const _OnboardFeature(
                      icon: Icons.school_rounded,
                      title: 'Learning',
                      subtitle: 'Short, clear lessons designed for kids.',
                    ),
                    const Spacer(),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: 'Continue',
                      icon: Icons.arrow_forward_rounded,
                      onPressed:
                          context.read<NavigationProvider>().finishOnboardingOne,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OnboardFeature extends StatelessWidget {
  const _OnboardFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
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
            child: Icon(icon, size: 22, color: kBrandPrimary),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
