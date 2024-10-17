import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/customer_dashboard_screen.dart';
import 'package:task_app/screens/dashboard_screen.dart';
import 'package:task_app/screens/registration_screen.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';
import 'package:task_app/screens/registration_screen.dart';

class CustomerLoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Customer Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

                if (email.isNotEmpty && password.isNotEmpty) {
                  final success =
                      await authService.loginCustomer(email, password);
                  if (success) {
                    final ticketService =
                        Provider.of<TicketService>(context, listen: false);
                    final userTickets =
                        authService.getTicketsForCurrentUser(ticketService);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) =>
                              CustomerDashboardScreen(tickets: userTickets)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Login failed. Please try again.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => CustomerRegistrationScreen()),
                );
              },
              child: Text('New customer? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
