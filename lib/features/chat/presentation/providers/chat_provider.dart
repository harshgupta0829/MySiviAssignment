import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../domain/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get error => _error;

  final Dio _dio;

  ChatProvider({Dio? dio}) : _dio = dio ?? Dio();

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      type: MessageType.sender,
      timestamp: DateTime.now(),
    );

    _messages.insert(0, newMessage);
    notifyListeners();

    fetchReceiverMessage();
  }

  Future<void> fetchReceiverMessage() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final randomSkip = DateTime.now().millisecond % 100;
      final response = await _dio.get(
        'https://dummyjson.com/comments',
        queryParameters: {'limit': 1, 'skip': randomSkip},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final comments = data['comments'] as List;
        if (comments.isNotEmpty) {
          final commentText = comments[0]['body'];

          final reply = Message(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: commentText,
            type: MessageType.receiver,
            timestamp: DateTime.now(),
          );

          _messages.insert(0, reply);
        }
      }
    } catch (e) {
      _error = "Failed to fetch response";
      _error = "Failed to fetch response";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
