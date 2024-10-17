enum UserRole { customer, admin, supportAgent }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.role});
}

enum TicketStatus { active, pending, closed }

class Ticket {
  final String id;
  final String title;
  final String description;
  final String customerId;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Note> notes;
  final List<String> attachments;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.customerId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.attachments,
  });

  Ticket copyWith({
    String? id,
    String? title,
    String? description,
    String? customerId,
    TicketStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Note>? notes,
    List<String>? attachments,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      customerId: customerId ?? this.customerId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      attachments: attachments ?? this.attachments,
    );
  }
}

class Note {
  final String id;
  final String content;
  final String userId;
  final UserRole userRole;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.content,
    required this.userId,
    required this.userRole,
    required this.createdAt,
  });
}
