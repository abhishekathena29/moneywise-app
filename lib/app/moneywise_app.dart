import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/repositories/user_data_repository.dart';
import '../features/about/providers/about_provider.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/dashboard/providers/dashboard_provider.dart';
import '../features/learning/providers/learning_provider.dart';
import '../features/onboarding/providers/onboarding_provider.dart';
import '../features/profile/providers/profile_provider.dart';
import '../features/tools/providers/tools_provider.dart';
import '../features/user_data/providers/user_data_provider.dart';
import '../features/workshop/providers/workshop_provider.dart';
import '../theme/app_theme.dart';
import 'navigation/navigation_provider.dart';
import 'root_flow_screen.dart';

class MoneyWiseApp extends StatelessWidget {
  const MoneyWiseApp({super.key, this.useFirebase = true});

  final bool useFirebase;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyWise Junior',
      theme: buildAppTheme(),
      home: const RootFlowScreen(),
    );

    if (!useFirebase) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider.fake()),
          ChangeNotifierProxyProvider<AuthProvider, NavigationProvider>(
            create: (_) => NavigationProvider(),
            update: (_, auth, navigation) => navigation!..syncAuth(auth),
          ),
          ChangeNotifierProvider(create: (_) => OnboardingProvider()),
          ChangeNotifierProvider(create: (_) => AboutProvider()),
          ChangeNotifierProvider(create: (_) => UserDataProvider.fake()),
          ChangeNotifierProxyProvider<UserDataProvider, DashboardProvider>(
            create: (_) => DashboardProvider(),
            update: (_, userData, dashboard) => dashboard!..bind(userData),
          ),
          ChangeNotifierProxyProvider<UserDataProvider, LearningProvider>(
            create: (_) => LearningProvider(),
            update: (_, userData, learning) => learning!..bind(userData),
          ),
          ChangeNotifierProxyProvider<UserDataProvider, ToolsProvider>(
            create: (_) => ToolsProvider(),
            update: (_, userData, tools) => tools!..bind(userData),
          ),
          ChangeNotifierProxyProvider<UserDataProvider, WorkshopProvider>(
            create: (_) => WorkshopProvider(),
            update: (_, userData, workshop) => workshop!..bind(userData),
          ),
          ChangeNotifierProxyProvider<UserDataProvider, ProfileProvider>(
            create: (_) => ProfileProvider(),
            update: (_, userData, profile) => profile!..bind(userData),
          ),
        ],
        child: app,
      );
    }

    return MultiProvider(
      providers: [
        Provider(create: (_) => UserDataRepository()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read<UserDataRepository>()),
        ),
        ChangeNotifierProxyProvider<AuthProvider, NavigationProvider>(
          create: (_) => NavigationProvider(),
          update: (_, auth, navigation) => navigation!..syncAuth(auth),
        ),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => AboutProvider()),
        ChangeNotifierProxyProvider<AuthProvider, UserDataProvider>(
          create: (context) =>
              UserDataProvider(context.read<UserDataRepository>()),
          update: (_, auth, userData) => userData!..bindAuth(auth),
        ),
        ChangeNotifierProxyProvider<UserDataProvider, DashboardProvider>(
          create: (_) => DashboardProvider(),
          update: (_, userData, dashboard) => dashboard!..bind(userData),
        ),
        ChangeNotifierProxyProvider<UserDataProvider, LearningProvider>(
          create: (_) => LearningProvider(),
          update: (_, userData, learning) => learning!..bind(userData),
        ),
        ChangeNotifierProxyProvider<UserDataProvider, ToolsProvider>(
          create: (_) => ToolsProvider(),
          update: (_, userData, tools) => tools!..bind(userData),
        ),
        ChangeNotifierProxyProvider<UserDataProvider, WorkshopProvider>(
          create: (_) => WorkshopProvider(),
          update: (_, userData, workshop) => workshop!..bind(userData),
        ),
        ChangeNotifierProxyProvider<UserDataProvider, ProfileProvider>(
          create: (_) => ProfileProvider(),
          update: (_, userData, profile) => profile!..bind(userData),
        ),
      ],
      child: app,
    );
  }
}
