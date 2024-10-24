import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intel_eye/views/screens/login_page.dart'; // Import LoginPage
import 'package:intel_eye/views/screens/home_screen.dart'; // Import HomeScreen

void main() {
  // Test for valid credentials
  testWidgets('LoginPage accepts valid credentials', (WidgetTester tester) async {
    // Build the LoginPage and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verify that the LoginPage is displayed.
    expect(find.text("Sign in"), findsOneWidget);

    // Enter valid username and password
    await tester.enterText(find.byType(TextField).first, 'samajhai');
    await tester.enterText(find.byType(TextField).at(1), '12345678');

    // Tap the login button and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for navigation

    // Check if we navigated to the HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  // Test for invalid credentials
  testWidgets('LoginPage shows error on invalid credentials', (WidgetTester tester) async {
    // Build the LoginPage and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Enter invalid username and password
    await tester.enterText(find.byType(TextField).first, 'wrongUser');
    await tester.enterText(find.byType(TextField).at(1), 'wrongPass');

    // Tap the login button and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Wait for the UI to update

    // Verify that the error message is displayed
    expect(find.text("Invalid credentials. Try again."), findsOneWidget);
  });
}
