import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/admin_dashboard_screen.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: Text(_isRegistering ? 'Admin Registration' : 'Admin Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRegistering)
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                if (_isRegistering) {
                  final name = _nameController.text;
                  if (name.isNotEmpty &&
                      email.isNotEmpty &&
                      password.isNotEmpty) {
                    final success =
                        await authService.registerAdmin(name, email, password);
                    handleAuthResult(context, success);
                  } else {
                    showSnackBar(context, 'Please fill in all fields');
                  }
                } else {
                  if (email.isNotEmpty && password.isNotEmpty) {
                    final success =
                        await authService.loginAdmin(email, password);
                    handleAuthResult(context, success);
                  } else {
                    showSnackBar(context, 'Please fill in all fields');
                  }
                }
              },
              child: Text(_isRegistering ? 'Register' : 'Login'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _isRegistering = !_isRegistering;
                });
              },
              child: Text(_isRegistering
                  ? 'Already have an account? Login'
                  : 'New admin? Register here'),
            ),
          ],
        ),
      ),
    );
  }

  void handleAuthResult(BuildContext context, bool success) {
    if (success) {
      final authService = Provider.of<AuthService>(context, listen: false);
      final ticketService = Provider.of<TicketService>(context, listen: false);
      final userTickets = authService.getTicketsForCurrentUser(ticketService);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AdminDashboardScreen(tickets: userTickets),
        ),
      );
    } else {
      showSnackBar(context,
          '${_isRegistering ? 'Registration' : 'Login'} failed. Please try again.');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
