import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/learning_provider.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final learning = context.watch<LearningProvider>();
    final issuedAt = learning.certificateIssuedAt;
    final earned = learning.allModulesPassed && issuedAt != null;
    final issuedDate = issuedAt == null
        ? null
        : DateTime.tryParse(issuedAt) ?? DateTime.now();
    final averageScore = _averageScore(learning);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 20, 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context
                        .read<NavigationProvider>()
                        .openTab(MainTab.lessons),
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF111C2C)),
                  ),
                  const Expanded(
                    child: Text(
                      'Certificate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111C2C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: earned
                  ? _Issued(
                      name: auth.userName.isEmpty
                          ? 'MoneyWise Junior'
                          : auth.userName,
                      issuedDate: issuedDate!,
                      averageScore: averageScore,
                    )
                  : _Locked(learning: learning),
            ),
          ],
        ),
      ),
    );
  }

  double _averageScore(LearningProvider l) {
    final scores = l.modules
        .map((m) => l.quizScoreFor(m.id))
        .whereType<double>()
        .toList();
    if (scores.isEmpty) return 0;
    return scores.reduce((a, b) => a + b) / scores.length;
  }
}

class _Issued extends StatelessWidget {
  const _Issued({
    required this.name,
    required this.issuedDate,
    required this.averageScore,
  });
  final String name;
  final DateTime issuedDate;
  final double averageScore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFDDB7), Color(0xFFFFB95C)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7F5000).withValues(alpha: .2),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    size: 48,
                    color: Color(0xFF7F5000),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'CERTIFICATE OF COMPLETION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7F5000),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'This is to certify that',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F5000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111C2C),
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'has successfully completed every module of\nthe MoneyWise Junior financial literacy program.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF111C2C),
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _Stat(
                      label: 'Score',
                      value: '${averageScore.toStringAsFixed(0)}%',
                    ),
                    _Stat(
                      label: 'Issued',
                      value:
                          '${_pad(issuedDate.day)}/${_pad(issuedDate.month)}/${issuedDate.year}',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You earned this for:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF006184),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 12),
                _bullet('Completing all 6 financial-literacy modules'),
                _bullet('Scoring above 50% on every module quiz'),
                _bullet('Building real money habits along the way'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Color(0xFF006B5F), size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF111C2C),
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );

  String _pad(int n) => n.toString().padLeft(2, '0');
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF7F5000),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF111C2C),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _Locked extends StatelessWidget {
  const _Locked({required this.learning});
  final LearningProvider learning;

  @override
  Widget build(BuildContext context) {
    final total = learning.modules.length;
    final passed = learning.modules
        .where((m) => learning.isModulePassed(m.id))
        .length;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFFE7EEFF),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lock_rounded,
                    size: 40, color: Color(0xFF3F484E)),
                const SizedBox(height: 16),
                const Text(
                  'Certificate locked',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111C2C),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pass the quiz in every module to unlock your MoneyWise Junior certificate. $passed of $total modules passed so far.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3F484E),
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...learning.modules.map((m) {
            final isPassed = learning.isModulePassed(m.id);
            final score = learning.quizScoreFor(m.id);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    isPassed
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isPassed
                        ? const Color(0xFF006B5F)
                        : const Color(0xFFBFC8CF),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      m.shortTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111C2C),
                      ),
                    ),
                  ),
                  Text(
                    score == null
                        ? 'Not taken'
                        : '${score.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: isPassed
                          ? const Color(0xFF006B5F)
                          : const Color(0xFF3F484E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
