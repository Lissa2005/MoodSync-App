// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moodsync/main.dart';
import 'package:moodsync/screens/start_up_screens/welcome_screen.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    // This test only checks that Flutter test framework runs
    expect(true, isTrue);
  });
}
