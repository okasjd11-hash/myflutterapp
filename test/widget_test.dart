import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testflutter/main.dart' as app;

void main() {
  testWidgets('main opens the home screen', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(app.HomeScreen), findsOneWidget);
    expect(find.text('My-app'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  group('HomeScreen', () {
    testWidgets('displays My-app as the app bar title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: app.HomeScreen()));

      expect(
        find.descendant(of: find.byType(AppBar), matching: find.text('My-app')),
        findsOneWidget,
      );
    });

    for (final brightness in Brightness.values) {
      testWidgets('keeps a light app bar in the ${brightness.name} theme', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              brightness: brightness,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
            ),
            home: const app.HomeScreen(),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.backgroundColor, Colors.white70);
      });
    }

    testWidgets('has an empty body without the previous counter controls', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: app.HomeScreen()));

      expect(tester.widget<Scaffold>(find.byType(Scaffold)).body, isNull);
      expect(
        find.text('You have pushed the button this many times:'),
        findsNothing,
      );
      expect(find.text('0'), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(find.byIcon(Icons.add), findsNothing);
      expect(find.byTooltip('Increment'), findsNothing);
    });

    testWidgets('keeps the title visible on a narrow screen with large text', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(2),
            ),
            child: child!,
          ),
          home: const app.HomeScreen(),
        ),
      );

      final title = find.text('My-app');
      expect(title, findsOneWidget);
      final titleBounds = tester.getRect(title);
      final appBarBounds = tester.getRect(find.byType(AppBar));
      expect(titleBounds.left, greaterThanOrEqualTo(appBarBounds.left));
      expect(titleBounds.right, lessThanOrEqualTo(appBarBounds.right));
      expect(titleBounds.top, greaterThanOrEqualTo(appBarBounds.top));
      expect(titleBounds.bottom, lessThanOrEqualTo(appBarBounds.bottom));
      expect(tester.takeException(), isNull);
    });
  });
}
