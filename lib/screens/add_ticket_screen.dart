import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/customer_dashboard_screen.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:task_app/services/ticket_service.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class AddTicketScreen extends StatefulWidget {
  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<File> _attachments = [];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _attachments.addAll(result.paths.map((path) => File(path!)).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final ticketService = Provider.of<TicketService>(context);
    final user = authService.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Ticket'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Attach Files'),
              ),
              SizedBox(height: 8),
              if (_attachments.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Attachments:'),
                    ..._attachments
                        .map((file) => Text(path.basename(file.path))),
                  ],
                ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final documentDirectory =
                        await getApplicationDocumentsDirectory();
                    final attachments =
                        await Future.wait(_attachments.map((file) async {
                      final newPath =
                          '${documentDirectory.path}/${path.basename(file.path)}';
                      await file.copy(newPath);
                      return newPath;
                    }));

                    // Generate a unique ticket ID
                    final timestamp = DateTime.now().millisecondsSinceEpoch;
                    final random = Random().nextInt(10000);
                    final ticketId = 'TKT-$timestamp-$random';

                    final newTicket = Ticket(
                      id: ticketId,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      customerId: user.id,
                      status: TicketStatus.active,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      notes: [],
                      attachments: attachments,
                    );
                    ticketService.addTicket(newTicket);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => CustomerDashboardScreen(
                          tickets: ticketService.getTicketsForUser(user),
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit Ticket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
