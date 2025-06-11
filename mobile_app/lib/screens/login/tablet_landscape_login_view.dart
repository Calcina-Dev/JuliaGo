import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/login_card.dart';
import '../../utils/login_helper.dart';

class TabletLandscapeLoginView extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const TabletLandscapeLoginView({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<TabletLandscapeLoginView> createState() => _TabletLandscapeLoginViewState();
}

class _TabletLandscapeLoginViewState extends State<TabletLandscapeLoginView> {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth * 0.85;
          final maxHeight = constraints.maxHeight * 0.85;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: LoginCard(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                obscure: _obscure,
                                loading: _loading,
                                onToggleObscure: () => setState(() => _obscure = !_obscure),
                                onLogin: _handleLogin,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          const Expanded(
                            flex: 5,
                            child: AppLogo(width: 500, height: 500),
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
