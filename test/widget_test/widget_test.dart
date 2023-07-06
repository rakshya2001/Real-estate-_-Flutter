import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sparrow/screens/searchScreen.dart';
import 'package:sparrow/screens/user_list.dart';
import 'package:sparrow/screens/wearOS/Dashboard_wearOS.dart';
import 'package:sparrow/screens/wearOS/Login_wearOS.dart';

void main() {
  
  testWidgets("button testing in Login page", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: WOS_LoginScreen(),
    ));
    // find text
    Finder btnLogin = find.byKey(const ValueKey("login"));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(btnLogin, findsOneWidget);
  });

  // find widget in search screen
  testWidgets("testing the search input field", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    Finder searchInput = find.byKey(const Key("search_text_field"));
    // dont ignore offset widget
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(searchInput, findsOneWidget);
  });

  // find nothing in home screen
  testWidgets("testing no login button in homepage", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    // find elevated button
    Finder btnElevated = find.byKey(const Key("elevated_button"));
    // dont ignore offset widget
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(btnElevated, findsNothing);
  });

  // flutter toast testing
  testWidgets("testing the Dashboard Screen", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Dashboard_wearOS(),
    ));
    // find text
    // find the button
    Finder raisedBtn = find.byKey(const ValueKey("addPropertyBtn"));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(raisedBtn, findsOneWidget);
    
  });
  
  // find title
  testWidgets("testing the widgets user lists", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: UserLists(),
    ));
    Finder title = find.text("List users");
    // dont ignore offset widget
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(title, findsOneWidget);
  });


  
  
}
