// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onToggle;
  const RegisterScreen({super.key, required this.onToggle});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String? _error;

  void _register() async {
    String? result = await _authService.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (result != null) {
      setState(() => _error = result);
    } else if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text('Register')),
            TextButton(
              onPressed: widget.onToggle,
              child: const Text('Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
