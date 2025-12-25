import 'package:flutter/material.dart';
import '../../domain/chat_session_model.dart';
import '../../../users/domain/user_model.dart';

class ChatHistoryProvider extends ChangeNotifier {
  final List<ChatSession> _sessions = [
    ChatSession(
      id: '1',
      user: const User(id: '1', name: 'Alice Johnson'),
      lastMessage: "See you tomorrow!",
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
    ),
    ChatSession(
      id: '2',
      user: const User(id: '2', name: 'Bob Smith'),
      lastMessage: "Thanks for the help",
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
    ),
    ChatSession(
      id: '3',
      user: const User(id: '3', name: 'Carol Williams'),
      lastMessage: "Let's catch up soon",
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
    ),
  ];

  List<ChatSession> get sessions => List.unmodifiable(_sessions);
}
