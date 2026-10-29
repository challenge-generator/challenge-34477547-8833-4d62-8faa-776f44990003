/// Configuración de entorno de la aplicación.
///
/// Los valores se fijan en tiempo de compilación con `--dart-define`:
///
///   flutter run                              -> usa mocks (por defecto)
///   flutter run --dart-define=USE_MOCKS=false -> usa el API real
class AppConfig {
  const AppConfig._();

  /// Si es `true`, las peticiones al API de cuentas se resuelven con los JSON de `assets/mocks`.
  /// Las transacciones siempre usan el almacenamiento local (SQLite).
  static const bool useMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: true);

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.financeapp.example.com/v1',
  );
}
