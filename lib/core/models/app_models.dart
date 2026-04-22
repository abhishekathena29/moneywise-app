import 'package:flutter/material.dart';

class ModuleProgress {
  const ModuleProgress({
    required this.title,
    required this.description,
    required this.progress,
    required this.icon,
    required this.accent,
    required this.isLocked,
  });

  final String title;
  final String description;
  final double progress;
  final IconData icon;
  final Color accent;
  final bool isLocked;
}

class BadgeItem {
  const BadgeItem(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final Color color;
}

class TrackerEntry {
  const TrackerEntry(this.title, this.amount, this.isIncome, this.day);

  final String title;
  final double amount;
  final bool isIncome;
  final String day;
}

class SpendCategory {
  const SpendCategory(this.label, this.percent, this.color);

  final String label;
  final double percent;
  final Color color;
}
