import 'package:flutter_test/flutter_test.dart';

import 'package:synk/app/app.dart';

void main() {
  testWidgets('Synk shell renders main tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const SynkApp());

    expect(find.text('Standup'), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Feedback'), findsOneWidget);
  });
}
