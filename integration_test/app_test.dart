import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dimovie_final_expert_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("dimovie app", (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("movie page")), findsOneWidget);

    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.tv));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("tvseries page")), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
