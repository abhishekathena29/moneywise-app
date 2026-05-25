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
    final nav = context.watch<NavigationProvider>();
    final issuedAt = learning.certificateIssuedAt;
    final earned = learning.allModulesPassed && issuedAt != null;
    final preview = nav.certificatePreview;
    final showCertificate = earned || preview;
    final issuedDate = issuedAt == null
        ? DateTime.now()
        : DateTime.tryParse(issuedAt) ?? DateTime.now();

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
              child: showCertificate
                  ? _Issued(
                      name: auth.userName.isEmpty
                          ? 'MoneyWise Junior'
                          : auth.userName,
                      issuedDate: issuedDate,
                      isPreview: preview && !earned,
                    )
                  : _Locked(learning: learning),
            ),
          ],
        ),
      ),
    );
  }
}

class _Issued extends StatelessWidget {
  const _Issued({
    required this.name,
    required this.issuedDate,
    required this.isPreview,
  });
  final String name;
  final DateTime issuedDate;
  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPreview)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 14),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6E5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFDDB7)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.science_rounded,
                      size: 18, color: Color(0xFF7F5000)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Preview mode — complete every module quiz to earn this for real.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7F5000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          _CertificateCard(name: name, issuedDate: issuedDate),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF006184),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Download will be available soon.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: const Text(
                    'Download',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFC4E7FF)),
                    foregroundColor: const Color(0xFF006184),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share will be available soon.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.share_rounded, size: 18),
                  label: const Text(
                    'Share',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.name, required this.issuedDate});
  final String name;
  final DateTime issuedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 994 / 720,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/certificate.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const _CertificateFallback(),
                  ),
                ),
                // Student name overlay — covers the "[Student Name]"
                // placeholder text on the underlying certificate art.
                Positioned(
                  left: width * 0.20,
                  right: width * 0.04,
                  top: width * (720 / 994) * 0.31,
                  height: width * (720 / 994) * 0.13,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F3A8A),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                // Date overlay — covers the static "10-04-2026" date on
                // the certificate art with the actual issue date.
                Positioned(
                  left: width * 0.10,
                  width: width * 0.30,
                  top: width * (720 / 994) * 0.875,
                  height: width * (720 / 994) * 0.045,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Date : ${_formatDate(issuedDate)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111C2C),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) =>
      '${_pad(d.day)}-${_pad(d.month)}-${d.year}';
  static String _pad(int n) => n.toString().padLeft(2, '0');
}

class _CertificateFallback extends StatelessWidget {
  const _CertificateFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F3FF),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Certificate art missing.\nAdd assets/images/certificate.png',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFF3F484E),
          fontWeight: FontWeight.w600,
        ),
      ),
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
