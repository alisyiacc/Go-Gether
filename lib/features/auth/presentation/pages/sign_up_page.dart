import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../profile/data/profile_store.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_switch_link.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    ProfileStore.setName(_nameController.text);
    // TODO: sambungkan ke pendaftaran akun sebelum rilis.
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      footnote: 'Nama panggilanmu bisa diubah kapan saja di Pengaturan akun.',
      children: [
        AuthTextField(
          label: 'Nama panggilan',
          hint: 'Mau dipanggil siapa?',
          controller: _nameController,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 18),
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
        const SizedBox(height: 18),
        _AgreementRow(
          value: _agreed,
          onChanged: (v) => setState(() => _agreed = v),
        ),
        const SizedBox(height: 18),
        PrimaryButton(label: 'Sign up', onPressed: _onSignUp),
        const SizedBox(height: 26),
        AuthSwitchLink(
          prompt: 'Sudah punya akun?',
          action: 'Sign in',
          onTap: () =>
              Navigator.of(context).pushReplacementNamed('/sign-in'),
        ),
      ],
    );
  }
}

class _AgreementRow extends StatelessWidget {
  const _AgreementRow({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: value ? AppColors.ink : AppColors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.ink, width: 1.5),
            ),
            child: value
                ? const Icon(Icons.check, size: 14, color: AppColors.lime)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Saya setuju dengan Syarat & Ketentuan dan Kebijakan Privasi GOGether.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                height: 1.35,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}