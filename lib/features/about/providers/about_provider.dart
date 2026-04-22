import 'package:flutter/material.dart';

class AboutProvider extends ChangeNotifier {
  final List<String> values = const [
    'Radically Simple',
    'Deep Respect',
    'Ethical Growth',
    'Future Focused',
  ];

  final List<String> team = const [
    'Alex Rivera',
    'Sarah Chen',
    'Community Mentors',
  ];

  final List<String> partners = const [
    'EDU-CORP',
    'FIN-LAB',
    'KID-VENTURE',
    'TEACH-TECH',
  ];
}
