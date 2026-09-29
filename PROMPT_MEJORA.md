# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `test/unit/calculate_balance_usecase_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- `test/unit/process_transaction_usecase_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- `test/unit/transaction_model_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- `test/unit/balance_calculation_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- `test/bdd/transaction_feature.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- `test/bdd/account_feature.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- `test/integration/finance_flow_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `lib/domain/usecases/process_transaction_usecase.dart` — `TransactionRepository.getLatestBalance`: Se invoca `getLatestBalance` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/domain/usecases/process_transaction_usecase.dart` — `TransactionRepository.saveTransaction`: Se invoca `saveTransaction` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/domain/usecases/process_transaction_usecase.dart` — `TransactionRepository.updateBalance`: Se invoca `updateBalance` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/viewmodels/finance_viewmodel.dart` — `AccountRepository.getAccounts`: Se invoca `getAccounts` sobre `AccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/calculate_balance_usecase_test.dart` — `MockAccountRepository.getAccount`: Se invoca `getAccount` sobre `MockAccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/calculate_balance_usecase_test.dart` — `MockTransactionRepository.getTransactionsByAccount`: Se invoca `getTransactionsByAccount` sobre `MockTransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/process_transaction_usecase_test.dart` — `MockAccountRepository.getAccount`: Se invoca `getAccount` sobre `MockAccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/process_transaction_usecase_test.dart` — `MockTransactionRepository.saveTransaction`: Se invoca `saveTransaction` sobre `MockTransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/process_transaction_usecase_test.dart` — `MockAccountRepository.updateAccount`: Se invoca `updateAccount` sobre `MockAccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/process_transaction_usecase_test.dart` — `MockTransactionRepository.updateTransaction`: Se invoca `updateTransaction` sobre `MockTransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
flutter pub get && flutter analyze
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Advanced

### Brecha de conocimiento
Implementa pruebas unitarias en lenguaje nativo, usa pruebas funcionales automatizadas, explica BDD, interpreta perfilamiento (profiler) de apps, comprende la importancia de servicios virtualizados

### Misión / candidato
Candidato con experiencia avanzada en desarrollo móvil con Flutter, trabajando en equipo distribuido

### Reto
- Tema: Técnicas de pruebas unitarias y fundamentos de perfilamiento de aplicaciones
- Seniority: advanced-l2
- Tipo: mixed
- Título: Optimización y aseguramiento de calidad en aplicación móvil
- Tiempo estimado: 20 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Implementación de pruebas unitarias — objetivo: Asegurar que las funciones críticas de la aplicación se comportan como se espera en condiciones normales y de error. — entregable (NO resolver): Conjunto de pruebas unitarias que cubren las funciones críticas de la aplicación.
- Fase 2: Aplicación de BDD y pruebas funcionales automatizadas — objetivo: Garantizar que la aplicación cumple con los requisitos del negocio a través de pruebas funcionales automatizadas. — entregable (NO resolver): Conjunto de pruebas funcionales automatizadas basadas en escenarios de BDD.
- Fase 3: Análisis de perfilamiento y optimización — objetivo: Identificar y resolver cuellos de botella en la aplicación para mejorar su rendimiento. — entregable (NO resolver): Informe de perfilamiento con propuestas de optimización implementadas.
- Fase 4: Integración y verificación final — objetivo: Asegurar que todas las fases anteriores se han completado correctamente y que la aplicación cumple con los requisitos de rendimiento y calidad. — entregable (NO resolver): Documento final que resume los hallazgos y recomendaciones de todas las fases.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pubspec.yaml ===
name: finance_app
description: Aplicación móvil de finanzas personales con arquitectura limpia y pruebas unitarias.
version: 1.0.0+1

environment:
  sdk: ">=3.6.0 <4.0.0"
  flutter: ">=3.27.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  provider: ^6.1.2
  sqflite: ^2.4.1
  http: ^1.2.2
  equatable: ^2.0.7
  get_it: ^8.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.13
  bloc_test: ^9.1.7

flutter:
  uses-material-design: true

// === ARCHIVO: lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'domain/repositories/transaction_repository.dart';
import 'domain/repositories/account_repository.dart';
import 'domain/usecases/calculate_balance_usecase.dart';
import 'domain/usecases/process_transaction_usecase.dart';
import 'domain/usecases/notify_transaction_usecase.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'data/repositories/account_repository_impl.dart';
import 'data/datasources/local_transaction_datasource.dart';
import 'data/datasources/remote_account_datasource.dart';
import 'presentation/viewmodels/finance_viewmodel.dart';
import 'presentation/screens/home_screen.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Data sources
  getIt.registerLazySingleton<LocalTransactionDataSource>(
    () => LocalTransactionDataSourceImpl(),
  );
  getIt.registerLazySingleton<RemoteAccountDataSource>(
    () => RemoteAccountDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<LocalTransactionDataSource>()),
  );
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(getIt<RemoteAccountDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton<CalculateBalanceUseCase>(
    () => CalculateBalanceUseCase(getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<ProcessTransactionUseCase>(
    () => ProcessTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<NotifyTransactionUseCase>(
    () => NotifyTransactionUseCase(),
  );

  // ViewModel
  getIt.registerFactory<FinanceViewModel>(
    () => FinanceViewModel(
      calculateBalanceUseCase: getIt<CalculateBalanceUseCase>(),
      processTransactionUseCase: getIt<ProcessTransactionUseCase>(),
      notifyTransactionUseCase: getIt<NotifyTransactionUseCase>(),
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<FinanceViewModel>()),
      ],
      child: const FinanceApp(),
    ),
  );
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finanzas Personales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

// === ARCHIVO: lib/domain/entities/transaction.dart ===
import 'package:equatable/equatable.dart';

/// Entidad que representa una transacción financiera en el dominio.
/// Es inmutable y utiliza copyWith para crear nuevas instancias con valores modificados.
class Transaction extends Equatable {
  final String id;
  final String accountId;
  final double amount;
  final String description;
  final DateTime date;
  final String category;
  final TransactionType type;
  final TransactionStatus status;

  const Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.type,
    this.status = TransactionStatus.pending,
  });

  /// Crea una nueva instancia de Transaction con los valores modificados.
  Transaction copyWith({
    String? id,
    String? accountId,
    double? amount,
    String? description,
    DateTime? date,
    String? category,
    TransactionType? type,
    TransactionStatus? status,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountId,
        amount,
        description,
        date,
        category,
        type,
        status,
      ];

  /// Valida que el monto de la transacción sea positivo.
  bool isValidAmount() {
    return amount > 0;
  }

  /// Calcula el impacto en el saldo según el tipo de transacción.
  double calculateBalanceImpact() {
    return type == TransactionType.income ? amount : -amount;
  }
}

/// Tipos de transacción soportados.
enum TransactionType {
  income,
  expense,
}

/// Estados posibles de una transacción.
enum TransactionStatus {
  pending,
  completed,
  failed,
  reversed,
}

// === ARCHIVO: lib/domain/entities/account.dart ===
import 'package:equatable/equatable.dart';

/// Entidad que representa una cuenta financiera en el dominio.
/// Es inmutable y utiliza copyWith para crear nuevas instancias con valores modificados.
class Account extends Equatable {
  final String id;
  final String name;
  final String userId;
  final double initialBalance;
  final Currency currency;
  final AccountType type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Account({
    required this.id,
    required this.name,
    required this.userId,
    required this.initialBalance,
    required this.currency,
    required this.type,
    required this.createdAt,
    this.updatedAt,
  });

  /// Crea una nueva instancia de Account con los valores modificados.
  Account copyWith({
    String? id,
    String? name,
    String? userId,
    double? initialBalance,
    Currency? currency,
    AccountType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      initialBalance: initialBalance ?? this.initialBalance,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        userId,
        initialBalance,
        currency,
        type,
        createdAt,
        updatedAt,
      ];

  /// Valida que el saldo inicial sea no negativo.
  bool isValidInitialBalance() {
    return initialBalance >= 0;
  }
}

/// Tipos de moneda soportados.
enum Currency {
  usd,
  eur,
  gbp,
  jpy,
}

/// Tipos de cuenta soportados.
enum AccountType {
  checking,
  savings,
  investment,
  credit,
}

// === ARCHIVO: lib/domain/entities/balance.dart ===
import 'package:equatable/equatable.dart';

/// Entidad que representa el balance financiero de una cuenta en un momento dado.
/// Es inmutable y utiliza copyWith para crear nuevas instancias con valores modificados.
class Balance extends Equatable {
  final String id;
  final String accountId;
  final double currentBalance;
  final DateTime date;
  final double income;
  final double expenses;
  final Currency currency;

  const Balance({
    required this.id,
    required this.accountId,
    required this.currentBalance,
    required this.date,
    required this.income,
    required this.expenses,
    required this.currency,
  });

  /// Crea una nueva instancia de Balance con los valores modificados.
  Balance copyWith({
    String? id,
    String? accountId,
    double? currentBalance,
    DateTime? date,
    double? income,
    double? expenses,
    Currency? currency,
  }) {
    return Balance(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      currentBalance: currentBalance ?? this.currentBalance,
      date: date ?? this.date,
      income: income ?? this.income,
      expenses: expenses ?? this.expenses,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountId,
        currentBalance,
        date,
        income,
        expenses,
        currency,
      ];

  /// Calcula el balance proyectado con una nueva transacción.
  Balance applyTransaction(double amount, TransactionType type) {
    final impact = type == TransactionType.income ? amount : -amount;
    final newIncome = type == TransactionType.income ? income + amount : income;
    final newExpenses = type == TransactionType.expense ? expenses + amount : expenses;

    return copyWith(
      currentBalance: currentBalance + impact,
      income: newIncome,
      expenses: newExpenses,
      date: DateTime.now(),
    );
  }

  /// Verifica si el balance actual es suficiente para una transacción de gasto.
  bool canAfford(double amount) {
    return currentBalance >= amount;
  }
}

// === ARCHIVO: lib/domain/repositories/transaction_repository.dart ===
import 'package:equatable/equatable.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository extends Equatable {
  const TransactionRepository();

  Future<List<Transaction>> getTransactionsByAccount(String accountId);

  Future<Transaction?> getTransactionById(String id);

  Future<Transaction> createTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(String id);

  Future<List<Transaction>> getTransactionsByDateRange(
    String accountId,
    DateTime startDate,
    DateTime endDate,
  );

  Future<List<Transaction>> getTransactionsByCategory(
    String accountId,
    String category,
  );

  Future<double> getTotalAmountByType(
    String accountId,
    TransactionType type,
  );

  Future<List<Transaction>> getPendingTransactions(String accountId);

  Future<void> processTransactionBatch(List<Transaction> transactions);

  Stream<Transaction> watchTransactions(String accountId);
}

// === ARCHIVO: lib/domain/repositories/account_repository.dart ===
import 'package:equatable/equatable.dart';
import '../entities/account.dart';
import '../entities/balance.dart';

abstract class AccountRepository extends Equatable {
  const AccountRepository();

  Future<List<Account>> getAccountsByUser(String userId);

  Future<Account?> getAccountById(String id);

  Future<Account> createAccount(Account account);

  Future<Account> updateAccount(Account account);

  Future<void> deleteAccount(String id);

  Future<Balance?> getAccountBalance(String accountId);

  Future<Balance> updateAccountBalance(String accountId, Balance balance);

  Future<List<Account>> getAccountsByType(String userId, AccountType type);

  Future<bool> accountExists(String accountId);

  Future<double> getTotalBalanceByUser(String userId);

  Future<void> transferBetweenAccounts(
    String fromAccountId,
    String toAccountId,
    double amount,
  );

  Future<List<Account>> searchAccounts(String userId, String query);

  Stream<Account> watchAccount(String accountId);

  Stream<List<Account>> watchAccountsByUser(String userId);
}

// === ARCHIVO: lib/domain/usecases/calculate_balance_usecase.dart ===
import 'package:equatable/equatable.dart';
import '../entities/account.dart';
import '../entities/balance.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';
import '../repositories/transaction_repository.dart';

class CalculateBalanceUseCase extends Equatable {
  final AccountRepository accountRepository;
  final TransactionRepository transactionRepository;

  const CalculateBalanceUseCase({
    required this.accountRepository,
    required this.transactionRepository,
  });

  Future<Balance> execute(String accountId) async {
    final account = await accountRepository.getAccountById(accountId);
    if (account == null) {
      throw AccountNotFoundException('Account with id $accountId not found');
    }

    final transactions = await transactionRepository.getTransactionsByAccount(accountId);
    final pendingTransactions = await transactionRepository.getPendingTransactions(accountId);

    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    for (final transaction in transactions) {
      if (transaction.status == TransactionStatus.completed) {
        final impact = transaction.calculateBalanceImpact();
        if (impact > 0) {
          totalIncome += impact;
        } else {
          totalExpenses += impact.abs();
        }
      }
    }

    final currentBalance = account.initialBalance + totalIncome - totalExpenses;
    final pendingAmount = pendingTransactions.fold<double>(
      0.0,
      (sum, tx) => sum + tx.calculateBalanceImpact(),
    );

    final balance = Balance(
      id: 'balance_$accountId',
      accountId: accountId,
      currentBalance: currentBalance,
      date: DateTime.now(),
      income: totalIncome,
      expenses: totalExpenses,
      currency: account.currency,
    );

    return balance;
  }

  Future<Balance> executeWithProjection(
    String accountId,
    DateTime projectionDate,
  ) async {
    final baseBalance = await execute(accountId);

    final futureTransactions = await transactionRepository.getTransactionsByDateRange(
      accountId,
      DateTime.now(),
      projectionDate,
    );

    double projectedIncome = 0.0;
    double projectedExpenses = 0.0;

    for (final transaction in futureTransactions) {
      final impact = transaction.calculateBalanceImpact();
      if (transaction.type == TransactionType.income ||
          (transaction.type == TransactionType.transfer && impact > 0)) {
        projectedIncome += impact;
      } else {
        projectedExpenses += impact.abs();
      }
    }

    return Balance(
      id: 'balance_projected_$accountId',
      accountId: accountId,
      currentBalance: baseBalance.currentBalance + projectedIncome - projectedExpenses,
      date: projectionDate,
      income: baseBalance.income + projectedIncome,
      expenses: baseBalance.expenses + projectedExpenses,
      currency: baseBalance.currency,
    );
  }

  Future<bool> canWithdraw(String accountId, double amount) async {
    final balance = await execute(accountId);
    return balance.canAfford(amount);
  }

  Future<Map<String, double>> calculateCategoryBreakdown(String accountId) async {
    final transactions = await transactionRepository.getTransactionsByAccount(accountId);
    final Map<String, double> breakdown = {};

    for (final transaction in transactions) {
      if (transaction.status == TransactionStatus.completed &&
          transaction.type == TransactionType.expense) {
        breakdown[transaction.category] =
            (breakdown[transaction.category] ?? 0.0) + transaction.amount;
      }
    }

    return breakdown;
  }

  Future<BalanceSummary> calculateSummary(String userId) async {
    final accounts = await accountRepository.getAccountsByUser(userId);
    
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    double totalBalance = 0.0;

    for (final account in accounts) {
      final balance = await execute(account.id);
      totalIncome += balance.income;
      totalExpenses += balance.expenses;
      totalBalance += balance.currentBalance;
    }

    return BalanceSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalBalance: totalBalance,
      accountCount: accounts.length,
    );
  }
}

class AccountNotFoundException implements Exception {
  final String message;
  const AccountNotFoundException(this.message);

  @override
  String toString() => 'AccountNotFoundException: $message';
}

class BalanceSummary extends Equatable {
  final double totalIncome;
  final double totalExpenses;
  final double totalBalance;
  final int accountCount;

  const BalanceSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalBalance,
    required this.accountCount,
  });

  double get netSavings => totalIncome - totalExpenses;

  double get savingsRate => totalIncome > 0 ? (netSavings / totalIncome) * 100 : 0;

  @override
  List<Object?> get props => [totalIncome, totalExpenses, totalBalance, accountCount];
}

// === ARCHIVO: lib/domain/usecases/process_transaction_usecase.dart ===
package finance_app.domain.usecases;

import 'package:equatable/equatable.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';

class ProcessTransactionParams extends Equatable {
  final String accountId;
  final double amount;
  final String description;
  final String category;
  final TransactionType type;
  final DateTime? date;

  const ProcessTransactionParams({
    required this.accountId,
    required this.amount,
    required this.description,
    required this.category,
    required this.type,
    this.date,
  });

  @override
  List<Object?> get props => [accountId, amount, description, category, type, date];
}

class ProcessTransactionResult extends Equatable {
  final Transaction transaction;
  final Balance updatedBalance;
  final bool success;
  final String? errorMessage;

  const ProcessTransactionResult({
    required this.transaction,
    required this.updatedBalance,
    required this.success,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [transaction, updatedBalance, success, errorMessage];
}

class ProcessTransactionUseCase {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  ProcessTransactionUseCase({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
  })  : _transactionRepository = transactionRepository,
        _accountRepository = accountRepository;

  Future<ProcessTransactionResult> execute(ProcessTransactionParams params) async {
    if (params.amount <= 0) {
      return ProcessTransactionResult(
        transaction: _createFailedTransaction(params),
        updatedBalance: const Balance(
          id: '',
          accountId: '',
          currentBalance: 0,
          date: null,
          income: 0,
          expenses: 0,
          currency: Currency.usd,
        ),
        success: false,
        errorMessage: 'El monto debe ser mayor a cero',
      );
    }

    final account = await _accountRepository.getAccountById(params.accountId);
    if (account == null) {
      return ProcessTransactionResult(
        transaction: _createFailedTransaction(params),
        updatedBalance: const Balance(
          id: '',
          accountId: '',
          currentBalance: 0,
          date: null,
          income: 0,
          expenses: 0,
          currency: Currency.usd,
        ),
        success: false,
        errorMessage: 'Cuenta no encontrada',
      );
    }

    final currentBalance = await _transactionRepository.getLatestBalance(params.accountId);
    final balanceToCheck = currentBalance ?? Balance(
      id: 'initial_${params.accountId}',
      accountId: params.accountId,
      currentBalance: account.initialBalance,
      date: DateTime.now(),
      income: 0,
      expenses: 0,
      currency: account.currency,
    );

    if (params.type == TransactionType.expense && !balanceToCheck.canAfford(params.amount)) {
      return ProcessTransactionResult(
        transaction: _createFailedTransaction(params),
        updatedBalance: balanceToCheck,
        success: false,
        errorMessage: 'Saldo insuficiente para realizar esta transacción',
      );
    }

    final transactionId = _generateTransactionId();
    final now = params.date ?? DateTime.now();
    final newBalance = balanceToCheck.applyTransaction(params.amount, params.type);

    final transaction = Transaction(
      id: transactionId,
      accountId: params.accountId,
      amount: params.amount,
      description: params.description,
      date: now,
      category: params.category,
      type: params.type,
      status: TransactionStatus.completed,
    );

    try {
      await _transactionRepository.saveTransaction(transaction);
      await _transactionRepository.updateBalance(newBalance);

      return ProcessTransactionResult(
        transaction: transaction,
        updatedBalance: newBalance,
        success: true,
      );
    } catch (e) {
      return ProcessTransactionResult(
        transaction: transaction.copyWith(status: TransactionStatus.failed),
        updatedBalance: balanceToCheck,
        success: false,
        errorMessage: 'Error al procesar la transacción: ${e.toString()}',
      );
    }
  }

  Transaction _createFailedTransaction(ProcessTransactionParams params) {
    return Transaction(
      id: _generateTransactionId(),
      accountId: params.accountId,
      amount: params.amount,
      description: params.description,
      date: params.date ?? DateTime.now(),
      category: params.category,
      type: params.type,
      status: TransactionStatus.failed,
    );
  }

  String _generateTransactionId() {
    return 'TXN_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
}

// === ARCHIVO: lib/domain/usecases/notify_transaction_usecase.dart ===
package finance_app.domain.usecases;

import 'package:equatable/equatable.dart';
import 'package:finance_app/domain/entities/transaction.dart';

enum NotificationPriority { low, normal, high, urgent }

class NotificationPayload extends Equatable {
  final String transactionId;
  final String title;
  final String body;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const NotificationPayload({
    required this.transactionId,
    required this.title,
    required this.body,
    required this.timestamp,
    this.metadata,
  });

  @override
  List<Object?> get props => [transactionId, title, body, timestamp, metadata];
}

class NotifyTransactionParams extends Equatable {
  final Transaction transaction;
  final NotificationPriority priority;
  final bool includeBalance;
  final double? currentBalance;

  const NotifyTransactionParams({
    required this.transaction,
    this.priority = NotificationPriority.normal,
    this.includeBalance = false,
    this.currentBalance,
  });

  @override
  List<Object?> get props => [transaction, priority, includeBalance, currentBalance];
}

class NotifyTransactionResult extends Equatable {
  final bool success;
  final String? notificationId;
  final String? errorMessage;
  final NotificationPayload? payload;

  const NotifyTransactionResult({
    required this.success,
    this.notificationId,
    this.errorMessage,
    this.payload,
  });

  @override
  List<Object?> get props => [success, notificationId, errorMessage, payload];
}

abstract class PushNotificationService {
  Future<NotifyTransactionResult> sendNotification(NotificationPayload payload, NotificationPriority priority);
  Future<bool> isServiceAvailable();
  Future<String?> getDeviceToken();
}

class NotifyTransactionUseCase {
  final PushNotificationService _notificationService;

  NotifyTransactionUseCase({
    required PushNotificationService notificationService,
  }) : _notificationService = notificationService;

  Future<NotifyTransactionResult> execute(NotifyTransactionParams params) async {
    final isAvailable = await _notificationService.isServiceAvailable();
    if (!isAvailable) {
      return const NotifyTransactionResult(
        success: false,
        errorMessage: 'Servicio de notificaciones no disponible',
      );
    }

    final payload = _buildNotificationPayload(params);
    final result = await _notificationService.sendNotification(payload, params.priority);
    
    return NotifyTransactionResult(
      success: result.success,
      notificationId: result.notificationId,
      errorMessage: result.errorMessage,
      payload: payload,
    );
  }

  NotificationPayload _buildNotificationPayload(NotifyTransactionParams params) {
    final transaction = params.transaction;
    final typeLabel = transaction.type == TransactionType.income ? 'Ingreso' : 'Gasto';
    final statusEmoji = transaction.status == TransactionStatus.completed ? '✅' : '❌';
    
    String body = '$statusEmoji $typeLabel de \$${transaction.amount.toStringAsFixed(2)}';
    
    if (params.includeBalance && params.currentBalance != null) {
      body += '\nSaldo actual: \$${params.currentBalance!.toStringAsFixed(2)}';
    }
    
    if (transaction.description.isNotEmpty) {
      body += '\n${transaction.description}';
    }

    return NotificationPayload(
      transactionId: transaction.id,
      title: 'Transacción ${transaction.type == TransactionType.income ? 'recibida' : 'procesada'}',
      body: body,
      timestamp: transaction.date,
      metadata: {
        'accountId': transaction.accountId,
        'category': transaction.category,
        'status': transaction.status.name,
        'type': transaction.type.name,
      },
    );
  }

  Future<NotifyTransactionResult> notifyLargeTransaction(Transaction transaction, double currentBalance) async {
    final params = NotifyTransactionParams(
      transaction: transaction,
      priority: NotificationPriority.high,
      includeBalance: true,
      currentBalance: currentBalance,
    );
    return execute(params);
  }

  Future<NotifyTransactionResult> notifyLowBalance(Transaction transaction, double threshold) async {
    final params = NotifyTransactionParams(
      transaction: transaction,
      priority: NotificationPriority.urgent,
      includeBalance: true,
      currentBalance: threshold,
    );
    return execute(params);
  }

  Future<NotifyTransactionResult> notifyFailedTransaction(Transaction transaction, String reason) async {
    final payload = NotificationPayload(
      transactionId: transaction.id,
      title: 'Transacción fallida',
      body: 'La transacción de \$${transaction.amount.toStringAsFixed(2)} no pudo ser procesada. Razón: $reason',
      timestamp: DateTime.now(),
      metadata: {
        'accountId': transaction.accountId,
        'failureReason': reason,
        'status': 'failed',
      },
    );
    
    return _notificationService.sendNotification(payload, NotificationPriority.urgent);
  }
}

// === ARCHIVO: lib/data/models/transaction_model.dart ===
package finance_app.data.models;

import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String accountId;
  final double amount;
  final String description;
  final DateTime date;
  final String category;
  final String type;
  final String status;

  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.type,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
      'status': status,
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'category': category,
      'type': type,
      'status': status,
    };
  }

  factory TransactionModel.fromDbMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      accountId: map['account_id'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
    );
  }

  factory TransactionModel.fromEntity({
    required String id,
    required String accountId,
    required double amount,
    required String description,
    required DateTime date,
    required String category,
    required String type,
    required String status,
  }) {
    return TransactionModel(
      id: id,
      accountId: accountId,
      amount: amount,
      description: description,
      date: date,
      category: category,
      type: type,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountId,
        amount,
        description,
        date,
        category,
        type,
        status,
      ];

  TransactionModel copyWith({
    String? id,
    String? accountId,
    double? amount,
    String? description,
    DateTime? date,
    String? category,
    String? type,
    String? status,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  bool get isIncome => type == 'income' || type == 'credit';
  bool get isExpense => type == 'expense' || type == 'debit';
  bool get isCompleted => status == 'completed';
  bool get isPending => status == 'pending';
  bool get isCancelled => status == 'cancelled';

  double get balanceImpact => isIncome ? amount : (isExpense ? -amount : 0);

  String get typeDisplayName {
    switch (type) {
      case 'income':
        return 'Ingreso';
      case 'expense':
        return 'Gasto';
      case 'credit':
        return 'Crédito';
      case 'debit':
        return 'Débito';
      case 'transfer':
        return 'Transferencia';
      default:
        return 'Desconocido';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case 'completed':
        return 'Completada';
      case 'pending':
        return 'Pendiente';
      case 'cancelled':
        return 'Cancelada';
      case 'failed':
        return 'Fallida';
      default:
        return 'Desconocido';
    }
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, accountId: $accountId, amount: $amount, '
        'description: $description, date: $date, category: $category, '
        'type: $type, status: $status)';
  }
}

// === ARCHIVO: lib/data/models/account_model.dart ===
package finance_app.data.models;

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String name;
  final String userId;
  final double initialBalance;
  final String currency;
  final String type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AccountModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.initialBalance,
    required this.currency,
    required this.type,
    required this.createdAt,
    this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['user_id'] as String,
      initialBalance: (json['initial_balance'] as num).toDouble(),
      currency: json['currency'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'initial_balance': initialBalance,
      'currency': currency,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'initial_balance': initialBalance,
      'currency': currency,
      'type': type,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory AccountModel.fromDbMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['user_id'] as String,
      initialBalance: (map['initial_balance'] as num).toDouble(),
      currency: map['currency'] as String,
      type: map['type'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        userId,
        initialBalance,
        currency,
        type,
        createdAt,
        updatedAt,
      ];

  AccountModel copyWith({
    String? id,
    String? name,
    String? userId,
    double? initialBalance,
    String? currency,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      initialBalance: initialBalance ?? this.initialBalance,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isBankAccount => type == 'bank' || type == 'checking';
  bool get isCash => type == 'cash';
  bool get isCreditCard => type == 'credit_card';
  bool get isSavings => type == 'savings';
  bool get isInvestment => type == 'investment';

  String get typeDisplayName {
    switch (type) {
      case 'bank':
        return 'Cuenta Bancaria';
      case 'checking':
        return 'Cuenta Corriente';
      case 'savings':
        return 'Cuenta de Ahorros';
      case 'cash':
        return 'Efectivo';
      case 'credit_card':
        return 'Tarjeta de Crédito';
      case 'investment':
        return 'Inversión';
      default:
        return 'Desconocido';
    }
  }

  String get currencySymbol {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'COP':
        return '\$';
      case 'MXN':
        return '\$';
      default:
        return currency;
    }
  }

  String formatBalance() {
    return '$currencySymbol${initialBalance.toStringAsFixed(2)}';
  }

  @override
  String toString() {
    return 'AccountModel(id: $id, name: $name, userId: $userId, '
        'initialBalance: $initialBalance, currency: $currency, '
        'type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

// === ARCHIVO: lib/data/repositories/transaction_repository_impl.dart ===
package finance_app.data.repositories;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  static const String _tableName = 'transactions';
  static const String _dbName = 'finance_app.db';
  static const int _dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        date INTEGER NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        status TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_account_id ON $_tableName (account_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_date ON $_tableName (date DESC)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_status ON $_tableName (status)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE $_tableName ADD COLUMN tags TEXT
      ''');
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByAccount(
      String accountId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'account_id = ?',
      whereArgs: [accountId],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByStatus(String status) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'status = ?',
      whereArgs: [status],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategory(
      String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return TransactionModel.fromDbMap(maps.first);
  }

  @override
  Future<void> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    final mapWithTimestamps = transaction.toDbMap();
    mapWithTimestamps['created_at'] =
        DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableName,
      mapWithTimestamps,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    final db = await database;
    final mapWithTimestamps = transaction.toDbMap();
    mapWithTimestamps['updated_at'] =
        DateTime.now().millisecondsSinceEpoch;
    await db.update(
      _tableName,
      mapWithTimestamps,
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAllTransactions() async {
    final db = await database;
    await db.delete(_tableName);
  }

  @override
  Future<double> calculateTotalByType(String accountId, String type) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $_tableName '
      'WHERE account_id = ? AND type = ? AND status = ?',
      [accountId, type, 'completed'],
    );
    final total = result.first['total'];
    return total != null ? (total as num).toDouble() : 0.0;
  }

  @override
  Future<double> calculateBalance(String accountId) async {
    final db = await database;
    final incomeResult = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $_tableName '
      'WHERE account_id = ? AND (type = ? OR type = ?) AND status = ?',
      [accountId, 'income', 'credit', 'completed'],
    );
    final expenseResult = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $_tableName '
      'WHERE account_id = ? AND (type = ? OR type = ?) AND status = ?',
      [accountId, 'expense', 'debit', 'completed'],
    );

    final income = incomeResult.first['total'];
    final expense = expenseResult.first['total'];

    final totalIncome = income != null ? (income as num).toDouble() : 0.0;
    final totalExpense = expense != null ? (expense as num).toDouble() : 0.0;

    return totalIncome - totalExpense;
  }

  @override
  Future<int> countTransactionsByAccount(String accountId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $_tableName WHERE account_id = ?',
      [accountId],
    );
    return (result.first['count'] as int?) ?? 0;
  }

  @override
  Future<List<TransactionModel>> searchTransactions(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'description LIKE ? OR category LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<void> batchInsertTransactions(
      List<TransactionModel> transactions) async {
    final db = await database;
    final batch = db.batch();
    final now = DateTime.now().millisecondsSinceEpoch;

    for (final transaction in transactions) {
      final mapWithTimestamps = transaction.toDbMap();
      mapWithTimestamps['created_at'] = now;
      batch.insert(
        _tableName,
        mapWithTimestamps,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(_tableName);
  }
}

// === ARCHIVO: lib/data/repositories/account_repository_impl.dart ===
package finance_app.data.repositories;

import 'package:finance_app/data/datasources/remote_account_datasource.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:equatable/equatable.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RemoteAccountDataSource _remoteDataSource;
  final List<Account> _cache = [];
  bool _isCacheValid = false;

  AccountRepositoryImpl({
    required RemoteAccountDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Account>> getAccounts() async {
    if (_isCacheValid && _cache.isNotEmpty) {
      return List.unmodifiable(_cache);
    }

    try {
      final accountModels = await _remoteDataSource.fetchAccounts();
      _cache.clear();
      _cache.addAll(accountModels);
      _isCacheValid = true;
      return List.unmodifiable(_cache);
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al obtener cuentas: ${e.message}',
        originalError: e,
      );
    } on NetworkException catch (e) {
      throw RepositoryException(
        message: 'Error de red al obtener cuentas: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<Account?> getAccountById(String id) async {
    final cached = _cache.where((a) => a.id == id).firstOrNull;
    if (cached != null && _isCacheValid) {
      return cached;
    }

    try {
      final accountModel = await _remoteDataSource.fetchAccountById(id);
      if (accountModel != null) {
        final existingIndex = _cache.indexWhere((a) => a.id == id);
        if (existingIndex >= 0) {
          _cache[existingIndex] = accountModel;
        } else {
          _cache.add(accountModel);
        }
      }
      return accountModel;
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al obtener cuenta por ID: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<Account> createAccount(Account account) async {
    try {
      final createdAccount = await _remoteDataSource.createAccount(account);
      _cache.add(createdAccount);
      _invalidateCache();
      return createdAccount;
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al crear cuenta: ${e.message}',
        originalError: e,
      );
    } on ValidationException catch (e) {
      throw RepositoryException(
        message: 'Validación fallida al crear cuenta: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<Account> updateAccount(Account account) async {
    try {
      final updatedAccount = await _remoteDataSource.updateAccount(account);
      final index = _cache.indexWhere((a) => a.id == account.id);
      if (index >= 0) {
        _cache[index] = updatedAccount;
      }
      _invalidateCache();
      return updatedAccount;
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al actualizar cuenta: ${e.message}',
        originalError: e,
      );
    } on NotFoundException catch (e) {
      throw RepositoryException(
        message: 'Cuenta no encontrada para actualizar: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<void> deleteAccount(String id) async {
    try {
      await _remoteDataSource.deleteAccount(id);
      _cache.removeWhere((a) => a.id == id);
      _invalidateCache();
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al eliminar cuenta: ${e.message}',
        originalError: e,
      );
    } on NotFoundException catch (e) {
      throw RepositoryException(
        message: 'Cuenta no encontrada para eliminar: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Account>> getAccountsByUserId(String userId) async {
    try {
      final allAccounts = await getAccounts();
      return allAccounts.where((a) => a.userId == userId).toList();
    } catch (e) {
      if (e is RepositoryException) rethrow;
      throw RepositoryException(message: 'Error al filtrar cuentas por usuario');
    }
  }

  @override
  Future<void> invalidateCache() async {
    _invalidateCache();
  }

  void _invalidateCache() {
    _isCacheValid = false;
  }
}

class RepositoryException implements Exception {
  final String message;
  final Object? originalError;

  const RepositoryException({
    required this.message,
    this.originalError,
  });

  @override
  String toString() => 'RepositoryException: $message';
}

class DataSourceException implements Exception {
  final String message;
  final int? statusCode;

  const DataSourceException({required this.message, this.statusCode});

  @override
  String toString() => 'DataSourceException: $message (status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException({required this.message, this.statusCode});

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;
  final String? resourceId;

  const NotFoundException({required this.message, this.resourceId});

  @override
  String toString() => 'NotFoundException: $message';
}

// === ARCHIVO: lib/data/datasources/local_transaction_datasource.dart ===
package finance_app.data.datasources;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;
import 'package:finance_app/data/models/transaction_model.dart';
import 'package:finance_app/domain/entities/transaction.dart';

abstract class LocalTransactionDataSource {
  Future<void> initialize();
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel?> getTransactionById(String id);
  Future<List<TransactionModel>> getTransactionsByAccountId(String accountId);
  Future<TransactionModel> insertTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
  Future<void> deleteTransactionsByAccountId(String accountId);
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  );
  Future<List<TransactionModel>> getTransactionsByCategory(String category);
  Future<void> clearAllTransactions();
  Future<void> close();
}

class LocalTransactionDataSourceImpl implements LocalTransactionDataSource {
  Database? _database;
  static const String _databaseName = 'finance_app.db';
  static const int _databaseVersion = 1;
  static const String _tableTransactions = 'transactions';

  LocalTransactionDataSourceImpl();

  Future<Database> get database async {
    if (_database != null) return _database!;
    await initialize();
    return _database!;
  }

  @override
  Future<void> initialize() async {
    if (_database != null && _database!.isOpen) return;

    final databasesPath = await getDatabasesPath();
    final dbPath = path_helper.join(databasesPath, _databaseName);

    _database = await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableTransactions (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT,
        date INTEGER NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        status TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_account_id ON $_tableTransactions (account_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_date ON $_tableTransactions (date)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_category ON $_tableTransactions (category)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Migraciones futuras aquí
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return _mapToTransactionModel(maps.first);
  }

  @override
  Future<List<TransactionModel>> getTransactionsByAccountId(
    String accountId,
  ) async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      where: 'account_id = ?',
      whereArgs: [accountId],
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<TransactionModel> insertTransaction(
    TransactionModel transaction,
  ) async {
    final db = await database;
    final map = _transactionModelToMap(transaction);
    await db.insert(
      _tableTransactions,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return transaction;
  }

  @override
  Future<TransactionModel> updateTransaction(
    TransactionModel transaction,
  ) async {
    final db = await database;
    final map = _transactionModelToMap(transaction);
    map['updated_at'] = DateTime.now().millisecondsSinceEpoch;

    final rowsAffected = await db.update(
      _tableTransactions,
      map,
      where: 'id = ?',
      whereArgs: [transaction.id],
    );

    if (rowsAffected == 0) {
      throw LocalDataSourceException(
        message: 'No se encontró la transacción para actualizar: ${transaction.id}',
      );
    }

    return transaction;
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      _tableTransactions,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTransactionsByAccountId(String accountId) async {
    final db = await database;
    await db.delete(
      _tableTransactions,
      where: 'account_id = ?',
      whereArgs: [accountId],
    );
  }

  @override
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final startMs = start.millisecondsSinceEpoch;
    final endMs = end.millisecondsSinceEpoch;

    final maps = await db.query(
      _tableTransactions,
      where: 'date >= ? AND date <= ?',
      whereArgs: [startMs, endMs],
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategory(
    String category,
  ) async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<void> clearAllTransactions() async {
    final db = await database;
    await db.delete(_tableTransactions);
  }

  @override
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  TransactionModel _mapToTransactionModel(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      accountId: map['account_id'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String?,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as String,
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionType.expense,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TransactionStatus.pending,
      ),
    );
  }

  Map<String, dynamic> _transactionModelToMap(TransactionModel model) {
    return {
      'id': model.id,
      'account_id': model.accountId,
      'amount': model.amount,
      'description': model.description,
      'date': model.date.millisecondsSinceEpoch,
      'category': model.category,
      'type': model.type.name,
      'status': model.status.name,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class LocalDataSourceException implements Exception {
  final String message;

  const LocalDataSourceException({required this.message});

  @override
  String toString() => 'LocalDataSourceException: $message';
}

// === ARCHIVO: lib/data/datasources/remote_account_datasource.dart ===
package finance_app.data.datasources;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finance_app/data/models/account_model.dart';
import 'package:finance_app/domain/entities/account.dart';

abstract class RemoteAccountDataSource {
  Future<List<AccountModel>> fetchAccounts();
  Future<AccountModel?> fetchAccountById(String id);
  Future<AccountModel> createAccount(Account account);
  Future<AccountModel> updateAccount(Account account);
  Future<void> deleteAccount(String id);
  Future<List<AccountModel>> fetchAccountsByUserId(String userId);
}

class RemoteAccountDataSourceImpl implements RemoteAccountDataSource {
  final http.Client _httpClient;
  final String _baseUrl;
  final Duration _timeout;

  RemoteAccountDataSourceImpl({
    required http.Client httpClient,
    String baseUrl = 'https://api.financeapp.example.com/v1',
    Duration timeout = const Duration(seconds: 30),
  })  : _httpClient = httpClient,
        _baseUrl = baseUrl,
        _timeout = timeout;

  @override
  Future<List<AccountModel>> fetchAccounts() async {
    final uri = Uri.parse('$_baseUrl/accounts');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      return _handleResponse<List<AccountModel>>(
        response,
        (body) {
          final List<dynamic> jsonList = json.decode(body) as List<dynamic>;
          return jsonList
              .map((json) => AccountModel.fromJson(json as Map<String, dynamic>))
              .toList();
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al obtener cuentas: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al obtener cuentas: $e');
    }
  }

  @override
  Future<AccountModel?> fetchAccountById(String id) async {
    final uri = Uri.parse('$_baseUrl/accounts/$id');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      if (response.statusCode == 404) {
        return null;
      }

      return _handleResponse<AccountModel>(
        response,
        (body) {
          final json = jsonDecode(body) as Map<String, dynamic>;
          return AccountModel.fromJson(json);
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al obtener cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al obtener cuenta: $e');
    }
  }

  @override
  Future<AccountModel> createAccount(Account account) async {
    final uri = Uri.parse('$_baseUrl/accounts');
    final body = json.encode(AccountModel.fromEntity(account).toJson());

    try {
      final response = await _httpClient
          .post(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(_timeout);

      return _handleResponse<AccountModel>(
        response,
        (responseBody) {
          final json = jsonDecode(responseBody) as Map<String, dynamic>;
          return AccountModel.fromJson(json);
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al crear cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al crear cuenta: $e');
    }
  }

  @override
  Future<AccountModel> updateAccount(Account account) async {
    final uri = Uri.parse('$_baseUrl/accounts/${account.id}');
    final body = json.encode(AccountModel.fromEntity(account).toJson());

    try {
      final response = await _httpClient
          .put(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(_timeout);

      return _handleResponse<AccountModel>(
        response,
        (responseBody) {
          final json = jsonDecode(responseBody) as Map<String, dynamic>;
          return AccountModel.fromJson(json);
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al actualizar cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al actualizar cuenta: $e');
    }
  }

  @override
  Future<void> deleteAccount(String id) async {
    final uri = Uri.parse('$_baseUrl/accounts/$id');

    try {
      final response = await _httpClient
          .delete(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      if (response.statusCode == 404) {
        throw NotFoundException(
          message: 'Cuenta no encontrada',
          resourceId: id,
        );
      }

      _handleResponse<void>(
        response,
        (_) => null,
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al eliminar cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al eliminar cuenta: $e');
    }
  }

  @override
  Future<List<AccountModel>> fetchAccountsByUserId(String userId) async {
    final uri = Uri.parse('$_baseUrl/users/$userId/accounts');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      return _handleResponse<List<AccountModel>>(
        response,
        (body) {
          final List<dynamic> jsonList = json.decode(body) as List<dynamic>;
          return jsonList
              .map((json) => AccountModel.fromJson(json as Map<String, dynamic>))
              .toList();
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al obtener cuentas de usuario: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(
        message: 'Error inesperado al obtener cuentas de usuario: $e',
      );
    }
  }

  Map<String, String> _buildHeaders({String? contentType}) {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': contentType ?? 'application/json',
    };
    return headers;
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(String body) parser,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return parser(response.body);
    } else if (response.statusCode == 400) {
      final errorBody = _parseErrorBody(response.body);
      throw ValidationException(
        message: errorBody['message'] ?? 'Datos inválidos',
        fieldErrors: errorBody['errors'] != null
            ? Map<String, String>.from(errorBody['errors'] as Map)
            : null,
      );
    } else if (response.statusCode == 404) {
      throw NotFoundException(
        message: 'Recurso no encontrado',
      );
    } else if (response.statusCode >= 500) {
      throw DataSourceException(
        message: 'Error del servidor',
        statusCode: response.statusCode,
      );
    } else {
      throw DataSourceException(
        message: 'Error desconocido',
        statusCode: response.statusCode,
      );
    }
  }

  Map<String, dynamic> _parseErrorBody(String body) {
    try {
      return json.decode(body) as Map<String, dynamic>;
    } catch (e) {
      return {'message': 'Error desconocido'};
    }
  }
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class DataSourceException implements Exception {
  final String message;
  final int? statusCode;

  const DataSourceException({required this.message, this.statusCode});

  @override
  String toString() => 'DataSourceException: $message (status: $statusCode)';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;
  final String? resourceId;

  const NotFoundException({required this.message, this.resourceId});

  @override
  String toString() => 'NotFoundException: $message';
}

// === ARCHIVO: android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    
    <application
        android:label="finance_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:allowBackup="false"
        android:fullBackupContent="false"
        android:hardwareAccelerated="true"
        android:largeHeap="true"
        android:usesCleartextTraffic="false">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
            
        <service
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
            android:exported="false" />
            
        <receiver
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
            android:enabled="false"
            android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>
        
    </application>
    
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
    
</manifest>

// === ARCHIVO: lib/presentation/screens/home_screen.dart ===
package:finance_app/presentation/screens/home_screen.dart;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/presentation/viewmodels/finance_viewmodel.dart';
import 'package:finance_app/presentation/widgets/balance_card.dart';
import 'package:finance_app/presentation/widgets/transaction_list.dart';
import 'package:finance_app/presentation/screens/transaction_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinanceViewModel>().loadInitialData();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<FinanceViewModel>().refreshData();
  }

  void _showAddTransactionDialog() {
    final viewModel = context.read<FinanceViewModel>();
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = 'Alimentación';
    bool isIncome = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nueva Transacción',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: false, label: Text('Gasto')),
                  ButtonSegment(value: true, label: Text('Ingreso')),
                ],
                selected: {isIncome},
                onSelectionChanged: (Set<bool> selected) {
                  setModalState(() => isIncome = selected.first);
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Monto',
                  prefixText: isIncome ? '+ ' : '- ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                items: ['Alimentación', 'Transporte', 'Entretenimiento', 'Servicios', 'Otros']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setModalState(() => selectedCategory = value!),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final amount = double.tryParse(amountController.text);
                    if (amount != null && amount > 0) {
                      await viewModel.addTransaction(
                        amount: amount,
                        description: descriptionController.text.isEmpty
                            ? selectedCategory
                            : descriptionController.text,
                        category: selectedCategory,
                        isIncome: isIncome,
                      );
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Agregar Transacción', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Mis Finanzas'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefresh,
            tooltip: 'Actualizar datos',
          ),
        ],
      ),
      body: Consumer<FinanceViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.transactions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null && viewModel.transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar datos',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => viewModel.loadInitialData(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BalanceCard(
                          balance: viewModel.currentBalance,
                          income: viewModel.totalIncome,
                          expenses: viewModel.totalExpenses,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Transacciones Recientes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Ver todas'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (viewModel.transactions.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No hay transacciones aún',
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Toca el botón + para agregar tu primera transacción',
                            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: TransactionList(
                      transactions: viewModel.transactions,
                      onTransactionTap: (transaction) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionDetailScreen(
                              transaction: transaction,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/screens/transaction_detail_screen.dart ===
package:finance_app/presentation/screens.transaction_detail_screen.dart;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/presentation/viewmodels/finance_viewmodel.dart';

class TransactionDetailScreen extends StatefulWidget {
  final Transaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late Transaction _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = widget.transaction;
  }

  Color _getTypeColor(TransactionType type) {
    return type == TransactionType.income ? Colors.green : Colors.red;
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'alimentación':
        return Icons.restaurant;
      case 'transporte':
        return Icons.directions_car;
      case 'entretenimiento':
        return Icons.movie;
      case 'servicios':
        return Icons.receipt;
      default:
        return Icons.category;
    }
  }

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]} de ${date.year}';
  }

  void _showEditDialog() {
    final viewModel = context.read<FinanceViewModel>();
    final descriptionController = TextEditingController(text: _transaction.description);
    final amountController = TextEditingController(text: _transaction.amount.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Transacción'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newAmount = double.tryParse(amountController.text);
              if (newAmount != null && newAmount > 0) {
                await viewModel.updateTransaction(
                  _transaction.copyWith(
                    amount: newAmount,
                    description: descriptionController.text,
                  ),
                );
                setState(() {
                  _transaction = _transaction.copyWith(
                    amount: newAmount,
                    description: descriptionController.text,
                  );
                });
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Transacción'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar esta transacción? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.read<FinanceViewModel>().deleteTransaction(_transaction.id);
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(_transaction.type);
    final isIncome = _transaction.type == TransactionType.income;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Detalle de Transacción'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
            tooltip: 'Editar',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _showDeleteConfirmation,
            tooltip: 'Eliminar',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getCategoryIcon(_transaction.category),
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${isIncome ? '+' : '-'}${_formatCurrency(_transaction.amount)}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _transaction.type == TransactionType.income ? 'INGRESO' : 'GASTO',
                      style: TextStyle(
                        color: typeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        icon: Icons.description,
                        label: 'Descripción',
                        value: _transaction.description,
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        icon: Icons.category,
                        label: 'Categoría',
                        value: _transaction.category,
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        icon: Icons.calendar_today,
                        label: 'Fecha',
                        value: _formatDate(_transaction.date),
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        icon: Icons.info_outline,
                        label: 'Estado',
                        value: _transaction.status == TransactionStatus.completed
                            ? 'Completada'
                            : 'Pendiente',
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        icon: Icons.tag,
                        label: 'ID de Transacción',
                        value: _transaction.id,
                        isMonospace: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Impacto en el Balance',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Efecto en cuenta:'),
                          Text(
                            isIncome
                                ? '+${_formatCurrency(_transaction.calculateBalanceImpact())}'
                                : _formatCurrency(_transaction.calculateBalanceImpact()),
                            style: TextStyle(
                              color: typeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isMonospace = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: isMonospace ? 'monospace' : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// === ARCHIVO: lib/presentation/viewmodels/finance_viewmodel.dart ===
package:finance_app/presentation.viewmodels;

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/calculate_balance_usecase.dart';
import 'package:finance_app/domain/usecases/process_transaction_usecase.dart';

class FinanceViewModel extends ChangeNotifier {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  final CalculateBalanceUseCase _calculateBalanceUseCase;
  final ProcessTransactionUseCase _processTransactionUseCase;

  List<Transaction> _transactions = [];
  Account? _currentAccount;
  Balance? _currentBalance;
  bool _isLoading = false;
  String? _error;

  FinanceViewModel({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
    required CalculateBalanceUseCase calculateBalanceUseCase,
    required ProcessTransactionUseCase processTransactionUseCase,
  })  : _transactionRepository = transactionRepository,
        _accountRepository = accountRepository,
        _calculateBalanceUseCase = calculateBalanceUseCase,
        _processTransactionUseCase = processTransactionUseCase;

  List<Transaction> get transactions => List.unmodifiable(_transactions);
  Account? get currentAccount => _currentAccount;
  Balance? get currentBalance => _currentBalance;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.income && t.status == TransactionStatus.completed)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses => _transactions
      .where((t) => t.type == TransactionType.expense && t.status == TransactionStatus.completed)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get netBalance => totalIncome - totalExpenses;

  Future<void> loadInitialData() async {
    _setLoading(true);
    _clearError();

    try {
      final accounts = await _accountRepository.getAccounts();
      if (accounts.isNotEmpty) {
        _currentAccount = accounts.first;
        await _loadTransactions();
        await _calculateBalance();
      } else {
        await _createDefaultAccount();
      }
    } catch (e) {
      _setError('Error al cargar datos iniciales: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadTransactions() async {
    if (_currentAccount == null) return;

    try {
      final result = await _transactionRepository.getTransactionsByAccount(_currentAccount!.id);
      _transactions = result
        ..sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    } catch (e) {
      _setError('Error al cargar transacciones: ${e.toString()}');
    }
  }

  Future<void> _calculateBalance() async {
    if (_currentAccount == null) return;

    try {
      _currentBalance = await _calculateBalanceUseCase.execute(_currentAccount!.id);
      notifyListeners();
    } catch (e) {
      _setError('Error al calcular balance: ${e.toString()}');
    }
  }

  Future<void> _createDefaultAccount() async {
    final defaultAccount = Account(
      id: 'default_account_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Cuenta Principal',
      userId: 'default_user',
      initialBalance: 0.0,
      currency: Currency.usd,
      type: AccountType.checking,
      createdAt: DateTime.now(),
    );

    await _accountRepository.createAccount(defaultAccount);
    _currentAccount = defaultAccount;
    _currentBalance = Balance(
      id: 'balance_${DateTime.now().millisecondsSinceEpoch}',
      accountId: defaultAccount.id,
      currentBalance: 0.0,
      date: DateTime.now(),
      income: 0.0,
      expenses: 0.0,
      currency: Currency.usd,
    );
    notifyListeners();
  }

  Future<bool> addTransaction({
    required double amount,
    required String description,
    required String category,
    required bool isIncome,
  }) async {
    if (_currentAccount == null) {
      _setError('No hay cuenta activa');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final transaction = Transaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        accountId: _currentAccount!.id,
        amount: amount,
        description: description,
        date: DateTime.now(),
        category: category,
        type: isIncome ? TransactionType.income : TransactionType.expense,
        status: TransactionStatus.completed,
      );

      await _processTransactionUseCase.execute(transaction);
      await _loadTransactions();
      await _calculateBalance();
      return true;
    } catch (e) {
      _setError('Error al agregar transacción: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateTransaction(Transaction transaction) async {
    _setLoading(true);
    _clearError();

    try {
      await _transactionRepository.updateTransaction(transaction);
      await _loadTransactions();
      await _calculateBalance();
      return true;
    } catch (e) {
      _setError('Error al actualizar transacción: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteTransaction(String transactionId) async {
    _setLoading(true);
    _clearError();

    try {
      await _transactionRepository.deleteTransaction(transactionId);
      await _loadTransactions();
      await _calculateBalance();
      return true;
    } catch (e) {
      _setError('Error al eliminar transacción: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshData() async {
    await loadInitialData();
  }

  List<Transaction> getTransactionsByCategory(String category) {
    return _transactions.where((t) => t.category == category).toList();
  }

  List<Transaction> getTransactionsByDateRange(DateTime start, DateTime end) {
    return _transactions.where((t) => t.date.isAfter(start) && t.date.isBefore(end)).toList();
  }

  Map<String, double> getExpensesByCategory() {
    final Map<String, double> expenses = {};
    for (final transaction in _transactions) {
      if (transaction.type == TransactionType.expense) {
        expenses[transaction.category] = (expenses[transaction.category] ?? 0) + transaction.amount;
      }
    }
    return expenses;
  }

  Map<String, double> getIncomeByCategory() {
    final Map<String, double> income = {};
    for (final transaction in _transactions) {
      if (transaction.type == TransactionType.income) {
        income[transaction.category] = (income[transaction.category] ?? 0) + transaction.amount;
      }
    }
    return income;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}

// === ARCHIVO: lib/presentation/widgets/balance_card.dart ===
import 'package:flutter/material.dart';
import '../../domain/entities/balance.dart';
import '../../domain/entities/transaction.dart';

class BalanceCard extends StatelessWidget {
  final Balance balance;
  final VoidCallback? onRefresh;
  final bool showDetails;

  const BalanceCard({
    super.key,
    required this.balance,
    this.onRefresh,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = balance.currentBalance >= 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isPositive
                ? [Colors.green.shade700, Colors.green.shade400]
                : [Colors.red.shade700, Colors.red.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saldo Actual',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (onRefresh != null)
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: onRefresh,
                      tooltip: 'Actualizar saldo',
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_formatCurrency(balance.currency)} ${balance.currentBalance.toStringAsFixed(2)}',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showDetails) ..._buildDetailsSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDetailsSection(ThemeData theme) {
    return [
      const SizedBox(height: 16),
      const Divider(color: Colors.white24),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildMetricTile(
              theme,
              'Ingresos',
              '+${_formatCurrency(balance.currency)} ${balance.income.toStringAsFixed(2)}',
              Icons.arrow_upward,
              Colors.green.shade100,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMetricTile(
              theme,
              'Gastos',
              '-${_formatCurrency(balance.currency)} ${balance.expenses.toStringAsFixed(2)}',
              Icons.arrow_downward,
              Colors.red.shade100,
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildMetricTile(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
    Color iconBackground,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: Colors.black87),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(Currency currency) {
    switch (currency) {
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      case Currency.cop:
        return '\$';
      case Currency.mxn:
        return '\$';
    }
  }

  static Widget fromBalance(Balance balance, {VoidCallback? onRefresh}) {
    return BalanceCard(
      balance: balance,
      onRefresh: onRefresh,
    );
  }
}

class BalanceCardSkeleton extends StatelessWidget {
  const BalanceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class BalanceCardError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const BalanceCardError({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar el saldo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class BalanceCardEmpty extends StatelessWidget {
  final VoidCallback? onAddAccount;

  const BalanceCardEmpty({super.key, this.onAddAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Sin cuenta configurada',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Agrega una cuenta para comenzar a gestionar tus finanzas',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onAddAccount != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onAddAccount,
                icon: const Icon(Icons.add),
                label: const Text('Agregar Cuenta'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/widgets/transaction_list.dart ===
import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(Transaction)? onTransactionTap;
  final ScrollController? scrollController;
  final bool isLoading;
  final String? emptyMessage;
  final VoidCallback? onLoadMore;
  final bool hasMoreData;

  const TransactionList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
    this.scrollController,
    this.isLoading = false,
    this.emptyMessage,
    this.onLoadMore,
    this.hasMoreData = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && transactions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (transactions.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (onLoadMore != null) {
          onLoadMore!();
        }
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: transactions.length + (hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= transactions.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _TransactionListItem(
            transaction: transactions[index],
            onTap: onTransactionTap != null
                ? () => onTransactionTap!(transactions[index])
                : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage ?? 'No hay transacciones',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Las transacciones que realices aparecerán aquí',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const _TransactionListItem({
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? Colors.green : Colors.red;
    final amountPrefix = isIncome ? '+' : '-';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildCategoryIcon(theme),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildCategoryChip(theme),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(transaction.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$amountPrefix\$${transaction.amount.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildStatusChip(theme),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(ThemeData theme) {
    IconData icon;
    Color color;

    switch (transaction.category.toLowerCase()) {
      case 'food':
      case 'comida':
        icon = Icons.restaurant;
        color = Colors.orange;
        break;
      case 'transport':
      case 'transporte':
        icon = Icons.directions_car;
        color = Colors.blue;
        break;
      case 'shopping':
      case 'compras':
        icon = Icons.shopping_bag;
        color = Colors.pink;
        break;
      case 'entertainment':
      case 'entretenimiento':
        icon = Icons.movie;
        color = Colors.purple;
        break;
      case 'bills':
      case 'facturas':
        icon = Icons.receipt;
        color = Colors.red;
        break;
      case 'salary':
      case 'sueldo':
      case 'income':
      case 'ingreso':
        icon = Icons.work;
        color = Colors.green;
        break;
      case 'transfer':
      case 'transferencia':
        icon = Icons.swap_horiz;
        color = Colors.teal;
        break;
      default:
        icon = Icons.attach_money;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildCategoryChip(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        transaction.category,
        style: theme.textTheme.labelSmall,
      ),
    );
  }

  Widget _buildStatusChip(ThemeData theme) {
    Color color;
    String label;

    switch (transaction.status) {
      case TransactionStatus.completed:
        color = Colors.green;
        label = 'Completado';
        break;
      case TransactionStatus.pending:
        color = Colors.orange;
        label = 'Pendiente';
        break;
      case TransactionStatus.failed:
        color = Colors.red;
        label = 'Fallido';
        break;
      case TransactionStatus.cancelled:
        color = Colors.grey;
        label = 'Cancelado';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Hoy';
    } else if (transactionDate == today.subtract(const Duration(days: 1))) {
      return 'Ayer';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class TransactionListSkeleton extends StatelessWidget {
  final int itemCount;

  const TransactionListSkeleton({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 150,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 100,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 16,
                      width: 60,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 50,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TransactionListError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const TransactionListError({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar transacciones',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// === ARCHIVO: test/unit/calculate_balance_usecase_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/calculate_balance_usecase.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  // Superficie de práctica: implementar casos de prueba para CalculateBalanceUseCase
  group('CalculateBalanceUseCase', () {
    late CalculateBalanceUseCase useCase;
    late MockTransactionRepository mockTransactionRepository;
    late MockAccountRepository mockAccountRepository;

    setUp(() {
      mockTransactionRepository = MockTransactionRepository();
      mockAccountRepository = MockAccountRepository();
      useCase = CalculateBalanceUseCase(
        transactionRepository: mockTransactionRepository,
        accountRepository: mockAccountRepository,
      );
    });

    test.skip('Calcula saldo correctamente para cuenta con transacciones positivas', () async {
      // Arrange
      const accountId = 'acc_001';
      final account = Account(
        id: accountId,
        name: 'Cuenta Principal',
        userId: 'user_001',
        initialBalance: 1000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transactions = [
        Transaction(
          id: 'txn_001',
          accountId: accountId,
          amount: 500.0,
          description: 'Depósito',
          date: DateTime(2024, 1, 15),
          category: 'income',
          type: TransactionType.credit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_002',
          accountId: accountId,
          amount: 200.0,
          description: 'Compra',
          date: DateTime(2024, 1, 16),
          category: 'expense',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        ),
      ];

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.getTransactionsByAccount(accountId)).thenAnswer((_) async => transactions);

      // Act
      final result = await useCase.execute(accountId);

      // Assert
      expect(result.currentBalance, equals(1300.0));
      expect(result.income, equals(500.0));
      expect(result.expenses, equals(200.0));
    });

    test.skip('Maneja cuenta sin transacciones correctamente', () async {
      // Arrange
      const accountId = 'acc_002';
      final account = Account(
        id: accountId,
        name: 'Cuenta Vacía',
        userId: 'user_001',
        initialBalance: 500.0,
        currency: Currency.usd,
        type: AccountType.savings,
        createdAt: DateTime(2024, 1, 1),
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.getTransactionsByAccount(accountId)).thenAnswer((_) async => []);

      // Act
      final result = await useCase.execute(accountId);

      // Assert
      expect(result.currentBalance, equals(500.0));
      expect(result.income, equals(0.0));
      expect(result.expenses, equals(0.0));
    });

    test.skip('Calcula saldo con transacciones de ambos tipos', () async {
      // Arrange
      const accountId = 'acc_003';
      final account = Account(
        id: accountId,
        name: 'Cuenta Mixta',
        userId: 'user_001',
        initialBalance: 2000.0,
        currency: Currency.eur,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transactions = [
        Transaction(
          id: 'txn_003',
          accountId: accountId,
          amount: 1000.0,
          description: 'Salario',
          date: DateTime(2024, 1, 1),
          category: 'income',
          type: TransactionType.credit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_004',
          accountId: accountId,
          amount: 150.0,
          description: 'Servicios',
          date: DateTime(2024, 1, 5),
          category: 'expense',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_005',
          accountId: accountId,
          amount: 300.0,
          description: 'Alquiler',
          date: DateTime(2024, 1, 10),
          category: 'expense',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_006',
          accountId: accountId,
          amount: 50.0,
          description: 'Transferencia',
          date: DateTime(2024, 1, 12),
          category: 'transfer',
          type: TransactionType.credit,
          status: TransactionStatus.completed,
        ),
      ];

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.getTransactionsByAccount(accountId)).thenAnswer((_) async => transactions);

      // Act
      final result = await useCase.execute(accountId);

      // Assert
      expect(result.currentBalance, equals(2600.0));
      expect(result.income, equals(1050.0));
      expect(result.expenses, equals(450.0));
    });
  });
}

// === ARCHIVO: test/unit/process_transaction_usecase_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/process_transaction_usecase.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  // Superficie de práctica: implementar casos de prueba para ProcessTransactionUseCase
  group('ProcessTransactionUseCase', () {
    late ProcessTransactionUseCase useCase;
    late MockTransactionRepository mockTransactionRepository;
    late MockAccountRepository mockAccountRepository;

    setUp(() {
      mockTransactionRepository = MockTransactionRepository();
      mockAccountRepository = MockAccountRepository();
      useCase = ProcessTransactionUseCase(
        transactionRepository: mockTransactionRepository,
        accountRepository: mockAccountRepository,
      );
    });

    test.skip('Procesa transacción de crédito exitosamente', () async {
      // Arrange
      const accountId = 'acc_001';
      final account = Account(
        id: accountId,
        name: 'Cuenta Principal',
        userId: 'user_001',
        initialBalance: 1000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_001',
        accountId: accountId,
        amount: 500.0,
        description: 'Depósito',
        date: DateTime.now(),
        category: 'income',
        type: TransactionType.credit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.saveTransaction(transaction)).thenAnswer((_) async => transaction);
      when(mockAccountRepository.updateAccount(any)).thenAnswer((_) async => account);

      // Act
      final result = await useCase.execute(transaction);

      // Assert
      expect(result.status, equals(TransactionStatus.completed));
      verify(mockTransactionRepository.saveTransaction(any)).called(1);
      verify(mockAccountRepository.updateAccount(any)).called(1);
    });

    test.skip('Rechaza transacción de débito por saldo insuficiente', () async {
      // Arrange
      const accountId = 'acc_002';
      final account = Account(
        id: accountId,
        name: 'Cuenta Limitada',
        userId: 'user_001',
        initialBalance: 100.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_002',
        accountId: accountId,
        amount: 500.0,
        description: 'Compra grande',
        date: DateTime.now(),
        category: 'expense',
        type: TransactionType.debit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);

      // Act & Assert
      expect(
        () => useCase.execute(transaction),
        throwsA(isA<Exception>()),
      );
    });

    test.skip('Maneja error de red durante procesamiento', () async {
      // Arrange
      const accountId = 'acc_003';
      final account = Account(
        id: accountId,
        name: 'Cuenta Error',
        userId: 'user_001',
        initialBalance: 2000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_003',
        accountId: accountId,
        amount: 100.0,
        description: 'Transferencia',
        date: DateTime.now(),
        category: 'transfer',
        type: TransactionType.credit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.saveTransaction(transaction)).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => useCase.execute(transaction),
        throwsA(isA<Exception>()),
      );
    });

    test.skip('Marca transacción como fallida en caso de error', () async {
      // Arrange
      const accountId = 'acc_004';
      final account = Account(
        id: accountId,
        name: 'Cuenta Fallida',
        userId: 'user_001',
        initialBalance: 5000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_004',
        accountId: accountId,
        amount: 250.0,
        description: 'Pago',
        date: DateTime.now(),
        category: 'expense',
        type: TransactionType.debit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.saveTransaction(any)).thenThrow(Exception('Database error'));

      // Act & Assert
      try {
        await useCase.execute(transaction);
      } catch (_) {
        // Verify that transaction status is updated to failed
        verifyNever(mockTransactionRepository.updateTransaction(any));
      }
    });
  });
}

// === ARCHIVO: test/unit/transaction_model_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_app/domain/entities/transaction.dart';

void main() {
  // Superficie de práctica: implementar casos de prueba para Transaction
  group('Transaction', () {
    test.skip('Crea transacción válida con todos los campos', () {
      // Arrange & Act
      final transaction = Transaction(
        id: 'txn_001',
        accountId: 'acc_001',
        amount: 150.50,
        description: 'Compra en tienda',
        date: DateTime(2024, 1, 15, 10, 30),
        category: 'shopping',
        type: TransactionType.debit,
        status: TransactionStatus.completed,
      );

      // Assert
      expect(transaction.id, equals('txn_001'));
      expect(transaction.accountId, equals('acc_001'));
      expect(transaction.amount, equals(150.50));
      expect(transaction.description, equals('Compra en tienda'));
      expect(transaction.category, equals('shopping'));
      expect(transaction.type, equals(TransactionType.debit));
      expect(transaction.status, equals(TransactionStatus.completed));
    });

    test.skip('copyWith crea copia con campos modificados', () {
      // Arrange
      final original = Transaction(
        id: 'txn_002',
        accountId: 'acc_001',
        amount: 100.0,
        description: 'Original',
        date: DateTime(2024, 1, 1),
        category: 'test',
        type: TransactionType.credit,
        status: TransactionStatus.pending,
      );

      // Act
      final modified = original.copyWith(
        amount: 200.0,
        status: TransactionStatus.completed,
      );

      // Assert
      expect(modified.id, equals('txn_002'));
      expect(modified.amount, equals(200.0));
      expect(modified.status, equals(TransactionStatus.completed));
      expect(modified.description, equals('Original'));
    });

    test.skip('isValidAmount retorna true para monto positivo', () {
      // Arrange
      final transaction = Transaction(
        id: 'txn_003',
        accountId: 'acc_001',
        amount: 50.0,
        description: 'Válida',
        date: DateTime.now(),
        category: 'test',
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      );

      // Act & Assert
      expect(transaction.isValidAmount(), isTrue);
    });

    test.skip('isValidAmount retorna false para monto cero', () {
      // Arrange
      final transaction = Transaction(
        id: 'txn_004',
        accountId: 'acc_001',
        amount: 0.0,
        description: 'Cero',
        date: DateTime.now(),
        category: 'test',
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      );

      // Act & Assert
      expect(transaction.isValidAmount(), isFalse);
    });

    test.skip('isValidAmount retorna false para monto negativo', () {
      // Arrange
      final transaction = Transaction(
        id: 'txn_005',
        accountId: 'acc_001',
        amount: -50.0,
        description: 'Negativa',
        date: DateTime.now(),
        category: 'test',
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      );

      // Act & Assert
      expect(transaction.isValidAmount(), isFalse);
    });

    test.skip('calculateBalanceImpact retorna monto positivo para crédito', () {
      // Arrange
      final transaction = Transaction(
        id: 'txn_006',
        accountId: 'acc_001',
        amount: 300.0,
        description: 'Crédito',
        date: DateTime.now(),
        category: 'income',
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      );

      // Act & Assert
      expect(transaction.calculateBalanceImpact(), equals(300.0));
    });

    test.skip('calculateBalanceImpact retorna monto negativo para débito', () {
      // Arrange
      final transaction = Transaction(
        id: 'txn_007',
        accountId: 'acc_001',
        amount: 150.0,
        description: 'Débito',
        date: DateTime.now(),
        category: 'expense',
        type: TransactionType.debit,
        status: TransactionStatus.completed,
      );

      // Act & Assert
      expect(transaction.calculateBalanceImpact(), equals(-150.0));
    });

    test.skip('Dos transacciones con mismo contenido son iguales', () {
      // Arrange
      final date = DateTime(2024, 1, 15);
      final transaction1 = Transaction(
        id: 'txn_008',
        accountId: 'acc_001',
        amount: 100.0,
        description: 'Iguales',
        date: date,
        category: 'test',
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      );

      final transaction2 = Transaction(
        id: 'txn_008',
        accountId: 'acc_001',
        amount: 100.0,
        description: 'Iguales',
        date: date,
        category: 'test',
        type: TransactionType.credit,
        status: TransactionStatus.completed,
      );

      // Act & Assert
      expect(transaction1, equals(transaction2));
    });
  });

  group('TransactionType', () {
    test.skip('TransactionType tiene valores correctos', () {
      expect(TransactionType.values.length, equals(2));
      expect(TransactionType.credit.name, equals('credit'));
      expect(TransactionType.debit.name, equals('debit'));
    });
  });

  group('TransactionStatus', () {
    test.skip('TransactionStatus tiene valores correctos', () {
      expect(TransactionStatus.values.length, equals(3));
      expect(TransactionStatus.pending.name, equals('pending'));
      expect(TransactionStatus.completed.name, equals('completed'));
      expect(TransactionStatus.failed.name, equals('failed'));
    });
  });
}

// === ARCHIVO: test/unit/balance_calculation_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';

@GenerateMocks([])
import 'balance_calculation_test.mocks.dart';

void main() {
  late Balance balance;
  late Transaction incomeTransaction;
  late Transaction expenseTransaction;

  setUp(() {
    balance = const Balance(
      id: 'balance-1',
      accountId: 'account-1',
      currentBalance: 1000.0,
      date: DateTime(2024, 1, 1),
      income: 0.0,
      expenses: 0.0,
      currency: Currency.usd,
    );

    incomeTransaction = Transaction(
      id: 'tx-income-1',
      accountId: 'account-1',
      amount: 500.0,
      description: 'Salary deposit',
      date: DateTime(2024, 1, 15),
      category: 'income',
      type: TransactionType.credit,
      status: TransactionStatus.completed,
    );

    expenseTransaction = Transaction(
      id: 'tx-expense-1',
      accountId: 'account-1',
      amount: 250.0,
      description: 'Grocery shopping',
      date: DateTime(2024, 1, 16),
      category: 'food',
      type: TransactionType.debit,
      status: TransactionStatus.completed,
    );
  });

  group('Balance Entity Tests', () {
    test('applyTransaction debe incrementar balance cuando es crédito', () {
      // given: un balance inicial
      // when: se aplica una transacción de crédito
      // then: el balance aumenta
    });

    test('applyTransaction debe decrementar balance cuando es débito', () {
      // given: un balance inicial
      // when: se aplica una transacción de débito
      // then: el balance decrease
    });

    test('canAfford debe retornar true cuando hay fondos suficientes', () {
      // given: un balance con fondos
      // when: se consulta si puede afford cierta cantidad
      // then: retorna true
    });

    test('canAfford debe retornar false cuando fondos son insuficientes', () {
      // given: un balance con fondos limitados
      // when: se consulta si puede afford cantidad mayor
      // then: retorna false
    });

    test('copyWith debe crear nueva instancia con valores actualizados', () {
      // given: un balance
      // when: se usa copyWith para actualizar
      // then: retorna nuevo balance con valores nuevos
    });

    test('applyTransaction debe acumular income correctamente', () {
      // given: balance con transacciones previas
      // when: se aplica transacción de ingreso
      // then: income se acumula
    });

    test('applyTransaction debe acumular expenses correctamente', () {
      // given: balance con transacciones previas
      // when: se aplica transacción de gasto
      // then: expenses se acumula
    });
  });

  group('Balance Calculation Scenarios', () {
    test('múltiples transacciones de crédito incrementan balance', () {
      // given: cuenta con balance inicial
      // when: se procesan múltiples créditos
      // then: balance refleja suma total
    });

    test('múltiples transacciones de débito decrementan balance', () {
      // given: cuenta con balance inicial
      // when: se procesan múltiples débitos
      // then: balance refleja resta total
    });

    test('operación mixta calcula balance neto correctamente', () {
      // given: cuenta con transacciones mixtas
      // when: se calcula balance
      // then: resultado es ingreso menos gasto
    });

    test('transacción con amount cero no modifica balance', () {
      // given: balance existente
      // when: se aplica transacción de cero
      // then: balance permanece igual
    });

    test('transacción negativa debería ser rechazada', () {
      // given: transacción con amount negativo
      // when: se intenta aplicar
      // then: operación falla o balance no cambia
    });
  });

  group('Edge Cases', () {
    test('balance con decimales se calcula correctamente', () {
      // given: transacciones con montos decimales
      // when: se calcula balance
      // then: precisión decimal se mantiene
    });

    test('balance puede ser negativo', () {
      // given: cuenta con sobregiro
      // when: se procesan más gastos
      // then: balance puede ser negativo
    });

    test('valores máximos no causan overflow', () {
      // given: transacciones con valores máximos
      // when: se procesan
      // then: cálculo es correcto
    });
  });
}

// === ARCHIVO: test/bdd/transaction_feature.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';

void main() {
  group('Feature: Gestión de Transacciones', () {
    late Transaction transaction;
    late Account account;
    late Balance balance;

    setUp(() {
      account = const Account(
        id: 'account-123',
        name: 'Cuenta Principal',
        userId: 'user-456',
        initialBalance: 5000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: null,
      );

      balance = const Balance(
        id: 'balance-1',
        accountId: 'account-123',
        currentBalance: 5000.0,
        date: DateTime(2024, 1, 1),
        income: 0.0,
        expenses: 0.0,
        currency: Currency.usd,
      );
    });

    scenario('Crear transacción de ingreso exitosa', () {
      given('un usuario con cuenta activa', () {
        expect(account, isNotNull);
        expect(account.initialBalance, equals(5000.0));
      });

      when('el usuario registra un ingreso de $1500', () {
        transaction = Transaction(
          id: 'tx-001',
          accountId: account.id,
          amount: 1500.0,
          description: 'Pago de freelance',
          date: DateTime.now(),
          category: 'income',
          type: TransactionType.credit,
          status: TransactionStatus.pending,
        );
      });

      then('la transacción se crea con estado pendiente', () {
        expect(transaction.type, equals(TransactionType.credit));
        expect(transaction.status, equals(TransactionStatus.pending));
      });

      and('el monto es válido para procesamiento', () {
        expect(transaction.isValidAmount(), isTrue);
      });
    });

    scenario('Procesar transacción de débito', () {
      given('una cuenta con balance suficiente', () {
        expect(balance.canAfford(1000.0), isTrue);
      });

      when('el usuario realiza un gasto de $800', () {
        transaction = Transaction(
          id: 'tx-002',
          accountId: account.id,
          amount: 800.0,
          description: 'Compra en tienda',
          date: DateTime.now(),
          category: 'shopping',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        );
      });

      then('el impacto en balance es negativo', () {
        expect(transaction.calculateBalanceImpact(), equals(-800.0));
      });
    });

    scenario('Rechazar transacción por fondos insuficientes', () {
      given('una cuenta con balance de $5000', () {
        expect(balance.currentBalance, equals(5000.0));
      });

      when('el usuario intenta gastar $6000', () {
        final canAfford = balance.canAfford(6000.0);
      });

      then('la operación es rechazada', () {
        expect(balance.canAfford(6000.0), isFalse);
      });
    });

    scenario('Actualizar estado de transacción', () {
      given('una transacción en estado pendiente', () {
        transaction = Transaction(
          id: 'tx-003',
          accountId: account.id,
          amount: 300.0,
          description: 'Servicio pendiente',
          date: DateTime.now(),
          category: 'services',
          type: TransactionType.credit,
          status: TransactionStatus.pending,
        );
        expect(transaction.status, equals(TransactionStatus.pending));
      });

      when('el sistema procesa la transacción', () {
        transaction = transaction.copyWith(
          status: TransactionStatus.completed,
        );
      });

      then('el estado cambia a completado', () {
        expect(transaction.status, equals(TransactionStatus.completed));
      });
    });

    scenario('Cancelar transacción', () {
      given('una transacción completada', () {
        transaction = Transaction(
          id: 'tx-004',
          accountId: account.id,
          amount: 250.0,
          description: 'Compra cancelable',
          date: DateTime.now(),
          category: 'shopping',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        );
      });

      when('el usuario cancela la transacción', () {
        transaction = transaction.copyWith(
          status: TransactionStatus.cancelled,
        );
      });

      then('el estado cambia a cancelado', () {
        expect(transaction.status, equals(TransactionStatus.cancelled));
      });
    });
  });

  group('Transacciones con comportamiento específico', () {
    scenario('Transacción de crédito aumenta income del balance', () {
      given('balance con income acumulado', () {
        balance = const Balance(
          id: 'b1',
          accountId: 'a1',
          currentBalance: 1000.0,
          date: DateTime.now(),
          income: 500.0,
          expenses: 200.0,
          currency: Currency.usd,
        );
      });

      when('se aplica transacción de crédito por $300', () {
        final newBalance = balance.applyTransaction(300.0, TransactionType.credit);
      });

      then('income se incrementa', () {
        final result = balance.applyTransaction(300.0, TransactionType.credit);
        expect(result.income, equals(800.0));
      });
    });

    scenario('Transacción de débito aumenta expenses del balance', () {
      given('balance con expenses acumulado', () {
        balance = const Balance(
          id: 'b2',
          accountId: 'a2',
          currentBalance: 1000.0,
          date: DateTime.now(),
          income: 500.0,
          expenses: 200.0,
          currency: Currency.usd,
        );
      });

      when('se aplica transacción de débito por $150', () {
        final newBalance = balance.applyTransaction(150.0, TransactionType.debit);
      });

      then('expenses se incrementa', () {
        final result = balance.applyTransaction(150.0, TransactionType.debit);
        expect(result.expenses, equals(350.0));
      });
    });
  });
}

// === ARCHIVO: test/bdd/account_feature.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';

void main() {
  group('Feature: Gestión de Cuentas', () {
    late Account account;
    late Balance balance;

    setUp(() {
      account = const Account(
        id: 'acc-001',
        name: 'Cuenta de Ahorros',
        userId: 'user-789',
        initialBalance: 10000.0,
        currency: Currency.usd,
        type: AccountType.savings,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: null,
      );

      balance = const Balance(
        id: 'bal-001',
        accountId: 'acc-001',
        currentBalance: 10000.0,
        date: DateTime(2024, 1, 1),
        income: 0.0,
        expenses: 0.0,
        currency: Currency.usd,
      );
    });

    scenario('Crear cuenta con balance inicial válido', () {
      given('datos de nueva cuenta', () {
        expect(account.name, equals('Cuenta de Ahorros'));
        expect(account.initialBalance, equals(10000.0));
      });

      when('el sistema valida la cuenta', () {
        final isValid = account.isValidInitialBalance();
      });

      then('la cuenta es creada exitosamente', () {
        expect(account.isValidInitialBalance(), isTrue);
      });
    });

    scenario('Crear cuenta con balance inicial negativo es rechazado', () {
      given('datos de cuenta con balance negativo', () {
        account = const Account(
          id: 'acc-invalid',
          name: 'Cuenta Inválida',
          userId: 'user-001',
          initialBalance: -500.0,
          currency: Currency.usd,
          type: AccountType.checking,
          createdAt: DateTime.now(),
        );
      });

      when('se valida el balance inicial', () {
        final isValid = account.isValidInitialBalance();
      });

      then('la validación falla', () {
        expect(account.isValidInitialBalance(), isFalse);
      });
    });

    scenario('Actualizar información de cuenta', () {
      given('una cuenta existente', () {
        expect(account.name, equals('Cuenta de Ahorros'));
      });

      when('el usuario actualiza el nombre', () {
        account = account.copyWith(
          name: 'Cuenta de Ahorros Actualizada',
          updatedAt: DateTime.now(),
        );
      });

      then('el nombre se actualiza correctamente', () {
        expect(account.name, equals('Cuenta de Ahorros Actualizada'));
      });

      and('la fecha de actualización se registra', () {
        expect(account.updatedAt, isNotNull);
      });
    });

    scenario('Cambiar tipo de cuenta', () {
      given('una cuenta de tipo savings', () {
        expect(account.type, equals(AccountType.savings));
      });

      when('se cambia a tipo checking', () {
        account = account.copyWith(
          type: AccountType.checking,
          updatedAt: DateTime.now(),
        );
      });

      then('el tipo se actualiza', () {
        expect(account.type, equals(AccountType.checking));
      });
    });

    scenario('Verificar balance disponible para transacción', () {
      given('una cuenta con balance de $10000', () {
        expect(balance.currentBalance, equals(10000.0));
      });

      when('se consulta si puede afford $5000', () {
        final canAfford = balance.canAfford(5000.0);
      });

      then('retorna verdadero', () {
        expect(balance.canAfford(5000.0), isTrue);
      });
    });

    scenario('Verificar fondos insuficientes', () {
      given('una cuenta con balance de $10000', () {
        expect(balance.currentBalance, equals(10000.0));
      });

      when('se consulta si puede afford $15000', () {
        final canAfford = balance.canAfford(15000.0);
      });

      then('retorna falso', () {
        expect(balance.canAfford(15000.0), isFalse);
      });
    });
  });

  group('Cuentas con múltiples monedas', () {
    scenario('Cuenta en dólares tiene moneda correcta', () {
      given('una cuenta en USD', () {
        account = const Account(
          id: 'acc-usd',
          name: 'Cuenta USD',
          userId: 'user-001',
          initialBalance: 1000.0,
          currency: Currency.usd,
          type: AccountType.checking,
          createdAt: DateTime.now(),
        );
      });

      when('se verifica la moneda', () {
        final currency = account.currency;
      });

      then('la moneda es USD', () {
        expect(account.currency, equals(Currency.usd));
      });
    });

    scenario('Cuenta en euros tiene moneda correcta', () {
      given('una cuenta en EUR', () {
        account = const Account(
          id: 'acc-eur',
          name: 'Cuenta EUR',
          userId: 'user-002',
          initialBalance: 2000.0,
          currency: Currency.eur,
          type: AccountType.savings,
          createdAt: DateTime.now(),
        );
      });

      when('se verifica la moneda', () {
        final currency = account.currency;
      });

      then('la moneda es EUR', () {
        expect(account.currency, equals(Currency.eur));
      });
    });

    scenario('Balance refleja la moneda de la cuenta', () {
      given('una cuenta con moneda específica', () {
        balance = const Balance(
          id: 'bal-eur',
          accountId: 'acc-eur',
          currentBalance: 5000.0,
          date: DateTime.now(),
          income: 1000.0,
          expenses: 500.0,
          currency: Currency.eur,
        );
      });

      when('se consulta el balance', () {
        final curr = balance.currency;
      });

      then('la moneda es EUR', () {
        expect(balance.currency, equals(Currency.eur));
      });
    });
  });

  group('Copia inmutable de cuentas', () {
    scenario('copyWith preserva valores no modificados', () {
      given('una cuenta existente', () {
        expect(account.id, equals('acc-001'));
        expect(account.userId, equals('user-789'));
        expect(account.initialBalance, equals(10000.0));
      });

      when('se usa copyWith solo para nombre', () {
        final updated = account.copyWith(name: 'Nuevo Nombre');
      });

      then('otros valores permanecen iguales', () {
        final updated = account.copyWith(name: 'Nuevo Nombre');
        expect(updated.id, equals('acc-001'));
        expect(updated.userId, equals('user-789'));
        expect(updated.initialBalance, equals(10000.0));
      });
    });
  });
}

// === ARCHIVO: test/integration/finance_flow_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/calculate_balance_usecase.dart';
import 'package:finance_app/domain/usecases/process_transaction_usecase.dart';
import 'package:finance_app/domain/usecases/notify_transaction_usecase.dart';

void main() {
  group('Flujo Financiero Completo', () {
    late TransactionRepository transactionRepo;
    late AccountRepository accountRepo;
    late CalculateBalanceUseCase calculateBalance;
    late ProcessTransactionUseCase processTransaction;
    late NotifyTransactionUseCase notifyTransaction;

    setUp(() {
      // STUB: El estudiante debe implementar los mocks reales
      // usando mockito para simular los repositorios y casos de uso
    });

    test('debe procesar una transacción de ingreso correctamente', () {
      // STUB: Escenario given - preparar datos de entrada
      // STUB: When - invocar processTransaction con la transacción
      // STUB: Then - verificar que el balance se actualizó correctamente
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe rechazar transacción con monto inválido', () {
      // STUB: Verificar que se lanza excepción para monto <= 0
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe calcular balance total correctamente', () {
      // STUB: Given - múltiples transacciones en diferentes cuentas
      // STUB: When - calcular balance total
      // STUB: Then - verificar suma correcta de ingresos menos gastos
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe mantener consistencia durante actualización concurrente', () {
      // STUB: Simular múltiples transacciones simultáneas
      // STUB: Verificar que el balance final es consistente
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe notificar transacción procesada', () {
      // STUB: Verificar que se invoca el servicio de notificaciones
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe manejar error de red durante procesamiento', () {
      // STUB: Simular fallo de conexión
      // STUB: Verificar que se maneja el error correctamente
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe validar cuenta existente antes de procesar', () {
      // STUB: Verificar que se valida la cuenta antes de operar
      expect(true, isFalse, reason: 'Implementar este test');
    });

    test('debe aplicar transacción a cuenta específica', () {
      // STUB: Given - cuenta con balance inicial conocido
      // STUB: When - procesar transacción de gasto
      // STUB: Then - verificar que el balance decreased correctamente
      expect(true, isFalse, reason: 'Implementar este test');
    });
  });

  group('Escenarios BDD - Finanzas Personales', () {
    test('Scenario: Usuario registra ingreso exitoso', () {
      // GIVEN: El usuario tiene una cuenta con balance de 1000.00
      // WHEN: El usuario registra un ingreso de 500.00 por concepto de salary
      // THEN: El balance de la cuenta debe ser 1500.00
      // AND: Se debe registrar la transacción con status completed
      expect(true, isFalse, reason: 'Implementar con enfoque BDD');
    });

    test('Scenario: Usuario registra gasto con fondos insuficientes', () {
      // GIVEN: El usuario tiene una cuenta con balance de 100.00
      // WHEN: El usuario intenta registrar un gasto de 200.00
      // THEN: La transacción debe ser rechazada
      // AND: El balance debe permanecer en 100.00
      expect(true, isFalse, reason: 'Implementar con enfoque BDD');
    });

    test('Scenario: Consulta de balance en período específico', () {
      // GIVEN: El usuario tiene transacciones en los últimos 30 días
      // WHEN: El usuario consulta su balance actual
      // THEN: Debe mostrar la suma de ingresos menos gastos del período
      expect(true, isFalse, reason: 'Implementar con enfoque BDD');
    });
  });

  group('Rendimiento y Carga', () {
    test('debe procesar 10000 transacciones en menos de 2 segundos', () {
      // STUB: Medir tiempo de procesamiento de lote grande
      // STUB: Verificar que cumple con el requisito de 200ms por transacción
      expect(true, isFalse, reason: 'Test de carga - implementar');
    });

    test('debe mantener tiempo de respuesta bajo carga concurrente', () {
      // STUB: Simular carga de 10000 transacciones/segundo
      // STUB: Medir latencia promedio
      expect(true, isFalse, reason: 'Test de rendimiento');
    });
  });
}

// === ARCHIVO: README.md ===
# Finance App - Aplicación de Finanzas Personales

Aplicación móvil de finanzas personales desarrollada con Flutter, implementando Clean Architecture y patrones de diseño modernos.

## Características

- Gestión de cuentas financieras
- Registro de transacciones (ingresos/gastos)
- Cálculo de balance en tiempo real
- Notificaciones de transacciones
- Persistencia local con SQLite
- Arquitectura limpia con separación de responsabilidades

## Estructura del Proyecto

```
lib/
├── domain/                 # Capa de dominio (negocio)
│   ├── entities/          # Entidades del negocio
│   ├── repositories/      # Contratos de repositorios
│   └── usecases/          # Casos de uso
├── data/                   # Capa de datos
│   ├── models/            # Modelos de datos
│   ├── repositories/      # Implementaciones de repositorios
│   └── datasources/       # Fuentes de datos
└── presentation/           # Capa de presentación
    ├── screens/           # Pantallas de la app
    ├── viewmodels/        # ViewModels (estado)
    └── widgets/           # Widgets reutilizables

test/
├── unit/                  # Pruebas unitarias
├── integration/           # Pruebas de integración
└── bdd/                   # Pruebas BDD
```

## Requisitos

- Flutter 3.27+
- Dart 3.6+
- Android SDK (para Android)
- Xcode (para iOS)

## Instalación

```bash
# Instalar dependencias
flutter pub get

# Generar código de mocks (si aplica)
flutter pub run build_runner build
```

## Ejecución de Pruebas

### Todas las pruebas
```bash
flutter test
```

### Pruebas unitarias
```bash
flutter test test/unit/
```

### Pruebas de integración
```bash
flutter test test/integration/
```

### Pruebas BDD
```bash
flutter test test/bdd/
```

### Con cobertura
```bash
flutter test --coverage
```

## Construcción

### Debug APK (Android)
```bash
flutter build apk --debug
```

### Release APK (Android)
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios
```

## Dependencias Principales

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| flutter_bloc | 8.1.6 | Gestión de estado |
| provider | 6.1.2 | Inyección de dependencias |
| sqflite | 2.4.1 | Base de datos local |
| http | 1.2.2 | Cliente HTTP |
| equatable | 2.0.7 | Comparación de objetos |
| get_it | 8.0.3 | Localizador de servicios |

## Pruebas

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| flutter_test | sdk | Framework de pruebas |
| mockito | 5.4.4 | Creación de mocks |
| build_runner | 2.4.13 | Generación de código |
| bloc_test | 9.1.7 | Pruebas para BLoC |

## Convenciones de Código

- Entidades inmutables con `copyWith`
- Repository pattern para abstracción de datos
- Provider para gestión de estado reactivo
- Pruebas unitarias con Mockito
- BDD con sintaxis Gherkin en español
- Patrón UseCase para lógica de negocio

## Contribución

1. Fork del repositorio
2. Crear rama feature (`git checkout -b feature/nombre`)
3. Commit de cambios (`git commit -m 'Add feature'`)
4. Push a la rama (`git push origin feature/nombre`)
5. Crear Pull Request
```
