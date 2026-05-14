import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/lesson_module.dart';
import '../providers/learning_provider.dart';

class LearningModulesScreen extends StatelessWidget {
  const LearningModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final learning = context.watch<LearningProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _LessonsTopBar(name: auth.userName),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 160),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _HeroBanner(level: _levelFromProgress(learning)),
                      const SizedBox(height: 28),
                      _SectionHeader(
                        title: 'Lessons Library',
                        eyebrow:
                            '${learning.modules.length} PATHS AVAILABLE',
                      ),
                      const SizedBox(height: 16),
                      if (learning.isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                              child: CircularProgressIndicator()),
                        )
                      else
                        ..._buildModuleCards(context, learning),
                      const SizedBox(height: 32),
                      _DailyChallengeCard(learning: learning),
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 110,
              child: _ChatbotFab(),
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

  List<Widget> _buildModuleCards(
      BuildContext context, LearningProvider learning) {
    final modules = learning.modules;
    final result = <Widget>[];
    for (var i = 0; i < modules.length; i++) {
      final m = modules[i];
      result.add(_ModuleCard(
        module: m,
        progress: learning.progressFor(m.id),
        locked: !learning.isModuleUnlocked(m.id),
        passed: learning.isModulePassed(m.id),
      ));
      if (i != modules.length - 1) result.add(const SizedBox(height: 18));
    }
    return result;
  }

  int _levelFromProgress(LearningProvider learning) {
    final passed = learning.modules
        .where((m) => learning.isModulePassed(m.id))
        .length;
    return passed + 1;
  }
}

// ---------------- Top bar ----------------

class _LessonsTopBar extends SliverPersistentHeaderDelegate {
  _LessonsTopBar({required this.name});
  final String name;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE7EEFF).withValues(alpha: .85),
      ),
      child: ClipRect(
        child: BackdropFilterFallback(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xFFC4E7FF), width: 2),
                    color: const Color(0xFF006184),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    name.isEmpty
                        ? '?'
                        : name.characters.first.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'MoneyWise Junior',
                    style: TextStyle(
                      color: Color(0xFF004C69),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC4E7FF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Icon(Icons.emoji_events_rounded,
                      color: Color(0xFF006184)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 66;
  @override
  double get minExtent => 66;
  @override
  bool shouldRebuild(covariant _LessonsTopBar oldDelegate) =>
      oldDelegate.name != name;
}

class BackdropFilterFallback extends StatelessWidget {
  const BackdropFilterFallback({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

// ---------------- Hero ----------------

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF006184), Color(0xFF007BA7)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF006184).withValues(alpha: .25),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ready to become a\nMoney Master?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 220,
                child: Text(
                  'Complete modules to earn gems and unlock cool gear!',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .85),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFD54F), size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Level $level Scholar',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: -20,
            bottom: -20,
            child: Transform.rotate(
              angle: .2,
              child: Opacity(
                opacity: .2,
                child: Icon(Icons.school_rounded,
                    size: 160, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Section header ----------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.eyebrow});
  final String title;
  final String eyebrow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111C2C),
            letterSpacing: -0.3,
          ),
        ),
        Text(
          eyebrow,
          style: const TextStyle(
            color: Color(0xFF006184),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}

// ---------------- Module card ----------------

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.module,
    required this.progress,
    required this.locked,
    required this.passed,
  });

  final LessonModule module;
  final double progress;
  final bool locked;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Text(
                module.shortTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111C2C),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _truncate(module.description, 80),
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF3F484E),
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    passed ? 'PASSED' : 'PROGRESS',
                    style: TextStyle(
                      color: module.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      color: Color(0xFF111C2C),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: progress,
                  backgroundColor: const Color(0xFFE7EEFF),
                  valueColor: AlwaysStoppedAnimation(module.accent),
                ),
              ),
              if (!locked) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _CardAction(
                        label: progress > 0 ? 'Continue' : 'Start lessons',
                        icon: Icons.menu_book_rounded,
                        accent: module.accent,
                        filled: true,
                        onTap: () => context
                            .read<NavigationProvider>()
                            .openModule(module.id),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _CardAction(
                        label: passed ? 'Retake quiz' : 'Take quiz',
                        icon: Icons.quiz_rounded,
                        accent: module.accent,
                        filled: false,
                        onTap: () => context
                            .read<NavigationProvider>()
                            .openQuiz(module.id),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: module.accent.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.center,
              child: Icon(module.icon, color: module.accent, size: 26),
            ),
          ),
        ],
      ),
    );

    if (locked) {
      return Stack(
        children: [
          Opacity(opacity: .65, child: card),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                color: const Color(0xFFE7EEFF).withValues(alpha: .55),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.lock_rounded,
                      color: Color(0xFF3F484E)),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () =>
            context.read<NavigationProvider>().openModule(module.id),
        child: card,
      ),
    );
  }

  String _truncate(String s, int len) =>
      s.length <= len ? s : '${s.substring(0, len - 1).trim()}…';
}

// ---------------- Daily challenge ----------------

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard({required this.learning});
  final LearningProvider learning;

  @override
  Widget build(BuildContext context) {
    final hasCert = learning.hasCertificate;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFDEE8FF),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDDB7).withValues(alpha: .8),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  hasCert ? 'CERTIFICATE READY' : 'DAILY CHALLENGE',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7F5000),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                hasCert
                    ? 'You finished every module!'
                    : 'Can you save ₹500\nthis week?',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111C2C),
                  height: 1.2,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 240,
                child: Text(
                  hasCert
                      ? 'View and share your MoneyWise Junior certificate.'
                      : 'Start your saving streak today and unlock the Golden Piggy badge.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3F484E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _GradientButton(
                label: hasCert ? 'View Certificate' : 'Accept Challenge',
                onPressed: () {
                  if (hasCert) {
                    context.read<NavigationProvider>().openCertificate();
                  } else {
                    context
                        .read<NavigationProvider>()
                        .goTo(AppRoute.savingsGoalCalculator);
                  }
                },
              ),
            ],
          ),
          Positioned(
            right: -30,
            bottom: -30,
            child: Opacity(
              opacity: .3,
              child: Icon(
                hasCert
                    ? Icons.workspace_premium_rounded
                    : Icons.workspace_premium_rounded,
                size: 160,
                color: const Color(0xFF7F5000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [Color(0xFF006184), Color(0xFF007BA7)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF006184).withValues(alpha: .3),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({
    required this.label,
    required this.icon,
    required this.accent,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color accent;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: filled ? accent : accent.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 14, color: filled ? Colors.white : accent),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: filled ? Colors.white : accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatbotFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => context.read<NavigationProvider>().openChatbot(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7F5000), Color(0xFFA06600)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7F5000).withValues(alpha: .3),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.bolt_rounded,
              color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
