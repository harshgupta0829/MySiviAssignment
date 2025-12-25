import 'package:flutter_test/flutter_test.dart';
import 'package:mysiviai/features/users/presentation/providers/user_provider.dart';

void main() {
  group('UserProvider', () {
    late UserProvider userProvider;

    setUp(() {
      userProvider = UserProvider();
    });

    test('initial state has default users', () {
      expect(userProvider.users.length, 5);
    });

    test('addUser adds a user', () {
      final initialLength = userProvider.users.length;
      userProvider.addUser('Alice');
      expect(userProvider.users.length, initialLength + 1);
      expect(userProvider.users.first.name, 'Alice');
    });

    test('addUser generates correct initials', () {
      userProvider.addUser('Bob Smith');
      expect(userProvider.users.first.initials, 'B');
    });
  });
}
