import 'package:app/main.dart';
import 'package:app/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyApp()', (WidgetTester tester) async {
    /// Construye el widget MyApp y lo agrega al arbol de widgets
    await tester.pumpWidget(const MyApp());

    /// Verifica que la aplicación llame a LoginScreen una vez
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
