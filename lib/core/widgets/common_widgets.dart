import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/navigation/navigation_provider.dart';

const kBrandPrimary = Color(0xFF0E5B7A);
const kBrandAccent = Color(0xFF2BB673);
const kBrandSurface = Color(0xFFF6F7FB);
const kBrandInk = Color(0xFF111827);
const kBrandMuted = Color(0xFF6B7280);
const kBrandSoft = Color(0xFFEFF3F8);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.bottomNavigation = false,
    this.padding,
  });

  final Widget child;
  final bool bottomNavigation;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final resolvedPadding =
        padding ??
        EdgeInsets.fromLTRB(0, 16, 0, bottomNavigation ? 104 : 24);
    return Scaffold(
      backgroundColor: kBrandSurface,
      body: Stack(
        children: [
          const Positioned.fill(child: AppGradientBackground()),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                responsiveHorizontalPadding(context),
                resolvedPadding.top,
                responsiveHorizontalPadding(context),
                resolvedPadding.bottom,
              ),
              child: child,
            ),
          ),
          if (bottomNavigation)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: const BottomNavBar(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: kBrandSurface,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF2F6FC), Color(0xFFF9FAFB)],
        ),
      ),
    );
  }
}

double responsiveHorizontalPadding(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width >= 1200) return 48;
  if (width >= 800) return 32;
  if (width >= 480) return 20;
  return 16;
}

bool isWideLayout(BuildContext context, [double breakpoint = 860]) {
  return MediaQuery.sizeOf(context).width >= breakpoint;
}

bool isCompactWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 380;
}

class GlassTopBar extends StatelessWidget {
  const GlassTopBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          ?leading,
          if (leading != null) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: kBrandInk,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class IconCircleButton extends StatelessWidget {
  const IconCircleButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = const Color(0xFFEFF3F8),
    this.iconColor = kBrandPrimary,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: iconColor, size: 20),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.expanded = true,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: enabled ? kBrandPrimary : kBrandPrimary.withValues(alpha: .4),
      ),
      child: Row(
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: .1,
              ),
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(icon, color: Colors.white, size: 18),
          ],
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: expanded ? child : IntrinsicWidth(child: child),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: kBrandSoft,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE0E6EE)),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: kBrandPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(18),
    this.borderColor,
  });

  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor ?? const Color(0xFFE6EAF0),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: kBrandMuted,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

class ProgressPill extends StatelessWidget {
  const ProgressPill({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kBrandSoft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label $value',
        style: const TextStyle(
          color: kBrandPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class GoalRing extends StatelessWidget {
  const GoalRing({super.key, required this.progress, required this.label});

  final double progress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CustomPaint(painter: _RingPainter(progress: progress)),
          ),
          Text(
            label,
            style: const TextStyle(
              color: kBrandPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 6;
    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..color = const Color(0xFFE6EAF0);
    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..color = kBrandPrimary;

    canvas.drawCircle(center, radius, basePaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NavigationProvider>();
    final compact = isCompactWidth(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            selected: state.activeTab == MainTab.home,
            onTap: () =>
                context.read<NavigationProvider>().openTab(MainTab.home),
          ),
          _NavItem(
            icon: Icons.menu_book_rounded,
            label: 'Lessons',
            selected: state.activeTab == MainTab.lessons,
            onTap: () =>
                context.read<NavigationProvider>().openTab(MainTab.lessons),
          ),
          _NavItem(
            icon: Icons.grid_view_rounded,
            label: 'Tools',
            selected: state.activeTab == MainTab.tools,
            onTap: () =>
                context.read<NavigationProvider>().openTab(MainTab.tools),
          ),
          _NavItem(
            icon: Icons.lightbulb_outline_rounded,
            label: 'Workshop',
            selected: state.activeTab == MainTab.workshop,
            onTap: () =>
                context.read<NavigationProvider>().openTab(MainTab.workshop),
          ),
          _NavItem(
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            selected: state.activeTab == MainTab.profile,
            onTap: () =>
                context.read<NavigationProvider>().openTab(MainTab.profile),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? kBrandPrimary : kBrandMuted;
    final compact = isCompactWidth(context);
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: color,
                  fontSize: compact ? 10 : 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
