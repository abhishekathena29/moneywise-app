import 'package:flutter/material.dart';

import '../../features/auth/providers/auth_provider.dart';

enum AppRoute {
  splash,
  onboardingOne,
  onboardingTwo,
  signUp,
  login,
  dashboard,
  learningModules,
  lessonDetail,
  lessonQuiz,
  certificate,
  chatbot,
  toolsHub,
  monthlyTracker,
  savingsGoalCalculator,
  weeklySpendingTracker,
  familyBudgetSimulator,
  impulseBuyingPlan,
  paymentMethodScenarios,
  motivationToolkit,
  workshop,
  profile,
  about,
}

enum MainTab { home, lessons, tools, workshop, profile }

class NavigationProvider extends ChangeNotifier {
  AppRoute _currentRoute = AppRoute.splash;
  MainTab _activeTab = MainTab.home;
  String? _selectedLessonTitle;
  String? _selectedModuleId;
  bool _certificatePreview = false;

  AppRoute get currentRoute => _currentRoute;
  MainTab get activeTab => _activeTab;
  String? get selectedLessonTitle => _selectedLessonTitle;
  String? get selectedModuleId => _selectedModuleId;
  bool get certificatePreview => _certificatePreview;

  void goTo(AppRoute route) {
    _currentRoute = route;
    notifyListeners();
  }

  void openLesson(String lessonTitle) {
    _selectedLessonTitle = lessonTitle;
    _currentRoute = AppRoute.lessonDetail;
    notifyListeners();
  }

  void openModule(String moduleId) {
    _selectedModuleId = moduleId;
    _currentRoute = AppRoute.lessonDetail;
    notifyListeners();
  }

  void openQuiz(String moduleId) {
    _selectedModuleId = moduleId;
    _currentRoute = AppRoute.lessonQuiz;
    notifyListeners();
  }

  void openCertificate({bool preview = false}) {
    _currentRoute = AppRoute.certificate;
    _certificatePreview = preview;
    notifyListeners();
  }

  void openChatbot() {
    _currentRoute = AppRoute.chatbot;
    notifyListeners();
  }

  void openTab(MainTab tab) {
    _activeTab = tab;
    _currentRoute = switch (tab) {
      MainTab.home => AppRoute.dashboard,
      MainTab.lessons => AppRoute.learningModules,
      MainTab.tools => AppRoute.toolsHub,
      MainTab.workshop => AppRoute.workshop,
      MainTab.profile => AppRoute.profile,
    };
    notifyListeners();
  }

  void startOnboarding() {
    _currentRoute = AppRoute.onboardingOne;
    notifyListeners();
  }

  void finishOnboardingOne() {
    _currentRoute = AppRoute.onboardingTwo;
    notifyListeners();
  }

  void finishOnboardingTwo() {
    _currentRoute = AppRoute.signUp;
    notifyListeners();
  }

  void openSignup() {
    _currentRoute = AppRoute.signUp;
    notifyListeners();
  }

  void openLogin() {
    _currentRoute = AppRoute.login;
    notifyListeners();
  }

  void openAuthenticatedHome() {
    _activeTab = MainTab.home;
    _currentRoute = AppRoute.dashboard;
    notifyListeners();
  }

  void syncAuth(AuthProvider auth) {
    if (!auth.initialized) {
      return;
    }
    if (auth.isLoggedIn) {
      final authRoutes = {
        AppRoute.splash,
        AppRoute.onboardingOne,
        AppRoute.onboardingTwo,
        AppRoute.signUp,
        AppRoute.login,
      };
      if (authRoutes.contains(_currentRoute)) {
        _activeTab = MainTab.home;
        _currentRoute = AppRoute.dashboard;
        notifyListeners();
      }
      return;
    }

    final protectedRoutes = {
      AppRoute.dashboard,
      AppRoute.learningModules,
      AppRoute.lessonDetail,
      AppRoute.lessonQuiz,
      AppRoute.certificate,
      AppRoute.chatbot,
      AppRoute.toolsHub,
      AppRoute.monthlyTracker,
      AppRoute.savingsGoalCalculator,
      AppRoute.weeklySpendingTracker,
      AppRoute.familyBudgetSimulator,
      AppRoute.impulseBuyingPlan,
      AppRoute.paymentMethodScenarios,
      AppRoute.motivationToolkit,
      AppRoute.workshop,
      AppRoute.profile,
      AppRoute.about,
    };
    if (protectedRoutes.contains(_currentRoute)) {
      _activeTab = MainTab.home;
      _currentRoute = AppRoute.splash;
      notifyListeners();
    }
  }
}
