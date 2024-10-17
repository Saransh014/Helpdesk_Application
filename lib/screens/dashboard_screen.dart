import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/ticket_list_screen.dart';
import 'package:task_app/screens/user_management_screen.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';
import 'package:task_app/screens/admin_dashboard_screen.dart';
import 'package:task_app/screens/customer_dashboard_screen.dart';
import 'package:task_app/screens/role_selection_screen.dart';

class DashboardScreen extends StatelessWidget {
  final List<Ticket> tickets;

  DashboardScreen({required this.tickets});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final ticketService = Provider.of<TicketService>(context);

    if (authService.currentUser == null) {
      return RoleSelectionScreen();
    }

    final user = authService.currentUser!;

    if (user.role == UserRole.admin) {
      return AdminDashboardScreen(tickets: tickets);
    } else if (user.role == UserRole.customer) {
      return CustomerDashboardScreen(tickets: tickets);
    } else {
      // Handle unexpected role
      return RoleSelectionScreen();
    }
  }
}
