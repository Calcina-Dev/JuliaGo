import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/common/app_text_input.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final bool loading;
  final VoidCallback onLogin;

  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscure,
    required this.onToggleObscure,
    required this.loading,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.mobileCardPadding,
          vertical: AppStyles.mobileCardPadding + 8,
        ),
        decoration: BoxDecoration(
          color: AppStyles.cardColor,
          borderRadius: AppStyles.mobileCardBorderRadius,
          boxShadow: AppStyles.mobileCardBoxShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SectionTitle(title: "Login"),
            const SizedBox(height: AppStyles.mobileInputSpacing + 4),
            AppTextInput(
              controller: emailController,
              hint: 'usuario@correo.com',
              icon: Icons.email_outlined,
              obscure: false,
            ),
            const SizedBox(height: AppStyles.mobileInputSpacing),
            AppTextInput(
              controller: passwordController,
              hint: '••••••••',
              icon: Icons.lock_outline,
              obscure: obscure,
              suffixIcon: IconButton(
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  color: AppStyles.hintColor,
                ),
                onPressed: onToggleObscure,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: AppStyles.mobileForgotTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppStyles.mobileButtonVerticalPadding,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyles.mobileSmallButtonRadius),
                  ),
                ),
                onPressed: loading ? null : onLogin,
                child: loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        'Sign in',
                        style: AppStyles.mobileSignInTextStyle,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
