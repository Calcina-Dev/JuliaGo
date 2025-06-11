import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'mobile_login_view.dart';
import 'tablet_portrait_login_view.dart';
import 'tablet_landscape_login_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenType = Responsive.getScreenType(context);

    switch (screenType) {
      case ScreenType.tabletPortrait:
        return TabletPortraitLoginView(
          emailController: emailController,
          passwordController: passwordController,
        );
      case ScreenType.tabletLandscape:
        return TabletLandscapeLoginView(
          emailController: emailController,
          passwordController: passwordController,
        );
      case ScreenType.mobilePortrait:
      default:
       return MobileLoginView(
          emailController: emailController,
          passwordController: passwordController,
        );

    }
  }
}
