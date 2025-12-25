import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:mysiviai/features/chat/presentation/providers/chat_provider.dart';
import 'package:mysiviai/features/chat/domain/message_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('ChatProvider', () {
    late ChatProvider chatProvider;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      chatProvider = ChatProvider(dio: mockDio);
    });

    test('initial state is empty', () {
      expect(chatProvider.messages, isEmpty);
      expect(chatProvider.isLoading, false);
    });

    test('sendMessage adds a local message', () {
      chatProvider.sendMessage('Hello');
      expect(chatProvider.messages.length, 1);
      expect(chatProvider.messages.first.text, 'Hello');
      expect(chatProvider.messages.first.type, MessageType.sender);
    });
  });
}
