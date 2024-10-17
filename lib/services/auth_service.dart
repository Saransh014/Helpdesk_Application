import 'package:flutter/foundation.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/services/ticket_service.dart';

class AuthService with ChangeNotifier {
  static List<User> _users = [];
  static User? _currentUser;

  User? get currentUser => _currentUser;
  List<User> get users => _users;

  Future<bool> register(String name, String email, String password) async {
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      role: UserRole.customer,
    );
    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  Future<bool> loginCustomer(String email, String password) async {
    final user = _users.firstWhere(
      (u) => u.email == email && u.role == UserRole.customer,
      orElse: () => User(id: '', name: '', email: '', role: UserRole.customer),
    );
    if (user.id.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> loginAdmin(String email, String password) async {
    final user = _users.firstWhere(
      (u) => u.email == email && u.role == UserRole.admin,
      orElse: () => User(id: '', name: '', email: '', role: UserRole.admin),
    );
    if (user.id.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> _login(String email, String password, UserRole role) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = _users.firstWhere(
        (user) => user.email == email && user.role == role,
        orElse: () => User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'User',
          email: email,
          role: role,
        ),
      );
      if (_currentUser!.id ==
          DateTime.now().millisecondsSinceEpoch.toString()) {
        _users.add(_currentUser!);
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void updateUser(User user) {
    int index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      notifyListeners();
    }
  }

  void deleteUser(String userId) {
    _users.removeWhere((u) => u.id == userId);
    notifyListeners();
  }

  List<Ticket> getTicketsForCurrentUser(TicketService ticketService) {
    if (_currentUser != null) {
      return ticketService.getTicketsForUser(_currentUser!);
    }
    return [];
  }

  Future<bool> registerAdmin(String name, String email, String password) async {
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      role: UserRole.admin,
    );
    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  Future<bool> registerSupportAgent(
      String name, String email, String password) async {
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      role: UserRole.supportAgent,
    );
    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  Future<bool> loginSupportAgent(String email, String password) async {
    final user = _users.firstWhere(
      (u) => u.email == email && u.role == UserRole.supportAgent,
      orElse: () =>
          User(id: '', name: '', email: '', role: UserRole.supportAgent),
    );
    if (user.id.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }
}
