import 'package:flutter/material.dart';

class ModuleVisual {
  const ModuleVisual({
    required this.shortTitle,
    required this.icon,
    required this.accent,
  });

  final String shortTitle;
  final IconData icon;
  final Color accent;
}

const Map<String, ModuleVisual> moduleVisuals = {
  '1': ModuleVisual(
    shortTitle: 'Money Basics',
    icon: Icons.payments_rounded,
    accent: Color(0xFF006B5F),
  ),
  '2': ModuleVisual(
    shortTitle: 'Smart Spending',
    icon: Icons.shopping_cart_checkout_rounded,
    accent: Color(0xFF006184),
  ),
  '3': ModuleVisual(
    shortTitle: 'Budgeting Basics',
    icon: Icons.savings_rounded,
    accent: Color(0xFFA06600),
  ),
  '4': ModuleVisual(
    shortTitle: 'Saving Power',
    icon: Icons.account_balance_wallet_rounded,
    accent: Color(0xFF7F5000),
  ),
  '5': ModuleVisual(
    shortTitle: 'Banking & Digital',
    icon: Icons.account_balance_rounded,
    accent: Color(0xFF006B5F),
  ),
  '6': ModuleVisual(
    shortTitle: 'Investment Basics',
    icon: Icons.trending_up_rounded,
    accent: Color(0xFF006184),
  ),
};
