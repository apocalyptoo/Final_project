import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final ValueNotifier<List<Map<String, String>>> users;

  LoginPage({required this.users});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool validatePassword(String value) {
    final passRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passRegex.hasMatch(value);
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final pass = _passController.text;
      final found = widget.users.value.any(
          (user) => user['email'] == email && user['password'] == pass);
      if (!found) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect email or password')),
        );
        return;
      }
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 380),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.all(20),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "AppointmentBuddy",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 28),
                    Text("Login", style: TextStyle(fontSize: 21, color: Theme.of(context).colorScheme.primary)),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (val) => val != null && validateEmail(val) ? null : 'Invalid email',
                    ),
                    SizedBox(height: 14),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (val) => val != null && validatePassword(val) ? null : 'Min 6 chars, 1 letter & 1 number',
                    ),
                    SizedBox(height: 26),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text("Login"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                      child: Text("Don't have an account? Register"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}