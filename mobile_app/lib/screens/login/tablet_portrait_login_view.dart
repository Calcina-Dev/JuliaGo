import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/login_card.dart';
import '../../utils/login_helper.dart';

class TabletPortraitLoginView extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const TabletPortraitLoginView({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<TabletPortraitLoginView> createState() => _TabletPortraitLoginViewState();
}

class _TabletPortraitLoginViewState extends State<TabletPortraitLoginView> {
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppStyles.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxHeight > constraints.maxWidth;

          final maxWidth = isPortrait
              ? constraints.maxWidth * 0.75
              : constraints.maxWidth * 0.6;
          final maxHeight = isPortrait
              ? constraints.maxHeight * 0.95
              : constraints.maxHeight * 0.85;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                  ),
                  child: Card(
                    color: AppStyles.cardColor,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyles.borderRadius24,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppLogo(
                            width: isPortrait ? 480 : 400,
                            height: isPortrait ? 320 : 280,
                          ),
                          const SizedBox(height: 40),
                          LoginCard(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            obscure: _obscure,
                            loading: _loading,
                            onToggleObscure: () => setState(() => _obscure = !_obscure),
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
        },
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
