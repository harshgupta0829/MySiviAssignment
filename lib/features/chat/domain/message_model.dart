import 'package:equatable/equatable.dart';

enum MessageType { sender, receiver }

class Message extends Equatable {
  final String id;
  final String text;
  final MessageType type;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, text, type, timestamp];
}
