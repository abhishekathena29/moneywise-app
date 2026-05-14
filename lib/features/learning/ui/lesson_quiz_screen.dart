import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../models/lesson_module.dart';
import '../providers/learning_provider.dart';

/// Renders the full multi-part worksheet for a module. MCQs (and true/false
/// questions with a correct answer) are auto-graded; the unlock gate (>50%)
/// uses the combined score across those gradable items.
class LessonQuizScreen extends StatefulWidget {
  const LessonQuizScreen({super.key});

  @override
  State<LessonQuizScreen> createState() => _LessonQuizScreenState();
}

class _LessonQuizScreenState extends State<LessonQuizScreen> {
  String? _boundModuleId;
  int _partIndex = 0;
  bool _submitted = false;
  double _scorePercent = 0;
  bool _passed = false;

  /// Per-item answers keyed by item id. Stored values:
  ///   mcq / trueFalse → int (option index)
  ///   fillBlanks / numeric / rating → `Map<int,String>` (blank → text)
  ///   classify → `Map<int,int>` (row → option index)
  ///   shortAnswer / longAnswer → String
  final Map<String, dynamic> _answers = {};
  final Map<String, List<TextEditingController>> _blankCtrls = {};
  final Map<String, TextEditingController> _textCtrls = {};

  @override
  void dispose() {
    for (final list in _blankCtrls.values) {
      for (final c in list) {
        c.dispose();
      }
    }
    for (final c in _textCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _resetForModule() {
    for (final list in _blankCtrls.values) {
      for (final c in list) {
        c.dispose();
      }
    }
    for (final c in _textCtrls.values) {
      c.dispose();
    }
    _blankCtrls.clear();
    _textCtrls.clear();
    _answers.clear();
    _partIndex = 0;
    _submitted = false;
  }

  @override
  Widget build(BuildContext context) {
    final moduleId = context.watch<NavigationProvider>().selectedModuleId;
    final learning = context.watch<LearningProvider>();
    if (learning.modules.isEmpty) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }
    final module = learning.modules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => learning.modules.first,
    );

    if (_boundModuleId != module.id) {
      _boundModuleId = module.id;
      _resetForModule();
    }

    final parts = module.quizParts;
    if (parts.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No quiz available for this module.')),
      );
    }

    if (_submitted) {
      return _ResultView(
        module: module,
        scorePercent: _scorePercent,
        passed: _passed,
        answers: _answers,
        onRetake: () => setState(_resetForModule),
      );
    }

    final part = parts[_partIndex];
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _Header(module: module),
            _PartNavigator(
              parts: parts,
              currentIndex: _partIndex,
              onTap: (i) => setState(() => _partIndex = i),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: _PartBody(
                  part: part,
                  answers: _answers,
                  blankCtrls: _blankCtrls,
                  textCtrls: _textCtrls,
                  onSelect: (id, value) =>
                      setState(() => _answers[id] = value),
                ),
              ),
            ),
            _NavFooter(
              isFirst: _partIndex == 0,
              isLast: _partIndex == parts.length - 1,
              onPrev: () => setState(() => _partIndex--),
              onNext: () {
                if (_partIndex == parts.length - 1) {
                  _submit(module);
                } else {
                  setState(() => _partIndex++);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(LessonModule module) async {
    final gradable = module.gradableQuestions;
    if (gradable.isEmpty) {
      setState(() {
        _scorePercent = 100;
        _passed = true;
        _submitted = true;
      });
      return;
    }
    int correct = 0;
    for (final q in gradable) {
      final picked = _answers[q.id];
      if (picked is int && picked == q.correctIndex) correct++;
    }
    final percent = (correct / gradable.length) * 100;
    final passed = await context
        .read<LearningProvider>()
        .submitQuizResult(module.id, percent);
    if (!mounted) return;
    setState(() {
      _scorePercent = percent;
      _passed = passed;
      _submitted = true;
    });
  }
}

// ────────────────────────────────────────────────────────────────────────
// Header & navigators
// ────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.module});
  final LessonModule module;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 20, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () =>
                context.read<NavigationProvider>().openModule(module.id),
            icon: const Icon(Icons.arrow_back_rounded,
                color: Color(0xFF111C2C)),
          ),
          const SizedBox(width: 4),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: module.accent.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(module.icon, color: module.accent, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${module.shortTitle} · Worksheet',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111C2C),
                  ),
                ),
                const Text(
                  'Score above 50% on Part A to unlock the next module',
                  style: TextStyle(
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

class _PartNavigator extends StatelessWidget {
  const _PartNavigator({
    required this.parts,
    required this.currentIndex,
    required this.onTap,
  });

  final List<QuizPart> parts;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: parts.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = i == currentIndex;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onTap(i),
              borderRadius: BorderRadius.circular(999),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF006184)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: selected
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .03),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      parts[i].emoji,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Part ${parts[i].id}',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF111C2C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavFooter extends StatelessWidget {
  const _NavFooter({
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onNext,
  });
  final bool isFirst;
  final bool isLast;
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
                    'Previous part',
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
                  isLast ? 'Submit worksheet' : 'Next part',
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

// ────────────────────────────────────────────────────────────────────────
// Part body — renders every item type
// ────────────────────────────────────────────────────────────────────────

class _PartBody extends StatelessWidget {
  const _PartBody({
    required this.part,
    required this.answers,
    required this.blankCtrls,
    required this.textCtrls,
    required this.onSelect,
  });

  final QuizPart part;
  final Map<String, dynamic> answers;
  final Map<String, List<TextEditingController>> blankCtrls;
  final Map<String, TextEditingController> textCtrls;
  final void Function(String id, dynamic value) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFC4E7FF),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'PART ${part.id}',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF004C69),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${part.emoji} ${part.title}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111C2C),
            letterSpacing: -0.3,
            height: 1.2,
          ),
        ),
        if (part.intro.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE7EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              part.intro,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF3F484E),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        for (var i = 0; i < part.items.length; i++) ...[
          _ItemView(
            item: part.items[i],
            index: i + 1,
            answers: answers,
            blankCtrls: blankCtrls,
            textCtrls: textCtrls,
            onSelect: onSelect,
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({
    required this.item,
    required this.index,
    required this.answers,
    required this.blankCtrls,
    required this.textCtrls,
    required this.onSelect,
  });

  final QuizItem item;
  final int index;
  final Map<String, dynamic> answers;
  final Map<String, List<TextEditingController>> blankCtrls;
  final Map<String, TextEditingController> textCtrls;
  final void Function(String id, dynamic value) onSelect;

  @override
  Widget build(BuildContext context) {
    if (item.type == QuizItemType.prompt) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFDDB7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.prompt,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7F5000),
              ),
            ),
            if (item.subtitle.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                item.subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF3F484E),
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFC4E7FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Color(0xFF004C69),
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.prompt,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111C2C),
                        height: 1.5,
                      ),
                    ),
                    if (item.helper.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.helper,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF3F484E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _inputForItem(context),
        ],
      ),
    );
  }

  Widget _inputForItem(BuildContext context) {
    switch (item.type) {
      case QuizItemType.mcq:
      case QuizItemType.trueFalse:
        return _OptionsInput(
          options: item.options,
          selected: answers[item.id] as int?,
          onSelect: (i) => onSelect(item.id, i),
        );
      case QuizItemType.shortAnswer:
        return _TextInput(
          ctrlKey: item.id,
          maxLines: 1,
          ctrls: textCtrls,
          onChanged: (v) => onSelect(item.id, v),
        );
      case QuizItemType.longAnswer:
        return _TextInput(
          ctrlKey: item.id,
          maxLines: 4,
          ctrls: textCtrls,
          onChanged: (v) => onSelect(item.id, v),
        );
      case QuizItemType.fillBlanks:
      case QuizItemType.numeric:
        final numeric = item.type == QuizItemType.numeric;
        return _BlanksInput(
          ctrlKey: item.id,
          labels: item.blankLabels,
          ctrls: blankCtrls,
          keyboardType: numeric
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          inputFormatters: numeric
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.%₹\$/\-, ]'))]
              : null,
          onChanged: (i, v) {
            final map = Map<int, String>.from(
                (answers[item.id] as Map<int, String>?) ?? {});
            map[i] = v;
            onSelect(item.id, map);
          },
        );
      case QuizItemType.classify:
        return _ClassifyInput(
          rows: item.blankLabels,
          options: item.classifyOptions,
          values: (answers[item.id] as Map<int, int>?) ?? const {},
          onPick: (row, opt) {
            final map = Map<int, int>.from(
                (answers[item.id] as Map<int, int>?) ?? {});
            map[row] = opt;
            onSelect(item.id, map);
          },
        );
      case QuizItemType.rating:
        return _RatingInput(
          labels: item.blankLabels,
          values: (answers[item.id] as Map<int, int>?) ?? const {},
          onPick: (row, value) {
            final map = Map<int, int>.from(
                (answers[item.id] as Map<int, int>?) ?? {});
            map[row] = value;
            onSelect(item.id, map);
          },
        );
      case QuizItemType.prompt:
        return const SizedBox.shrink();
    }
  }
}

// ────────────────────────────────────────────────────────────────────────
// Input widgets
// ────────────────────────────────────────────────────────────────────────

class _OptionsInput extends StatelessWidget {
  const _OptionsInput({
    required this.options,
    required this.selected,
    required this.onSelect,
  });
  final List<String> options;
  final int? selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onSelect(i),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected == i
                        ? const Color(0xFFC4E7FF)
                        : const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected == i
                              ? const Color(0xFF006184)
                              : Colors.transparent,
                          border: Border.all(
                            color: selected == i
                                ? const Color(0xFF006184)
                                : const Color(0xFFBFC8CF),
                            width: 2,
                          ),
                        ),
                        child: selected == i
                            ? const Icon(Icons.check_rounded,
                                color: Colors.white, size: 14)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          options[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: selected == i
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: const Color(0xFF111C2C),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.ctrlKey,
    required this.maxLines,
    required this.ctrls,
    required this.onChanged,
  });
  final String ctrlKey;
  final int maxLines;
  final Map<String, TextEditingController> ctrls;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final ctrl = ctrls.putIfAbsent(ctrlKey, () => TextEditingController());
    return TextField(
      controller: ctrl,
      minLines: maxLines == 1 ? 1 : 3,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Type your answer…',
        filled: true,
        fillColor: const Color(0xFFF0F3FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}

class _BlanksInput extends StatelessWidget {
  const _BlanksInput({
    required this.ctrlKey,
    required this.labels,
    required this.ctrls,
    required this.keyboardType,
    required this.onChanged,
    this.inputFormatters,
  });

  final String ctrlKey;
  final List<String> labels;
  final Map<String, List<TextEditingController>> ctrls;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(int index, String value) onChanged;

  @override
  Widget build(BuildContext context) {
    final list = ctrls.putIfAbsent(
      ctrlKey,
      () => List.generate(labels.length, (_) => TextEditingController()),
    );
    return Column(
      children: [
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labels[i],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3F484E),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: list[i],
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  onChanged: (v) => onChanged(i, v),
                  decoration: InputDecoration(
                    hintText: '...',
                    filled: true,
                    fillColor: const Color(0xFFF0F3FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ClassifyInput extends StatelessWidget {
  const _ClassifyInput({
    required this.rows,
    required this.options,
    required this.values,
    required this.onPick,
  });
  final List<String> rows;
  final List<String> options;
  final Map<int, int> values;
  final void Function(int row, int opt) onPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rows[i],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111C2C),
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var o = 0; o < options.length; o++)
                      _Chip(
                        label: options[o],
                        selected: values[i] == o,
                        onTap: () => onPick(i, o),
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RatingInput extends StatelessWidget {
  const _RatingInput({
    required this.labels,
    required this.values,
    required this.onPick,
  });
  final List<String> labels;
  final Map<int, int> values;
  final void Function(int row, int value) onPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    labels[i],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111C2C),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var v = 1; v <= 5; v++)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: GestureDetector(
                          onTap: () => onPick(i, v),
                          child: Icon(
                            (values[i] ?? 0) >= v
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 22,
                            color: const Color(0xFFA06600),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF006184)
                : const Color(0xFFF0F3FF),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : const Color(0xFF111C2C),
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────
// Result view
// ────────────────────────────────────────────────────────────────────────

class _ResultView extends StatelessWidget {
  const _ResultView({
    required this.module,
    required this.scorePercent,
    required this.passed,
    required this.answers,
    required this.onRetake,
  });

  final LessonModule module;
  final double scorePercent;
  final bool passed;
  final Map<String, dynamic> answers;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();
    final showCertificate = learning.hasCertificate;
    final accentGradient = passed
        ? const [Color(0xFF006B5F), Color(0xFF006184)]
        : const [Color(0xFFA06600), Color(0xFF7F5000)];

    final gradable = module.gradableQuestions;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: accentGradient,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            passed
                                ? Icons.celebration_rounded
                                : Icons.replay_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            passed
                                ? 'Nice work, you passed!'
                                : 'Almost there',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            passed
                                ? 'Part A score: ${scorePercent.toStringAsFixed(0)}%. The next module is unlocked.'
                                : 'Part A score: ${scorePercent.toStringAsFixed(0)}%. Score above 50% on Part A to unlock the next module.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: .9),
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Review answers (Part A)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111C2C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final q in gradable)
                      _ReviewCard(item: q, picked: answers[q.id] as int?),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          side:
                              const BorderSide(color: Color(0xFFC4E7FF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        onPressed: onRetake,
                        child: const Text(
                          'Retake',
                          style: TextStyle(
                            color: Color(0xFF006184),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF006184),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          final nav = context.read<NavigationProvider>();
                          if (showCertificate) {
                            nav.openCertificate();
                          } else {
                            nav.openTab(MainTab.lessons);
                          }
                        },
                        child: Text(
                          showCertificate
                              ? 'View certificate'
                              : 'Back to lessons',
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
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.item, required this.picked});
  final QuizItem item;
  final int? picked;

  @override
  Widget build(BuildContext context) {
    final correct = picked == item.correctIndex;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                correct
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                color: correct
                    ? const Color(0xFF006B5F)
                    : const Color(0xFFBA1A1A),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.prompt,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111C2C),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (!correct && picked != null && picked! < item.options.length)
            Text(
              'Your answer: ${item.options[picked!]}',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFBA1A1A),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          if (item.correctIndex != null)
            Text(
              'Correct: ${item.options[item.correctIndex!]}',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF006B5F),
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          if (item.explanation.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              item.explanation,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF3F484E),
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
