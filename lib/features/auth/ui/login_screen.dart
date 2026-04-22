import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: _LoginForm(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: kBrandSoft,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.school_rounded,
            color: kBrandPrimary,
            size: 28,
          ),
        ),
        const SizedBox(height: 24),
        Text('Welcome back', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 8),
        Text(
          'Log in to continue your money journey.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 28),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          onChanged: (_) => context.read<AuthProvider>().clearError(),
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: passwordController,
          obscureText: true,
          onChanged: (_) => context.read<AuthProvider>().clearError(),
          decoration: const InputDecoration(labelText: 'Password'),
        ),
        if (auth.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            auth.errorMessage!,
            style: const TextStyle(
              color: Color(0xFFBA1A1A),
              fontSize: 13,
            ),
          ),
        ],
        const SizedBox(height: 20),
        PrimaryButton(
          label: auth.isBusy ? 'Logging in…' : 'Log in',
          onPressed: auth.isBusy
              ? null
              : () async {
                  await context.read<AuthProvider>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                  if (!context.mounted) return;
                  if (context.read<AuthProvider>().isLoggedIn) {
                    context
                        .read<NavigationProvider>()
                        .openAuthenticatedHome();
                  }
                },
        ),
        if (auth.isBusy) ...[
          const SizedBox(height: 12),
          const LinearProgressIndicator(),
        ],
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot password?'),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: auth.isBusy
                ? null
                : context.read<NavigationProvider>().openSignup,
            child: const Text('New here? Create an account'),
          ),
        ),
      ],
    );
  }
}
