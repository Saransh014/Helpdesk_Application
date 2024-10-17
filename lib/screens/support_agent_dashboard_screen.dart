import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';
import 'package:task_app/screens/ticket_list_screen.dart';

class SupportAgentDashboardScreen extends StatelessWidget {
  final List<Ticket> tickets;

  SupportAgentDashboardScreen({required this.tickets});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final ticketService = Provider.of<TicketService>(context);

    final totalTickets = ticketService.tickets.length;
    final activeTickets = ticketService.tickets
        .where((ticket) => ticket.status == TicketStatus.active)
        .length;
    final pendingTickets = ticketService.tickets
        .where((ticket) => ticket.status == TicketStatus.pending)
        .length;
    final closedTickets = ticketService.tickets
        .where((ticket) => ticket.status == TicketStatus.closed)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Support Agent Dashboard'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 16),
            _buildStatCard('Total Tickets', totalTickets),
            _buildStatCard('Active Tickets', activeTickets),
            _buildStatCard('Pending Tickets', pendingTickets),
            _buildStatCard('Closed Tickets', closedTickets),
            SizedBox(height: 32),
            Text('Quick Actions',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TicketListScreen(tickets: ticketService.tickets),
                  ),
                );
              },
              child: Text('View All Tickets'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(value.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
