// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_1/main.dart';

void main() {
  testWidgets('Bidding increments by 50', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // initial bid shown
    expect(find.byKey(const Key('bidText')), findsOneWidget);
    expect(find.text('Current Maximum Bid: \$0'), findsOneWidget);

    // tap increase button
    await tester.tap(find.byKey(const Key('increaseButton')));
    await tester.pump(); // rebuild after setState

    // verify updated bid
    expect(find.text('Current Maximum Bid: \$50'), findsOneWidget);
  });
}
