import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/login_card.dart';
import '../../utils/login_helper.dart';

class MobileLoginView extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const MobileLoginView({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<MobileLoginView> createState() => _MobileLoginViewState();
}

class _MobileLoginViewState extends State<MobileLoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _obscure = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _emailController = widget.emailController;
    _passwordController = widget.passwordController;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.mobilePagePadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.95,
              maxHeight: size.height * 0.95,
            ),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: AppStyles.mobileCardBorderRadius,
              ),
              color: AppStyles.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(AppStyles.mobileCardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLogo(height: 220),
                    //const SizedBox(height: AppStyles.mobileSectionSpacing),
                    LoginCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      obscure: _obscure,
                      onToggleObscure: () => setState(() => _obscure = !_obscure),
                      loading: _loading,
                      onLogin: _handleLogin,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
  final email = _emailController.text;
  final password = _passwordController.text;

    handleLogin(
      context: context,
      email: email,
      password: password,
      onStart: () => setState(() => _loading = true),
      onFinish: () => setState(() => _loading = false),
      mounted: () => mounted,
    );

  }

}
