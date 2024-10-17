import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/ticket_list_screen.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';

class CustomerDashboardScreen extends StatelessWidget {
  final List<Ticket> tickets;

  CustomerDashboardScreen({required this.tickets});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      // If there's no logged-in user, navigate back to the login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/');
      });
      return Container(); // Return an empty container while redirecting
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.name}!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Consumer<AuthService>(
                      builder: (context, authService, child) {
                        return TicketListScreen(tickets: tickets);
                      },
                    ),
                  ),
                );
              },
              child: Text('View My Tickets (${tickets.length})'),
            ),
          ],
        ),
      ),
    );
  }
}
