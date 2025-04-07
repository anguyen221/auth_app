// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'authentication_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthenticationScreen()),
    );
  }

  void _changePassword(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(hintText: "New Password"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String? result = await _authService.changePassword(controller.text.trim());
              Navigator.pop(context);
              if (result != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              }
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Logged in as: ${user?.email ?? "Unknown"}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _changePassword(context),
              child: const Text("Change Password"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
