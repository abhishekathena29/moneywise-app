import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../models/lesson_module.dart';
import '../providers/learning_provider.dart';

class LessonDetailScreen extends StatefulWidget {
  const LessonDetailScreen({super.key});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int _currentIndex = 0;
  String? _boundModuleId;

  @override
  Widget build(BuildContext context) {
    final moduleId = context.watch<NavigationProvider>().selectedModuleId;
    final learning = context.watch<LearningProvider>();
    final module = learning.modules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => learning.modules.isEmpty
          ? throw StateError('No modules')
          : learning.modules.first,
    );

    if (_boundModuleId != module.id) {
      _boundModuleId = module.id;
      _currentIndex = 0;
    }

    final sections = module.sections;
    if (sections.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF9F9FF),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final section = sections[_currentIndex];
    final completedIds = learning.completedSectionsFor(module.id).toSet();
    final isLast = _currentIndex == sections.length - 1;
    final passed = learning.isModulePassed(module.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _DetailHeader(module: module),
            _StepIndicator(
              total: sections.length,
              currentIndex: _currentIndex,
              completedCount:
                  completedIds.intersection(sections.map((s) => s.id).toSet())
                      .length,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: _SectionBody(section: section),
              ),
            ),
            _NavButtons(
              module: module,
              section: section,
              isFirst: _currentIndex == 0,
              isLast: isLast,
              alreadyComplete: completedIds.contains(section.id),
              modulePassed: passed,
              onPrev: () => setState(() => _currentIndex--),
              onNext: () async {
                final nav = context.read<NavigationProvider>();
                await learning.markSectionComplete(module.id, section.id);
                if (!mounted) return;
                if (isLast) {
                  nav.openQuiz(module.id);
                } else {
                  setState(() => _currentIndex++);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.module});
  final LessonModule module;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 20, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context
                .read<NavigationProvider>()
                .openTab(MainTab.lessons),
            icon: const Icon(Icons.arrow_back_rounded,
                color: Color(0xFF111C2C)),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: module.accent.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(module.icon, color: module.accent, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.shortTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111C2C),
                  ),
                ),
                Text(
                  '${module.duration} · ${module.difficulty}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF3F484E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.total,
    required this.currentIndex,
    required this.completedCount,
  });
  final int total;
  final int currentIndex;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    final progress = (currentIndex + 1) / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${currentIndex + 1} of $total',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF006184),
                  letterSpacing: 0.4,
                ),
              ),
              Text(
                '$completedCount / $total complete',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF3F484E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              backgroundColor: const Color(0xFFE7EEFF),
              valueColor:
                  const AlwaysStoppedAnimation(Color(0xFF006184)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionBody extends StatelessWidget {
  const _SectionBody({required this.section});
  final LessonSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.image.isNotEmpty)
            Text(
              section.image,
              style: const TextStyle(fontSize: 44),
            ),
          if (section.image.isNotEmpty) const SizedBox(height: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: section.isActivity
                  ? const Color(0xFFFFDDB7)
                  : const Color(0xFFC4E7FF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              section.isActivity ? 'ACTIVITY' : 'LESSON',
              style: TextStyle(
                fontSize: 10,
                color: section.isActivity
                    ? const Color(0xFF7F5000)
                    : const Color(0xFF004C69),
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111C2C),
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          if (section.duration.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              section.duration,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF3F484E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 16),
          if (section.text.isNotEmpty)
            Text(
              section.text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3F484E),
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (section.keyPoints.isNotEmpty) ...[
            const SizedBox(height: 18),
            const Text(
              'Key points',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF006184),
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            ...section.keyPoints.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.circle, size: 6, color: Color(0xFF006184)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          p,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF111C2C),
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          if (section.activity.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Try this',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF7F5000),
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    section.activity,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF111C2C),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (section.reward.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.stars_rounded,
                    color: Color(0xFFA06600), size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    section.reward,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7F5000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _NavButtons extends StatelessWidget {
  const _NavButtons({
    required this.module,
    required this.section,
    required this.isFirst,
    required this.isLast,
    required this.alreadyComplete,
    required this.modulePassed,
    required this.onPrev,
    required this.onNext,
  });

  final LessonModule module;
  final LessonSection section;
  final bool isFirst;
  final bool isLast;
  final bool alreadyComplete;
  final bool modulePassed;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
        child: Row(
          children: [
            if (!isFirst)
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFC4E7FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: onPrev,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Color(0xFF006184),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            if (!isFirst) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF006184),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 0,
                ),
                onPressed: onNext,
                child: Text(
                  isLast
                      ? (modulePassed ? 'Retake quiz' : 'Start quiz')
                      : (alreadyComplete ? 'Next' : 'Mark done & continue'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
