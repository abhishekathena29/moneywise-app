import 'package:flutter/material.dart';

import '../../../core/models/app_models.dart';
import '../../../core/models/user_app_data.dart';
import '../../user_data/providers/user_data_provider.dart';

class ToolDefinition {
  const ToolDefinition({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

class PaymentScenarioResponse {
  PaymentScenarioResponse({
    required this.title,
    required this.prompt,
    this.paymentChoice = '',
    this.reason = '',
  });

  final String title;
  final String prompt;
  String paymentChoice;
  String reason;
}

class SafetyScenarioResponse {
  SafetyScenarioResponse({
    required this.title,
    required this.prompt,
    this.actionPlan = '',
  });

  final String title;
  final String prompt;
  String actionPlan;
}

class MotivationMethodRating {
  MotivationMethodRating({
    required this.method,
    this.easyToUse = 3,
    this.motivating = 3,
    this.helpsAvoidSpending = 3,
  });

  final String method;
  int easyToUse;
  int motivating;
  int helpsAvoidSpending;
}

class ToolsProvider extends ChangeNotifier {
  final List<ToolDefinition> tools = const [
    ToolDefinition(
      title: 'My Monthly Money Tracker',
      subtitle: 'Track income, spending, and balance over the month.',
      icon: Icons.account_balance_wallet_rounded,
    ),
    ToolDefinition(
      title: 'Savings Goal Calculator',
      subtitle: 'Plan how much to save each week for your goal.',
      icon: Icons.savings_rounded,
    ),
    ToolDefinition(
      title: 'Weekly Spending Tracker',
      subtitle: 'Review how your money moved this week.',
      icon: Icons.calendar_view_week_rounded,
    ),
    ToolDefinition(
      title: 'Family Budget Simulator',
      subtitle: 'Practice balancing needs, wants, and savings.',
      icon: Icons.groups_rounded,
    ),
    ToolDefinition(
      title: 'Emergency Plan for Impulse Buying',
      subtitle: 'Build a simple pause plan before quick purchases.',
      icon: Icons.shield_moon_rounded,
    ),
    ToolDefinition(
      title: 'Payment Method Scenarios',
      subtitle: 'Choose the best payment method and practice safety.',
      icon: Icons.payments_rounded,
    ),
    ToolDefinition(
      title: 'Motivation Toolkit',
      subtitle: 'Create reminders, support systems, and rewards.',
      icon: Icons.emoji_objects_rounded,
    ),
  ];

  UserDataProvider? _userDataProvider;

  ToolsData get _tools =>
      _userDataProvider?.data?.tools ??
      AppUserData.initial(email: '', name: 'Alex').tools;

  List<TrackerEntry> get monthlyEntries => _tools.monthlyEntries
      .map(
        (entry) => TrackerEntry(
          entry['title'] as String,
          (entry['amount'] as num).toDouble(),
          entry['isIncome'] as bool,
          entry['day'] as String,
        ),
      )
      .toList(growable: false);

  List<SpendCategory> get monthlyCategories {
    const colors = [
      Color(0xFF7CD0FF),
      Color(0xFF006184),
      Color(0xFFA06600),
      Color(0xFF006B5F),
    ];
    return _tools.monthlyCategories
        .asMap()
        .entries
        .map((entry) {
          final item = entry.value;
          return SpendCategory(
            item['label'] as String,
            (item['percent'] as num).toDouble(),
            colors[entry.key % colors.length],
          );
        })
        .toList(growable: false);
  }

  String get goalName => _tools.goalName;
  double get goalAmount => _tools.goalAmount;
  double get goalWeeks => _tools.goalWeeks;
  Map<String, double> get weeklySpending => _tools.weeklySpending;
  Map<String, double> get familyBudget => _tools.familyBudget;
  String get impulseTrigger => _tools.impulseTrigger;
  String get impulsePauseRule => _tools.impulsePauseRule;
  String get impulseSupportAction => _tools.impulseSupportAction;
  String get goalItemPicture => _tools.goalItemPicture;
  String get goalPictureLocation => _tools.goalPictureLocation;
  String get progressChartLocation => _tools.progressChartLocation;
  String get motivationalQuote => _tools.motivationalQuote;
  String get supportPerson => _tools.supportPerson;
  String get supportCheckin => _tools.supportCheckin;
  String get supportQuestion => _tools.supportQuestion;
  String get dailyReward => _tools.dailyReward;
  String get weeklyReward => _tools.weeklyReward;
  String get monthlyCelebration => _tools.monthlyCelebration;

  List<PaymentScenarioResponse> get paymentScenarios => _tools.paymentScenarios
      .map(
        (item) => PaymentScenarioResponse(
          title: item['title'] as String,
          prompt: item['prompt'] as String,
          paymentChoice: item['paymentChoice'] as String? ?? '',
          reason: item['reason'] as String? ?? '',
        ),
      )
      .toList(growable: false);

  List<SafetyScenarioResponse> get safetyScenarios => _tools.safetyScenarios
      .map(
        (item) => SafetyScenarioResponse(
          title: item['title'] as String,
          prompt: item['prompt'] as String,
          actionPlan: item['actionPlan'] as String? ?? '',
        ),
      )
      .toList(growable: false);

  List<MotivationMethodRating> get methodRatings => _tools.methodRatings
      .map(
        (item) => MotivationMethodRating(
          method: item['method'] as String,
          easyToUse: item['easyToUse'] as int? ?? 3,
          motivating: item['motivating'] as int? ?? 3,
          helpsAvoidSpending: item['helpsAvoidSpending'] as int? ?? 3,
        ),
      )
      .toList(growable: false);

  double get weeklySavingRequired => goalAmount / goalWeeks;
  double get monthlyIncome => monthlyEntries
      .where((entry) => entry.isIncome)
      .fold(0, (sum, entry) => sum + entry.amount);
  double get monthlySpent => monthlyEntries
      .where((entry) => !entry.isIncome)
      .fold(0, (sum, entry) => sum + entry.amount);
  double get monthlyBalance => monthlyIncome - monthlySpent + 90.7;
  double get weeklyTotal =>
      weeklySpending.values.fold(0, (sum, value) => sum + value);
  double get familyBudgetTotal =>
      familyBudget.values.fold(0, (sum, value) => sum + value);

  void bind(UserDataProvider provider) {
    _userDataProvider = provider;
    notifyListeners();
  }

  Future<void> setGoalName(String value) async {
    await _updateTools(_tools.copyWith(goalName: value));
  }

  Future<void> setGoalAmount(double value) async {
    await _updateTools(_tools.copyWith(goalAmount: value));
  }

  Future<void> setGoalWeeks(double value) async {
    await _updateTools(_tools.copyWith(goalWeeks: value));
  }

  Future<void> updatePaymentChoice(int index, String value) async {
    final updated = List<Map<String, dynamic>>.from(_tools.paymentScenarios);
    updated[index] = {...updated[index], 'paymentChoice': value};
    await _updateTools(_tools.copyWith(paymentScenarios: updated));
  }

  Future<void> updatePaymentReason(int index, String value) async {
    final updated = List<Map<String, dynamic>>.from(_tools.paymentScenarios);
    updated[index] = {...updated[index], 'reason': value};
    await _updateTools(_tools.copyWith(paymentScenarios: updated));
  }

  Future<void> updateSafetyAction(int index, String value) async {
    final updated = List<Map<String, dynamic>>.from(_tools.safetyScenarios);
    updated[index] = {...updated[index], 'actionPlan': value};
    await _updateTools(_tools.copyWith(safetyScenarios: updated));
  }

  Future<void> updateMotivationField({
    String? goalItemPictureValue,
    String? goalPictureLocationValue,
    String? progressChartLocationValue,
    String? motivationalQuoteValue,
    String? supportPersonValue,
    String? supportCheckinValue,
    String? supportQuestionValue,
    String? dailyRewardValue,
    String? weeklyRewardValue,
    String? monthlyCelebrationValue,
  }) async {
    await _updateTools(
      _tools.copyWith(
        goalItemPicture: goalItemPictureValue,
        goalPictureLocation: goalPictureLocationValue,
        progressChartLocation: progressChartLocationValue,
        motivationalQuote: motivationalQuoteValue,
        supportPerson: supportPersonValue,
        supportCheckin: supportCheckinValue,
        supportQuestion: supportQuestionValue,
        dailyReward: dailyRewardValue,
        weeklyReward: weeklyRewardValue,
        monthlyCelebration: monthlyCelebrationValue,
      ),
    );
  }

  Future<void> updateMethodRating({
    required int index,
    int? easyToUse,
    int? motivating,
    int? helpsAvoidSpending,
  }) async {
    final updated = List<Map<String, dynamic>>.from(_tools.methodRatings);
    updated[index] = {
      ...updated[index],
      'easyToUse': ?easyToUse,
      'motivating': ?motivating,
      'helpsAvoidSpending': ?helpsAvoidSpending,
    };
    await _updateTools(_tools.copyWith(methodRatings: updated));
  }

  Future<void> addMonthlyEntry({
    required String title,
    required double amount,
    required bool isIncome,
  }) async {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final day = days[DateTime.now().weekday - 1];
    final updated = [
      ...List<Map<String, dynamic>>.from(_tools.monthlyEntries),
      {'title': title, 'amount': amount, 'isIncome': isIncome, 'day': day},
    ];
    await _updateTools(_tools.copyWith(monthlyEntries: updated));
  }

  Future<void> removeMonthlyEntry(int index) async {
    final updated =
        List<Map<String, dynamic>>.from(_tools.monthlyEntries)
          ..removeAt(index);
    await _updateTools(_tools.copyWith(monthlyEntries: updated));
  }

  Future<void> _updateTools(ToolsData data) async {
    await _userDataProvider?.updateTools(data);
  }
}
