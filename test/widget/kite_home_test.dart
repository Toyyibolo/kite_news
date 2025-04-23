import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kite_news/presentation/screens/home.dart';
import 'package:kite_news/presentation/screens/settings_page.dart';

void main() {
  testWidgets('KiteHome renders correctly and shows summary text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: KiteHome()),
      ),
    );

    // Wait for animations/builds
    await tester.pumpAndSettle();

    // Check app bar content
    expect(find.text('Kite News'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // Check summary section
    expect(find.text('Summary'), findsOneWidget);

    // Check explore categories section
    expect(find.text('Explore Categories'), findsOneWidget);
  });

  testWidgets('Tapping settings icon navigates to SettingsPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: KiteHome()),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    
    expect(find.byType(SettingsPage), findsWidgets); 
  });
  
  testWidgets('Toggles category collapse', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: KiteHome()),
      ),
    );

    await tester.pumpAndSettle();

    final toggleButton = find.byIcon(Icons.keyboard_arrow_up);
    expect(toggleButton, findsOneWidget);

    await tester.tap(toggleButton);
    await tester.pumpAndSettle();

    // Should now show collapsed icon (arrow down)
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });
}
