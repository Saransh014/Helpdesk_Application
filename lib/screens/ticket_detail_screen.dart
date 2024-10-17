import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  TicketDetailScreen({required this.ticket});

  Future<void> _openAttachment(BuildContext context, String attachment) async {
    try {
      final file = File(attachment);
      if (await file.exists()) {
        final result = await OpenFile.open(file.path);
        if (result.type != ResultType.done) {
          throw 'Could not open the file: ${result.message}';
        }
      } else {
        throw 'File not found: $attachment';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening attachment: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final ticketService = Provider.of<TicketService>(context);
    final user = authService.currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text('Ticket Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ticket ID: ${ticket.id}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Title: ${ticket.title}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Description: ${ticket.description}'),
            SizedBox(height: 8),
            Text('Status: ${ticket.status.toString().split('.').last}'),
            SizedBox(height: 16),
            if (ticket.attachments.isNotEmpty) ...[
              Text('Attachments:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ...ticket.attachments.map((attachment) => ListTile(
                    title: Text(path.basename(attachment)),
                    leading: Icon(attachment.toLowerCase().endsWith('.pdf')
                        ? Icons.picture_as_pdf
                        : Icons.image),
                    onTap: () => _openAttachment(context, attachment),
                  )),
              SizedBox(height: 16),
            ],
            Text('Notes:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...ticket.notes.map((note) => ListTile(
                  title: Text(note.content),
                  subtitle: Text(
                      '${note.userRole.toString().split('.').last} - ${note.createdAt}'),
                )),
            SizedBox(height: 16),
            if (user.role != UserRole.customer || ticket.customerId == user.id)
              ElevatedButton(
                onPressed: () {
                  _showAddNoteDialog(context, ticketService, ticket.id, user);
                },
                child: Text(user.role == UserRole.supportAgent
                    ? 'Reply Note'
                    : 'Add Note'),
              ),
            if (user.role != UserRole.customer)
              ElevatedButton(
                onPressed: () {
                  _showUpdateStatusDialog(context, ticketService, ticket.id);
                },
                child: Text('Update Status'),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, TicketService ticketService,
      String ticketId, User user) {
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user.role == UserRole.supportAgent
              ? 'Reply to Ticket'
              : 'Add Note to Ticket'),
          content: TextField(
            controller: noteController,
            decoration: InputDecoration(hintText: 'Enter note'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (noteController.text.isNotEmpty) {
                  final note = Note(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    content: noteController.text,
                    userId: user.id,
                    userRole: user.role,
                    createdAt: DateTime.now(),
                  );
                  ticketService.addNoteToTicket(ticketId, note);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateStatusDialog(
      BuildContext context, TicketService ticketService, String ticketId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Status'),
        content: DropdownButton<TicketStatus>(
          value: TicketStatus.active,
          items: TicketStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(status.toString().split('.').last),
            );
          }).toList(),
          onChanged: (TicketStatus? newStatus) {
            if (newStatus != null) {
              ticketService.updateTicketStatus(ticketId, newStatus);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
