import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/view/page/profile.dart';

void main() {
  late Widget widgetToTest;

  setUp(() {
    widgetToTest = const ProviderScope(
      child: MaterialApp(
        home: ProfilePage(
          user: User(email: "john@example.com", name: "John Doe")
        ),
      ),
    );
  });
  testWidgets('profile page appbar contains "Profile"', (tester) async {
    await tester.pumpWidget(widgetToTest);

    final finder = find.text("Profile");
    final appBar = find.ancestor(of: finder, matching: find.byType(AppBar));

    expect(finder, findsOneWidget);
    expect(appBar, findsOneWidget);
  });

  testWidgets('profile page has "Go Back" button', (tester) async {
    await tester.pumpWidget(widgetToTest);

    final finder = find.byKey(const Key("goBackButton"));
    final buttonText = find.descendant(
      of: finder, 
      matching: find.text("Go Back"),
    );

    expect(finder, findsOneWidget);
    expect(buttonText, findsOneWidget);
  });
}