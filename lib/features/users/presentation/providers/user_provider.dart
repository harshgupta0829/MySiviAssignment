import 'package:flutter/material.dart';
import '../../domain/user_model.dart';

class UserProvider extends ChangeNotifier {
  final List<User> _users = [
    const User(id: '1', name: 'Alice Johnson'),
    const User(id: '2', name: 'Bob Smith'),
    const User(id: '3', name: 'Carol Williams'),
    const User(id: '4', name: 'David Brown'),
    const User(id: '5', name: 'Emma Davis'),
  ];

  List<User> get users => List.unmodifiable(_users);

  void addUser(String name) {
    if (name.trim().isEmpty) return;
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    _users.insert(0, newUser);
    notifyListeners();
  }
}
