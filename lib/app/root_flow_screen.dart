import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/providers/auth_provider.dart';
import '../features/about/ui/about_app_screen.dart';
import '../features/auth/ui/login_screen.dart';
import '../features/auth/ui/sign_up_screen.dart';
import '../features/auth/ui/splash_screen.dart';
import '../features/dashboard/ui/dashboard_screen.dart';
import '../features/learning/ui/learning_modules_screen.dart';
import '../features/learning/ui/lesson_detail_screen.dart';
import '../features/onboarding/ui/onboarding_one_screen.dart';
import '../features/onboarding/ui/onboarding_two_screen.dart';
import '../features/profile/ui/profile_screen.dart';
import '../features/tools/ui/family_budget_simulator_screen.dart';
import '../features/tools/ui/impulse_buying_plan_screen.dart';
import '../features/tools/ui/monthly_tracker_screen.dart';
import '../features/tools/ui/motivation_toolkit_screen.dart';
import '../features/tools/ui/payment_method_scenarios_screen.dart';
import '../features/tools/ui/savings_goal_screen.dart';
import '../features/tools/ui/tools_hub_screen.dart';
import '../features/tools/ui/weekly_spending_tracker_screen.dart';
import '../features/user_data/providers/user_data_provider.dart';
import '../features/workshop/ui/workshop_screen.dart';
import 'navigation/navigation_provider.dart';

class RootFlowScreen extends StatelessWidget {
  const RootFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final userData = context.watch<UserDataProvider>();
    if (!auth.initialized ||
        (auth.isLoggedIn && userData.isLoading && !userData.isReady)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final route = context.watch<NavigationProvider>().currentRoute;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: switch (route) {
        AppRoute.splash => const SplashScreen(),
        AppRoute.onboardingOne => const OnboardingOneScreen(),
        AppRoute.onboardingTwo => const OnboardingTwoScreen(),
        AppRoute.signUp => const SignUpScreen(),
        AppRoute.login => const LoginScreen(),
        AppRoute.dashboard => const DashboardScreen(),
        AppRoute.learningModules => const LearningModulesScreen(),
        AppRoute.lessonDetail => const LessonDetailScreen(),
        AppRoute.toolsHub => const ToolsHubScreen(),
        AppRoute.monthlyTracker => const MonthlyTrackerScreen(),
        AppRoute.savingsGoalCalculator => const SavingsGoalScreen(),
        AppRoute.weeklySpendingTracker => const WeeklySpendingTrackerScreen(),
        AppRoute.familyBudgetSimulator => const FamilyBudgetSimulatorScreen(),
        AppRoute.impulseBuyingPlan => const ImpulseBuyingPlanScreen(),
        AppRoute.paymentMethodScenarios => const PaymentMethodScenariosScreen(),
        AppRoute.motivationToolkit => const MotivationToolkitScreen(),
        AppRoute.workshop => const WorkshopScreen(),
        AppRoute.profile => const ProfileScreen(),
        AppRoute.about => const AboutAppScreen(),
      },
    );
  }
}
