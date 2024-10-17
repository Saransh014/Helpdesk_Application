import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/ticket_detail_screen.dart';
import 'package:task_app/screens/add_ticket_screen.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';

class TicketListScreen extends StatefulWidget {
  final List<Ticket> tickets;

  TicketListScreen({required this.tickets});

  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  TicketStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/');
      });
      return Container();
    }

    List<Ticket> filteredTickets = _selectedStatus == null
        ? widget.tickets
        : widget.tickets
            .where((ticket) => ticket.status == _selectedStatus)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          if (user.role == UserRole.customer)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AddTicketScreen()),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TicketStatus>(
                  value: _selectedStatus,
                  hint: Text('Filter by status'),
                  isExpanded: true,
                  onChanged: (TicketStatus? newValue) {
                    setState(() {
                      _selectedStatus = newValue;
                    });
                  },
                  items: [
                    DropdownMenuItem<TicketStatus>(
                      value: null,
                      child: Text('All Tickets'),
                    ),
                    ...TicketStatus.values.map((TicketStatus status) {
                      return DropdownMenuItem<TicketStatus>(
                        value: status,
                        child: Text(status.toString().split('.').last),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = filteredTickets[index];
                return _buildTicketCard(context, ticket);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, Ticket ticket) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title:
            Text(ticket.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Status: ${ticket.status.toString().split('.').last}'),
            Text('Customer ID: ${ticket.customerId}'),
            Text('Updated: ${ticket.updatedAt.toString().split(' ')[0]}'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TicketDetailScreen(ticket: ticket),
            ),
          );
        },
      ),
    );
  }
}
