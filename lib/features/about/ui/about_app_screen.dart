import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/about_provider.dart';

// Stitch design tokens.
const _kPrimary = Color(0xFF006184);
const _kPrimaryContainer = Color(0xFF007BA7);
const _kSecondary = Color(0xFF006B5F);
const _kSecondaryFixedDim = Color(0xFF59DBC7);
const _kSecondaryFixed = Color(0xFF79F7E3);
const _kTertiaryFixed = Color(0xFFFFDDB7);
const _kSurfaceContainer = Color(0xFFE7EEFF);
const _kSurfaceContainerLow = Color(0xFFF0F3FF);
const _kSurfaceContainerHighest = Color(0xFFD8E3FA);
const _kSurfaceDim = Color(0xFFCFDAF1);
const _kBackground = Color(0xFFF9F9FF);
const _kOnSurface = Color(0xFF111C2C);
const _kOnSurfaceVariant = Color(0xFF3F484E);
const _kOutlineVariant = Color(0xFFBFC8CF);

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final about = context.watch<AboutProvider>();
    return Scaffold(
      backgroundColor: _kBackground,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _AboutTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeroSection(),
                    const SizedBox(height: 40),
                    const _MissionBento(),
                    const SizedBox(height: 40),
                    _TeamSection(team: about.team),
                    const SizedBox(height: 32),
                    _PartnershipsSection(partners: about.partners),
                    const SizedBox(height: 32),
                    const _FinalCta(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: BottomNavBar(),
        ),
      ),
    );
  }
}

class _AboutTopBar extends StatelessWidget {
  const _AboutTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kSurfaceContainer,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          _CircleIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () =>
                context.read<NavigationProvider>().openTab(MainTab.home),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'MoneyWise Junior',
              style: TextStyle(
                color: _kPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: -0.3,
              ),
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFC4E7FF),
              border: Border.all(color: Colors.white, width: 2),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.person_rounded,
                color: _kPrimary, size: 18),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.settings_rounded, color: _kPrimary, size: 22),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 36,
          height: 36,
          child: Icon(Icons.arrow_back_rounded, color: _kPrimary, size: 20),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ABOUT OUR PLATFORM',
          style: TextStyle(
            fontSize: 11,
            color: _kOnSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.4,
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          text: const TextSpan(
            text: 'Empowering the ',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: _kPrimary,
              height: 1.1,
              letterSpacing: -1.0,
            ),
            children: [
              TextSpan(
                text: 'next',
                style: TextStyle(
                  color: _kSecondary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(text: ' generation.'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          "We are building a world where financial literacy isn't a privilege, but a fundamental skill taught through curiosity, play, and real-world tools.",
          style: TextStyle(
            fontSize: 15,
            color: _kOnSurfaceVariant,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _kTertiaryFixed.withValues(alpha: .7),
                    _kSecondaryFixed.withValues(alpha: .6),
                  ],
                ),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    top: 24,
                    left: 24,
                    child: _HeroBadge(),
                  ),
                  Center(
                    child: Icon(
                      Icons.diversity_3_rounded,
                      size: 120,
                      color: _kPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .85),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school_rounded, size: 14, color: _kPrimary),
          SizedBox(width: 6),
          Text(
            'Learn together',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: _kPrimary,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionBento extends StatelessWidget {
  const _MissionBento();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _kOnSurface.withValues(alpha: .06),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.rocket_launch_rounded,
                  size: 32, color: _kPrimary),
              const SizedBox(height: 20),
              const Text(
                'Mission Statement',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _kOnSurface,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Our goal is to demystify money management. By blending AI-driven learning with interactive play, we help kids and teens build the habits necessary for lifelong financial health.',
                style: TextStyle(
                  fontSize: 14,
                  color: _kOnSurfaceVariant,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Explore our curriculum',
                    style: TextStyle(
                      color: _kPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded,
                      color: _kPrimary, size: 18),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _kPrimary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_user_rounded,
                  size: 32, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Our Values',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 14),
              for (final value in const [
                'Radically Simple',
                'Deep Respect',
                'Ethical Growth',
                'Future Focused',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: _kSecondaryFixedDim,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: .92),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamMember {
  const _TeamMember(this.name, this.role, this.initials);
  final String name;
  final String role;
  final String initials;
}

class _TeamSection extends StatelessWidget {
  const _TeamSection({required this.team});
  final List<String> team;

  @override
  Widget build(BuildContext context) {
    const members = [
      _TeamMember('Alex Rivera', 'Lead Product Designer', 'AR'),
      _TeamMember('Sarah Chen', 'Financial Literacy Lead', 'SC'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The Team',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: _kOnSurface,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "A collective of educators, designers, and financial experts dedicated to children's growth.",
          style: TextStyle(
            fontSize: 14,
            color: _kOnSurfaceVariant,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kSurfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              for (var i = 0; i < members.length; i++) ...[
                _TeamMemberRow(member: members[i]),
                if (i < members.length - 1) const SizedBox(height: 18),
              ],
              const SizedBox(height: 18),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: _kSurfaceContainerHighest,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: _kOutlineVariant.withValues(alpha: .15),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Meet the Full Team',
                      style: TextStyle(
                        color: _kPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  const _TeamMemberRow({required this.member});
  final _TeamMember member;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _kOnSurface.withValues(alpha: .06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            member.initials,
            style: const TextStyle(
              color: _kPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _kOnSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                member.role,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kOnSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PartnershipsSection extends StatelessWidget {
  const _PartnershipsSection({required this.partners});
  final List<String> partners;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Partnerships',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: _kOnSurface,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Working with the best in finance and education to provide verified learning paths.',
          style: TextStyle(
            fontSize: 14,
            color: _kOnSurfaceVariant,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kSurfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 2.4,
                children: [
                  for (final p in partners) _PartnerChip(label: p),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Our partners help us bridge the gap between classroom theory and real-world application.',
                style: TextStyle(
                  fontSize: 12,
                  color: _kOnSurfaceVariant,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: _kOnSurface.withValues(alpha: .06),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Become a Partner',
                            style: TextStyle(
                              color: _kPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(Icons.handshake_rounded,
                            color: _kPrimary, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PartnerChip extends StatelessWidget {
  const _PartnerChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceDim.withValues(alpha: .4),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: _kOnSurfaceVariant.withValues(alpha: .55),
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _FinalCta extends StatelessWidget {
  const _FinalCta();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kPrimary, _kPrimaryContainer],
        ),
        boxShadow: [
          BoxShadow(
            color: _kPrimary.withValues(alpha: .25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Ready to start their journey?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: _CtaPrimaryButton(
              label: 'Get Started Today',
              onTap: () =>
                  context.read<NavigationProvider>().openSignup(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _CtaSecondaryButton(
              label: 'Download Media Kit',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaPrimaryButton extends StatelessWidget {
  const _CtaPrimaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Get Started Today',
            style: TextStyle(
              color: _kPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _CtaSecondaryButton extends StatelessWidget {
  const _CtaSecondaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .15),
            borderRadius: BorderRadius.circular(999),
            border:
                Border.all(color: Colors.white.withValues(alpha: .25)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
