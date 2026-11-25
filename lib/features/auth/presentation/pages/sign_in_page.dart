import 'package:flutter/material.dart';

import '../widgets/auth_scaffold.dart';
import '../widgets/auth_switch_link.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    // Mode pratinjau UI: langsung masuk ke beranda tanpa autentikasi.
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Senang kamu balik.',
      stepLabel: '01 / ENTER',
      children: [
        AuthTextField(
          label: 'Email',
          hint: 'kamu@email.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 18),
        AuthTextField(
          label: 'Kata sandi',
          hint: 'Minimal 8 karakter',
          controller: _passwordController,
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 22),
        PrimaryButton(label: 'Sign in', onPressed: _onSignIn),
        const SizedBox(height: 26),
        AuthSwitchLink(
          prompt: 'Baru di sini?',
          action: 'Sign up',
          onTap: () =>
              Navigator.of(context).pushReplacementNamed('/sign-up'),
        ),
      ],
    );
  }
}
