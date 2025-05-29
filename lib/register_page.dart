import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final ValueNotifier<List<Map<String, String>>> users;

  RegisterPage({required this.users});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passController.text;
      if (widget.users.value.any((user) => user['email'] == email)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User already exists!')));
        return;
      }
      widget.users.value = [
        ...widget.users.value,
        {'email': email, 'password': password}
      ];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful!')));
      Navigator.pushReplacementNamed(context, '/');
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
                    Text("Register", style: TextStyle(fontSize: 21, color: Theme.of(context).colorScheme.primary)),
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
                      onPressed: _register,
                      child: Text("Register"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                      child: Text("Already have an account? Login"),
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
}