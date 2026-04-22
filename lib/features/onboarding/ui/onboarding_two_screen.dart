import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/onboarding_provider.dart';

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({super.key});

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
                    SectionEyebrow('Step 02 / 0$totalPages'),
                    const SizedBox(height: 12),
                    Text(
                      'Save for your dreams\nwith goals that feel real.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Track progress one small deposit at a time.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    SurfaceCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: kBrandSoft,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.pedal_bike_rounded,
                                  color: kBrandPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'New Blue Bike',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Saving goal example',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                '₹15 / ₹50',
                                style: TextStyle(
                                  color: kBrandPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: const LinearProgressIndicator(
                              minHeight: 8,
                              value: .3,
                              backgroundColor: Color(0xFFEFF3F8),
                              valueColor:
                                  AlwaysStoppedAnimation(kBrandPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: 'Continue',
                      icon: Icons.arrow_forward_rounded,
                      onPressed:
                          context.read<NavigationProvider>().finishOnboardingTwo,
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed:
                            context.read<NavigationProvider>().openSignup,
                        child: const Text('Skip for now'),
                      ),
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
