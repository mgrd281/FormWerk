import 'package:flutter_test/flutter_test.dart';
import 'package:gewichtskompass/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GewichtsKompassApp());
    await tester.pump();
    expect(find.byType(GewichtsKompassApp), findsOneWidget);
  });
}