// Smoke + responsive + navigation tests for the multi-page portfolio.
//
// A RenderFlex overflow throws during layout, so pumping the app at each
// breakpoint is itself the assertion that the layout fits.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uvesh_portfolio/data/portfolio_data.dart';
import 'package:uvesh_portfolio/main.dart';

Future<void> pumpAt(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const PortfolioApp());
  await tester.pumpAndSettle();
}

const _mobile = Size(360, 800);
const _tablet = Size(800, 1024);
const _desktop = Size(1440, 1024);

void main() {
  testWidgets('home shows the hero and a nav', (tester) async {
    await pumpAt(tester, _desktop);

    expect(find.text(PortfolioData.name), findsWidgets);
    expect(find.text(PortfolioData.tagline), findsOneWidget);
    // Nav links are present on desktop.
    expect(find.text('Projects'), findsWidgets);
    expect(find.text('Blog'), findsWidgets);
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

  testWidgets('navigates from home to the projects page', (tester) async {
    await pumpAt(tester, _desktop);

    // Tap the Projects nav link and confirm project content renders.
    await tester.tap(find.text('Projects').first);
    await tester.pumpAndSettle();

    expect(find.text('SyncIt Platform'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('books page renders (empty state until populated)', (
    tester,
  ) async {
    await pumpAt(tester, _desktop);

    await tester.tap(find.text('Books').first);
    await tester.pumpAndSettle();

    // The page title renders, and there's no overflow whether the reading
    // list has entries or shows the empty state.
    expect(find.text('Books'), findsWidgets);
    if (PortfolioData.books.isEmpty) {
      expect(find.textContaining('reading list'), findsOneWidget);
    } else {
      expect(
        find.textContaining(PortfolioData.books.first.title),
        findsWidgets,
      );
    }
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
