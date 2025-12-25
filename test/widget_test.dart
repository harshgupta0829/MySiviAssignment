import 'package:flutter_test/flutter_test.dart';
import 'package:mysiviai/main.dart'; // Ensure package name is correct

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MiniChatApp());

    // Verify that our title is present.
    expect(find.text('Mini Chat'), findsOneWidget);
  });
}
