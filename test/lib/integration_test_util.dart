import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> enterText(WidgetTester tester, String key, String text) async {
  await tester.enterText(find.byKey(Key(key)), text);
  await tester.testTextInput.receiveAction(TextInputAction.done);
}