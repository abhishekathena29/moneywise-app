class AppUserData {
  const AppUserData({
    required this.profile,
    required this.dashboard,
    required this.learning,
    required this.tools,
    required this.profileBadges,
    required this.workshop,
  });

  final UserProfileData profile;
  final DashboardData dashboard;
  final LearningData learning;
  final ToolsData tools;
  final ProfileBadgesData profileBadges;
  final WorkshopData workshop;

  factory AppUserData.initial({required String email, required String name}) {
    return AppUserData(
      profile: UserProfileData(email: email, name: name, impactScore: 850),
      dashboard: const DashboardData(
        streakDays: 5,
        coins: 120,
        dailyGoalTarget: 3,
        dailyGoalCompleted: 2,
        savingsCurrent: 15,
        savingsTarget: 50,
        savingsTitle: 'New Blue Bike',
      ),
      learning: LearningData.initial(),
      tools: ToolsData.initial(),
      profileBadges: ProfileBadgesData.initial(),
      workshop: const WorkshopData(
        selectedIndex: -1,
        submitted: false,
        rewardApplied: false,
      ),
    );
  }

  factory AppUserData.fromMap(Map<String, dynamic> map) {
    return AppUserData(
      profile: UserProfileData.fromMap(
        Map<String, dynamic>.from(map['profile'] as Map? ?? {}),
      ),
      dashboard: DashboardData.fromMap(
        Map<String, dynamic>.from(map['dashboard'] as Map? ?? {}),
      ),
      learning: LearningData.fromMap(
        Map<String, dynamic>.from(map['learning'] as Map? ?? {}),
      ),
      tools: ToolsData.fromMap(
        Map<String, dynamic>.from(map['tools'] as Map? ?? {}),
      ),
      profileBadges: ProfileBadgesData.fromMap(
        Map<String, dynamic>.from(map['profileBadges'] as Map? ?? {}),
      ),
      workshop: WorkshopData.fromMap(
        Map<String, dynamic>.from(map['workshop'] as Map? ?? {}),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile': profile.toMap(),
      'dashboard': dashboard.toMap(),
      'learning': learning.toMap(),
      'tools': tools.toMap(),
      'profileBadges': profileBadges.toMap(),
      'workshop': workshop.toMap(),
    };
  }

  AppUserData copyWith({
    UserProfileData? profile,
    DashboardData? dashboard,
    LearningData? learning,
    ToolsData? tools,
    ProfileBadgesData? profileBadges,
    WorkshopData? workshop,
  }) {
    return AppUserData(
      profile: profile ?? this.profile,
      dashboard: dashboard ?? this.dashboard,
      learning: learning ?? this.learning,
      tools: tools ?? this.tools,
      profileBadges: profileBadges ?? this.profileBadges,
      workshop: workshop ?? this.workshop,
    );
  }
}

class UserProfileData {
  const UserProfileData({
    required this.email,
    required this.name,
    required this.impactScore,
  });

  final String email;
  final String name;
  final int impactScore;

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    return UserProfileData(
      email: (map['email'] ?? '') as String,
      name: (map['name'] ?? 'Alex') as String,
      impactScore: (map['impactScore'] ?? 850) as int,
    );
  }

  Map<String, dynamic> toMap() => {
    'email': email,
    'name': name,
    'impactScore': impactScore,
  };

  UserProfileData copyWith({String? email, String? name, int? impactScore}) {
    return UserProfileData(
      email: email ?? this.email,
      name: name ?? this.name,
      impactScore: impactScore ?? this.impactScore,
    );
  }
}

class DashboardData {
  const DashboardData({
    required this.streakDays,
    required this.coins,
    required this.dailyGoalTarget,
    required this.dailyGoalCompleted,
    required this.savingsCurrent,
    required this.savingsTarget,
    required this.savingsTitle,
  });

  final int streakDays;
  final int coins;
  final int dailyGoalTarget;
  final int dailyGoalCompleted;
  final double savingsCurrent;
  final double savingsTarget;
  final String savingsTitle;

  factory DashboardData.fromMap(Map<String, dynamic> map) {
    return DashboardData(
      streakDays: (map['streakDays'] ?? 5) as int,
      coins: (map['coins'] ?? 120) as int,
      dailyGoalTarget: (map['dailyGoalTarget'] ?? 3) as int,
      dailyGoalCompleted: (map['dailyGoalCompleted'] ?? 2) as int,
      savingsCurrent: ((map['savingsCurrent'] ?? 15) as num).toDouble(),
      savingsTarget: ((map['savingsTarget'] ?? 50) as num).toDouble(),
      savingsTitle: (map['savingsTitle'] ?? 'New Blue Bike') as String,
    );
  }

  Map<String, dynamic> toMap() => {
    'streakDays': streakDays,
    'coins': coins,
    'dailyGoalTarget': dailyGoalTarget,
    'dailyGoalCompleted': dailyGoalCompleted,
    'savingsCurrent': savingsCurrent,
    'savingsTarget': savingsTarget,
    'savingsTitle': savingsTitle,
  };

  DashboardData copyWith({
    int? streakDays,
    int? coins,
    int? dailyGoalTarget,
    int? dailyGoalCompleted,
    double? savingsCurrent,
    double? savingsTarget,
    String? savingsTitle,
  }) {
    return DashboardData(
      streakDays: streakDays ?? this.streakDays,
      coins: coins ?? this.coins,
      dailyGoalTarget: dailyGoalTarget ?? this.dailyGoalTarget,
      dailyGoalCompleted: dailyGoalCompleted ?? this.dailyGoalCompleted,
      savingsCurrent: savingsCurrent ?? this.savingsCurrent,
      savingsTarget: savingsTarget ?? this.savingsTarget,
      savingsTitle: savingsTitle ?? this.savingsTitle,
    );
  }
}

class LearningData {
  const LearningData({required this.moduleProgress});

  final Map<String, double> moduleProgress;

  factory LearningData.initial() {
    return const LearningData(
      moduleProgress: {
        'Money Basics': 0.85,
        'Saving & Budgeting': 0.62,
        'Needs vs Wants': 0.34,
        'Mini Investor Lab': 0.0,
      },
    );
  }

  factory LearningData.fromMap(Map<String, dynamic> map) {
    final source = Map<String, dynamic>.from(
      map['moduleProgress'] as Map? ?? LearningData.initial().moduleProgress,
    );
    return LearningData(
      moduleProgress: source.map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
    );
  }

  Map<String, dynamic> toMap() => {'moduleProgress': moduleProgress};

  LearningData copyWith({Map<String, double>? moduleProgress}) {
    return LearningData(moduleProgress: moduleProgress ?? this.moduleProgress);
  }
}

class ToolsData {
  const ToolsData({
    required this.goalName,
    required this.goalAmount,
    required this.goalWeeks,
    required this.monthlyEntries,
    required this.monthlyCategories,
    required this.weeklySpending,
    required this.familyBudget,
    required this.impulseTrigger,
    required this.impulsePauseRule,
    required this.impulseSupportAction,
    required this.paymentScenarios,
    required this.safetyScenarios,
    required this.goalItemPicture,
    required this.goalPictureLocation,
    required this.progressChartLocation,
    required this.motivationalQuote,
    required this.supportPerson,
    required this.supportCheckin,
    required this.supportQuestion,
    required this.dailyReward,
    required this.weeklyReward,
    required this.monthlyCelebration,
    required this.methodRatings,
  });

  final String goalName;
  final double goalAmount;
  final double goalWeeks;
  final List<Map<String, dynamic>> monthlyEntries;
  final List<Map<String, dynamic>> monthlyCategories;
  final Map<String, double> weeklySpending;
  final Map<String, double> familyBudget;
  final String impulseTrigger;
  final String impulsePauseRule;
  final String impulseSupportAction;
  final List<Map<String, dynamic>> paymentScenarios;
  final List<Map<String, dynamic>> safetyScenarios;
  final String goalItemPicture;
  final String goalPictureLocation;
  final String progressChartLocation;
  final String motivationalQuote;
  final String supportPerson;
  final String supportCheckin;
  final String supportQuestion;
  final String dailyReward;
  final String weeklyReward;
  final String monthlyCelebration;
  final List<Map<String, dynamic>> methodRatings;

  factory ToolsData.initial() {
    return const ToolsData(
      goalName: 'New Video Game',
      goalAmount: 60,
      goalWeeks: 12,
      monthlyEntries: [
        {'title': 'Allowance', 'amount': 35.0, 'isIncome': true, 'day': 'Mon'},
        {
          'title': 'Chore Reward',
          'amount': 20.0,
          'isIncome': true,
          'day': 'Tue',
        },
        {'title': 'Snack Stop', 'amount': 8.5, 'isIncome': false, 'day': 'Wed'},
        {
          'title': 'Birthday Gift',
          'amount': 30.0,
          'isIncome': true,
          'day': 'Fri',
        },
        {'title': 'Notebook', 'amount': 12.7, 'isIncome': false, 'day': 'Sat'},
      ],
      monthlyCategories: [
        {'label': 'Savings Goal', 'percent': 42.0},
        {'label': 'Learning', 'percent': 28.0},
        {'label': 'Fun', 'percent': 18.0},
        {'label': 'Giving', 'percent': 12.0},
      ],
      weeklySpending: {
        'Food': 350,
        'Transport': 180,
        'Fun': 220,
        'Savings': 400,
      },
      familyBudget: {
        'Needs': 6000,
        'Wants': 2200,
        'Savings': 1800,
        'Giving': 500,
      },
      impulseTrigger: 'Late-night scrolling and food cravings',
      impulsePauseRule: 'Wait 24 hours before buying non-essential items.',
      impulseSupportAction:
          'Message Mom or check my savings goal before spending.',
      paymentScenarios: [
        {
          'title': 'Scenario 1',
          'prompt':
              'You want to buy a ₹50 snack from a street vendor who does not have a QR code.',
          'paymentChoice': 'Cash',
          'reason':
              'Cash works immediately when digital payment is not available.',
        },
        {
          'title': 'Scenario 2',
          'prompt':
              'You need to send ₹2000 to your cousin in another city for their birthday.',
          'paymentChoice': 'UPI',
          'reason':
              'UPI is fast, direct, and works well for sending money remotely.',
        },
        {
          'title': 'Scenario 3',
          'prompt': 'You are shopping online for books worth ₹800.',
          'paymentChoice': 'UPI',
          'reason':
              'UPI is secure for many trusted online stores and avoids carrying cash.',
        },
      ],
      safetyScenarios: [
        {
          'title': 'Safety Scenario 1',
          'prompt':
              'Someone calls claiming to be from your bank and asks for your OTP to verify your account.',
          'actionPlan':
              'I will not share the OTP, hang up, and contact the bank using the official number.',
        },
        {
          'title': 'Safety Scenario 2',
          'prompt': 'You accidentally send ₹500 to the wrong UPI ID.',
          'actionPlan':
              'I will raise a complaint in the app, inform the bank, and save the transaction details.',
        },
        {
          'title': 'Safety Scenario 3',
          'prompt':
              'You notice an unknown transaction of ₹200 in your bank statement.',
          'actionPlan':
              'I will tell a parent immediately, block the account if needed, and report the transaction.',
        },
      ],
      goalItemPicture: 'New bicycle',
      goalPictureLocation: 'On my bedroom wall',
      progressChartLocation: 'On my desk',
      motivationalQuote: 'Every rupee saved is a step closer!',
      supportPerson: 'Mom',
      supportCheckin: 'Every week',
      supportQuestion: 'How much did you save this week?',
      dailyReward: 'Extra 15 min screen time',
      weeklyReward: 'Favorite dessert',
      monthlyCelebration: 'Family movie night',
      methodRatings: [
        {
          'method': 'Piggy bank/jar',
          'easyToUse': 5,
          'motivating': 4,
          'helpsAvoidSpending': 4,
        },
        {
          'method': 'Bank account',
          'easyToUse': 4,
          'motivating': 3,
          'helpsAvoidSpending': 5,
        },
        {
          'method': 'Parent-held savings',
          'easyToUse': 4,
          'motivating': 3,
          'helpsAvoidSpending': 5,
        },
        {
          'method': 'Envelope system',
          'easyToUse': 3,
          'motivating': 4,
          'helpsAvoidSpending': 4,
        },
      ],
    );
  }

  factory ToolsData.fromMap(Map<String, dynamic> map) {
    final initial = ToolsData.initial();
    return ToolsData(
      goalName: (map['goalName'] ?? initial.goalName) as String,
      goalAmount: ((map['goalAmount'] ?? initial.goalAmount) as num).toDouble(),
      goalWeeks: ((map['goalWeeks'] ?? initial.goalWeeks) as num).toDouble(),
      monthlyEntries: _listOfMaps(
        map['monthlyEntries'],
        fallback: initial.monthlyEntries,
      ),
      monthlyCategories: _listOfMaps(
        map['monthlyCategories'],
        fallback: initial.monthlyCategories,
      ),
      weeklySpending: _mapOfDouble(
        map['weeklySpending'],
        fallback: initial.weeklySpending,
      ),
      familyBudget: _mapOfDouble(
        map['familyBudget'],
        fallback: initial.familyBudget,
      ),
      impulseTrigger:
          (map['impulseTrigger'] ?? initial.impulseTrigger) as String,
      impulsePauseRule:
          (map['impulsePauseRule'] ?? initial.impulsePauseRule) as String,
      impulseSupportAction:
          (map['impulseSupportAction'] ?? initial.impulseSupportAction)
              as String,
      paymentScenarios: _listOfMaps(
        map['paymentScenarios'],
        fallback: initial.paymentScenarios,
      ),
      safetyScenarios: _listOfMaps(
        map['safetyScenarios'],
        fallback: initial.safetyScenarios,
      ),
      goalItemPicture:
          (map['goalItemPicture'] ?? initial.goalItemPicture) as String,
      goalPictureLocation:
          (map['goalPictureLocation'] ?? initial.goalPictureLocation) as String,
      progressChartLocation:
          (map['progressChartLocation'] ?? initial.progressChartLocation)
              as String,
      motivationalQuote:
          (map['motivationalQuote'] ?? initial.motivationalQuote) as String,
      supportPerson: (map['supportPerson'] ?? initial.supportPerson) as String,
      supportCheckin:
          (map['supportCheckin'] ?? initial.supportCheckin) as String,
      supportQuestion:
          (map['supportQuestion'] ?? initial.supportQuestion) as String,
      dailyReward: (map['dailyReward'] ?? initial.dailyReward) as String,
      weeklyReward: (map['weeklyReward'] ?? initial.weeklyReward) as String,
      monthlyCelebration:
          (map['monthlyCelebration'] ?? initial.monthlyCelebration) as String,
      methodRatings: _listOfMaps(
        map['methodRatings'],
        fallback: initial.methodRatings,
      ),
    );
  }

  Map<String, dynamic> toMap() => {
    'goalName': goalName,
    'goalAmount': goalAmount,
    'goalWeeks': goalWeeks,
    'monthlyEntries': monthlyEntries,
    'monthlyCategories': monthlyCategories,
    'weeklySpending': weeklySpending,
    'familyBudget': familyBudget,
    'impulseTrigger': impulseTrigger,
    'impulsePauseRule': impulsePauseRule,
    'impulseSupportAction': impulseSupportAction,
    'paymentScenarios': paymentScenarios,
    'safetyScenarios': safetyScenarios,
    'goalItemPicture': goalItemPicture,
    'goalPictureLocation': goalPictureLocation,
    'progressChartLocation': progressChartLocation,
    'motivationalQuote': motivationalQuote,
    'supportPerson': supportPerson,
    'supportCheckin': supportCheckin,
    'supportQuestion': supportQuestion,
    'dailyReward': dailyReward,
    'weeklyReward': weeklyReward,
    'monthlyCelebration': monthlyCelebration,
    'methodRatings': methodRatings,
  };

  ToolsData copyWith({
    String? goalName,
    double? goalAmount,
    double? goalWeeks,
    List<Map<String, dynamic>>? monthlyEntries,
    List<Map<String, dynamic>>? monthlyCategories,
    Map<String, double>? weeklySpending,
    Map<String, double>? familyBudget,
    String? impulseTrigger,
    String? impulsePauseRule,
    String? impulseSupportAction,
    List<Map<String, dynamic>>? paymentScenarios,
    List<Map<String, dynamic>>? safetyScenarios,
    String? goalItemPicture,
    String? goalPictureLocation,
    String? progressChartLocation,
    String? motivationalQuote,
    String? supportPerson,
    String? supportCheckin,
    String? supportQuestion,
    String? dailyReward,
    String? weeklyReward,
    String? monthlyCelebration,
    List<Map<String, dynamic>>? methodRatings,
  }) {
    return ToolsData(
      goalName: goalName ?? this.goalName,
      goalAmount: goalAmount ?? this.goalAmount,
      goalWeeks: goalWeeks ?? this.goalWeeks,
      monthlyEntries: monthlyEntries ?? this.monthlyEntries,
      monthlyCategories: monthlyCategories ?? this.monthlyCategories,
      weeklySpending: weeklySpending ?? this.weeklySpending,
      familyBudget: familyBudget ?? this.familyBudget,
      impulseTrigger: impulseTrigger ?? this.impulseTrigger,
      impulsePauseRule: impulsePauseRule ?? this.impulsePauseRule,
      impulseSupportAction: impulseSupportAction ?? this.impulseSupportAction,
      paymentScenarios: paymentScenarios ?? this.paymentScenarios,
      safetyScenarios: safetyScenarios ?? this.safetyScenarios,
      goalItemPicture: goalItemPicture ?? this.goalItemPicture,
      goalPictureLocation: goalPictureLocation ?? this.goalPictureLocation,
      progressChartLocation:
          progressChartLocation ?? this.progressChartLocation,
      motivationalQuote: motivationalQuote ?? this.motivationalQuote,
      supportPerson: supportPerson ?? this.supportPerson,
      supportCheckin: supportCheckin ?? this.supportCheckin,
      supportQuestion: supportQuestion ?? this.supportQuestion,
      dailyReward: dailyReward ?? this.dailyReward,
      weeklyReward: weeklyReward ?? this.weeklyReward,
      monthlyCelebration: monthlyCelebration ?? this.monthlyCelebration,
      methodRatings: methodRatings ?? this.methodRatings,
    );
  }
}

class ProfileBadgesData {
  const ProfileBadgesData({required this.earnedBadgeTitles});

  final List<String> earnedBadgeTitles;

  factory ProfileBadgesData.initial() {
    return const ProfileBadgesData(
      earnedBadgeTitles: [
        'Smart Saver',
        'Budget Boss',
        'Goal Crusher',
        'Quiz Champ',
        'Streak Star',
        'Coin Collector',
      ],
    );
  }

  factory ProfileBadgesData.fromMap(Map<String, dynamic> map) {
    return ProfileBadgesData(
      earnedBadgeTitles: (map['earnedBadgeTitles'] as List? ?? const [])
          .map((item) => item.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {'earnedBadgeTitles': earnedBadgeTitles};

  ProfileBadgesData copyWith({List<String>? earnedBadgeTitles}) {
    return ProfileBadgesData(
      earnedBadgeTitles: earnedBadgeTitles ?? this.earnedBadgeTitles,
    );
  }
}

class WorkshopData {
  const WorkshopData({
    required this.selectedIndex,
    required this.submitted,
    required this.rewardApplied,
  });

  final int selectedIndex;
  final bool submitted;
  final bool rewardApplied;

  factory WorkshopData.fromMap(Map<String, dynamic> map) {
    return WorkshopData(
      selectedIndex: (map['selectedIndex'] ?? -1) as int,
      submitted: (map['submitted'] ?? false) as bool,
      rewardApplied: (map['rewardApplied'] ?? false) as bool,
    );
  }

  Map<String, dynamic> toMap() => {
    'selectedIndex': selectedIndex,
    'submitted': submitted,
    'rewardApplied': rewardApplied,
  };

  WorkshopData copyWith({
    int? selectedIndex,
    bool? submitted,
    bool? rewardApplied,
  }) {
    return WorkshopData(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      submitted: submitted ?? this.submitted,
      rewardApplied: rewardApplied ?? this.rewardApplied,
    );
  }
}

List<Map<String, dynamic>> _listOfMaps(
  dynamic source, {
  required List<Map<String, dynamic>> fallback,
}) {
  final raw = source as List?;
  if (raw == null) {
    return fallback;
  }
  return raw
      .map((item) => Map<String, dynamic>.from(item as Map))
      .toList(growable: false);
}

Map<String, double> _mapOfDouble(
  dynamic source, {
  required Map<String, double> fallback,
}) {
  final raw = source as Map?;
  if (raw == null) {
    return fallback;
  }
  return Map<String, dynamic>.from(
    raw,
  ).map((key, value) => MapEntry(key, (value as num).toDouble()));
}
