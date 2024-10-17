import 'package:flutter/foundation.dart';
import 'package:task_app/models/user.dart';

class TicketService with ChangeNotifier {
  static List<Ticket> _tickets = [];

  List<Ticket> get tickets => _tickets;

  void addTicket(Ticket ticket) {
    _tickets.add(ticket);
    notifyListeners();
  }

  void updateTicket(Ticket ticket) {
    int index = _tickets.indexWhere((t) => t.id == ticket.id);
    if (index != -1) {
      _tickets[index] = ticket;
      notifyListeners();
    }
  }

  List<Ticket> getTicketsForUser(User user) {
    if (user.role == UserRole.customer) {
      return _tickets.where((ticket) => ticket.customerId == user.id).toList();
    }
    return _tickets;
  }

  void addNoteToTicket(String ticketId, Note note) {
    int index = _tickets.indexWhere((t) => t.id == ticketId);
    if (index != -1) {
      _tickets[index].notes.add(note);
      notifyListeners();
    }
  }

  void updateTicketStatus(String ticketId, TicketStatus newStatus) {
    int index = _tickets.indexWhere((t) => t.id == ticketId);
    if (index != -1) {
      _tickets[index] = _tickets[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }
}
