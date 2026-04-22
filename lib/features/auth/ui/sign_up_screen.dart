import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/navigation/navigation_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
            child: _SignupForm(
              nameController: _nameController,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ),
        ),
      ),
    );
  }
}

class _SignupForm extends StatelessWidget {
  const _SignupForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
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
            Icons.savings_rounded,
            color: kBrandPrimary,
            size: 28,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Create account',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Start your financial adventure today.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 28),
        TextField(
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          onChanged: (_) => context.read<AuthProvider>().clearError(),
          decoration: const InputDecoration(labelText: 'Your name'),
        ),
        const SizedBox(height: 12),
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
            style: const TextStyle(color: Color(0xFFBA1A1A), fontSize: 13),
          ),
        ],
        const SizedBox(height: 20),
        PrimaryButton(
          label: auth.isBusy ? 'Creating…' : 'Create account',
          onPressed: auth.isBusy
              ? null
              : () async {
                  await context.read<AuthProvider>().signUp(
                    name: nameController.text.trim(),
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
        Center(
          child: TextButton(
            onPressed: auth.isBusy
                ? null
                : context.read<NavigationProvider>().openLogin,
            child: const Text('Already have an account? Log in'),
          ),
        ),
      ],
    );
  }
}
