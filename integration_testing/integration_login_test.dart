import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sparrow/screens/home_screen/home_screen.dart';
import 'package:sparrow/screens/loginScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("testing the widgets", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/home': (context) =>  const HomeScreen(),
      },
      home: const LoginScreen(),
    ));
    Finder phoneInput = find.byKey(const ValueKey("phone"));
    await tester.enterText(phoneInput, "999");
    Finder passwordInput = find.byKey(const ValueKey("password"));
    await tester.enterText(passwordInput, "abc");
    Finder btnLogin = find.byKey(const ValueKey("loginBtn"));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
