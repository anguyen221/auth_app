import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showLogin = true;

  void toggleScreen() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen(onToggle: toggleScreen)
        : RegisterScreen(onToggle: toggleScreen);
  }
}
