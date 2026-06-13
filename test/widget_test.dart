// Smoke + responsive layout tests for the portfolio app.
//
// A RenderFlex overflow throws during layout, so pumping the full app at each
// breakpoint is itself the assertion that the layout fits.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uvesh_portfolio/data/portfolio_data.dart';
import 'package:uvesh_portfolio/main.dart';

/// Pumps the app at a fixed logical window size.
Future<void> pumpAt(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const PortfolioApp());
  await tester.pump();
}

const _mobile = Size(360, 800);
const _tablet = Size(800, 1024);
const _desktop = Size(1440, 1024);

void main() {
  testWidgets('renders hero, content and section labels', (tester) async {
    await pumpAt(tester, _desktop);

    expect(find.text(PortfolioData.name), findsWidgets);
    expect(find.text(PortfolioData.tagline), findsOneWidget);
    expect(find.text('EXPERIENCE'), findsOneWidget);
    expect(find.text('PROJECTS'), findsOneWidget);
    expect(find.text('SKILLS'), findsOneWidget);
  });

  testWidgets('lays out without overflow at mobile width', (tester) async {
    await pumpAt(tester, _mobile);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lays out without overflow at tablet width', (tester) async {
    await pumpAt(tester, _tablet);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lays out without overflow at desktop width', (tester) async {
    await pumpAt(tester, _desktop);
    expect(tester.takeException(), isNull);
  });

  testWidgets('theme toggle flips brightness', (tester) async {
    await pumpAt(tester, _desktop);

    final BuildContext context = tester.element(find.byType(Scaffold).first);
    expect(Theme.of(context).brightness, Brightness.light);

    await tester.tap(find.byTooltip('Switch to dark theme').first);
    await tester.pumpAndSettle();

    final BuildContext afterContext = tester.element(
      find.byType(Scaffold).first,
    );
    expect(Theme.of(afterContext).brightness, Brightness.dark);
  });
}
