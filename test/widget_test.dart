import 'package:flutter_test/flutter_test.dart';
import 'package:life_tracker/main.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeTrackerApp());
    expect(find.text('MTG LIFE COUNTER'), findsOneWidget);
    expect(find.text('START MATCH'), findsOneWidget);
  });
}
