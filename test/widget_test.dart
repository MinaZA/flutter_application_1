import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // Change "flutter_application_1" si nécessaire selon le nom de ton projet

void main() {
  testWidgets('Vérifie l\'initialisation du compteur de cookies à 0', (WidgetTester tester) async {
    // On démarre l'application
    await tester.pumpWidget(const CookieClickerApp());

    // On vérifie que le texte contenant le nombre de cookies affiche bien 0
    expect(find.text('Cookies: 0'), findsOneWidget);
    expect(find.text('Cookies: 1'), findsNothing);
  });

  testWidgets('Vérifie l\'incrémentation du compteur de cookies lors du clic sur l\'image', (WidgetTester tester) async {
    // On démarre l'application
    await tester.pumpWidget(const CookieClickerApp());

    // On clique sur l'image du cookie
    final Finder cookieImage = find.byType(GestureDetector);
    await tester.tap(cookieImage);

    // On redessine l'interface après le clic
    await tester.pump();

    // On vérifie que le texte est mis à jour et affiche 1 cookie
    expect(find.text('Cookies: 1'), findsOneWidget);
    expect(find.text('Cookies: 0'), findsNothing);
  });
}
