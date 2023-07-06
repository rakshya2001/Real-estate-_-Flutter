import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sparrow/screens/change_password.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("testing delete the widgets", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ChangePassword(),
    ));

    // find the text field by its key
    Finder oldPasswordInput = find.byKey(const ValueKey("oldPassword"));
    await tester.enterText(oldPasswordInput, "abc");
    Finder newPasswordInput = find.byKey(const ValueKey("newPassword"));
    await tester.enterText(newPasswordInput, "abc");
    Finder confirmPasswordInput = find.byKey(const ValueKey("confirmPassword"));
    await tester.enterText(confirmPasswordInput, "abc");

    Finder changePasswordBtn = find.byKey(const ValueKey("changePasswordBtn"));
    await tester.tap(changePasswordBtn);
    await tester.pumpAndSettle();

    // find by column
    Finder column = find.byType(Column);
    expect(column, findsOneWidget);
  });
}
