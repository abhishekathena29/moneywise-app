import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/about_provider.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final about = context.watch<AboutProvider>();
    final wide = isWideLayout(context, 920);
    return AppScaffold(
      bottomNavigation: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassTopBar(
              title: 'MoneyWise Junior',
              leading: IconCircleButton(
                icon: Icons.arrow_back_rounded,
                onTap: () =>
                    context.read<NavigationProvider>().openTab(MainTab.home),
              ),
              trailing: IconCircleButton(
                icon: Icons.settings_rounded,
                onTap: () {},
              ),
            ),
            const SizedBox(height: 28),
            const SectionEyebrow('About Our Platform'),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                text: 'Empowering the ',
                children: [
                  TextSpan(
                    text: 'next',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFF006B5F),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const TextSpan(text: ' generation.'),
                ],
              ),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFF006184),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'We are building a world where financial literacy is not a privilege, but a foundational skill taught through curiosity, play, and real-world tools.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF3F484E)),
            ),
            const SizedBox(height: 24),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: _AboutCard(
                      title: 'Mission Statement',
                      body:
                          'Our goal is to demystify money management with playful, interactive learning that builds lifelong habits.',
                      icon: Icons.rocket_launch_rounded,
                      accent: Color(0xFF006184),
                      dark: false,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: _ValuesCard(values: about.values)),
                ],
              )
            else ...[
              const _AboutCard(
                title: 'Mission Statement',
                body:
                    'Our goal is to demystify money management with playful, interactive learning that builds lifelong habits.',
                icon: Icons.rocket_launch_rounded,
                accent: Color(0xFF006184),
                dark: false,
              ),
              const SizedBox(height: 14),
              _ValuesCard(values: about.values),
            ],
            const SizedBox(height: 20),
            if (wide)
              Row(
                children: [
                  Expanded(
                    child: _AboutSection(
                      title: 'The Team',
                      body:
                          'A collective of educators, designers, and finance experts dedicated to children’s growth.',
                      items: about.team,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _AboutSection(
                      title: 'Partnerships',
                      body:
                          'Working with education and finance leaders to build trusted learning paths.',
                      items: about.partners,
                    ),
                  ),
                ],
              )
            else ...[
              _AboutSection(
                title: 'The Team',
                body:
                    'A collective of educators, designers, and finance experts dedicated to children’s growth.',
                items: about.team,
              ),
              const SizedBox(height: 14),
              _AboutSection(
                title: 'Partnerships',
                body:
                    'Working with education and finance leaders to build trusted learning paths.',
                items: about.partners,
              ),
            ],
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF006184), Color(0xFF007BA7)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready to start their journey?',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 520) {
                        return Column(
                          children: [
                            PrimaryButton(
                              label: 'Get Started Today',
                              onPressed: () => context
                                  .read<NavigationProvider>()
                                  .openSignup(),
                            ),
                            const SizedBox(height: 12),
                            const SecondaryButton(label: 'Media Kit'),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              label: 'Get Started Today',
                              onPressed: () => context
                                  .read<NavigationProvider>()
                                  .openSignup(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: SecondaryButton(label: 'Media Kit'),
                          ),
                        ],
                      );
                    },
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

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
    required this.dark,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color accent;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final background = dark ? const Color(0xFF006184) : Colors.white;
    final foreground = dark ? Colors.white : const Color(0xFF111C2C);
    return SurfaceCard(
      color: background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: dark ? Colors.white : accent, size: 34),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: foreground),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: foreground.withValues(alpha: .9),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValuesCard extends StatelessWidget {
  const _ValuesCard({required this.values});

  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      color: const Color(0xFF006184),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_user_rounded,
            color: Colors.white,
            size: 34,
          ),
          const SizedBox(height: 16),
          Text(
            'Our Values',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          for (final value in values) ...[
            Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Color(0xFF79F7E3)),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({
    required this.title,
    required this.body,
    required this.items,
  });

  final String title;
  final String body;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      color: const Color(0xFFF0F3FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text(
            body,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF3F484E)),
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: Color(0xFF006184)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
