import 'package:flutter_test/flutter_test.dart';

// Importa tu main.dart donde defines CrimeOutApp
import 'package:frontend/main.dart';

void main() {
  testWidgets('Smoke test: carga CrimeOutApp y muestra texto de login',
      (WidgetTester tester) async {
    // Monta tu aplicación
    await tester.pumpWidget(const CrimeOutApp());

    // Dado que en tu LoginScreen pones 'Inicio Sesión', lo buscamos
    expect(find.text('Inicio Sesión'), findsOneWidget);

    // Y comprobamos que el botón 'Inicia Sesión' está presente
    expect(find.text('Inicia Sesión'), findsOneWidget);
  });
}
