import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/home/body.dart';

void main() {
  late Widget widgetToTest;
  
  setUp(() {
    widgetToTest = const MaterialApp(
      home: HomeBody(user: User(email: "john@example.com", name: "John Doe"),),
    );
  });

  testWidgets('home body has "WELCOME TO HOME" text', (tester) async {
    await tester.pumpWidget(widgetToTest);

    final finder = find.text("WELCOME TO HOME");

    expect(finder, findsOneWidget);
  });

  testWidgets('home body has "View Profile" button', (tester) async {
    await tester.pumpWidget(widgetToTest);

    final finder = find.byKey(const Key("viewProfileButton"));
    final widget = tester.firstWidget<ElevatedTextButton>(finder);

    expect(finder, findsOneWidget);
    expect(widget.text, equals("View Profile"));
  });
}