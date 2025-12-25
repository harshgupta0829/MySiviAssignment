import 'package:equatable/equatable.dart';
import '../../users/domain/user_model.dart';

class ChatSession extends Equatable {
  final String id;
  final User user;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatSession({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    lastMessage,
    lastMessageTime,
    unreadCount,
  ];
}
