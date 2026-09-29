# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Optimización y aseguramiento de calidad en aplicación móvil**.

| | |
|---|---|
| Tema | Técnicas de pruebas unitarias y fundamentos de perfilamiento de aplicaciones |
| Nivel | advanced-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart / Flutter 3.27 |
| Patron arquitectonico | clean_architecture |
| Tiempo estimado | 20 horas |

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter_test sdk
- mockito 5.4.4
- build_runner 2.4.13
- bloc_test 9.1.7
- flutter_bloc 8.1.6
- provider 6.1.2
- sqflite 2.4.1
- http 1.2.2
- equatable 2.0.7
- get_it 8.0.3

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `flutter pub get && flutter analyze` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `flutter pub get && flutter analyze` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Implementación de pruebas unitarias**: Conjunto de pruebas unitarias que cubren las funciones críticas de la aplicación.
- **Fase 2 — Aplicación de BDD y pruebas funcionales automatizadas**: Conjunto de pruebas funcionales automatizadas basadas en escenarios de BDD.
- **Fase 3 — Análisis de perfilamiento y optimización**: Informe de perfilamiento con propuestas de optimización implementadas.
- **Fase 4 — Integración y verificación final**: Documento final que resume los hallazgos y recomendaciones de todas las fases.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `test/unit/calculate_balance_usecase_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- [ ] `test/unit/process_transaction_usecase_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- [ ] `test/unit/transaction_model_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- [ ] `test/unit/balance_calculation_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- [ ] `test/bdd/transaction_feature.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- [ ] `test/bdd/account_feature.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.
- [ ] `test/integration/finance_flow_test.dart` — El topic pide TDD/pruebas: este archivo es el ejercicio.

## Lo que falta y tenes que completar

### 1. Referencias colgando (10)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `lib/domain/usecases/process_transaction_usecase.dart` — `TransactionRepository.getLatestBalance`
      Se invoca `getLatestBalance` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/domain/usecases/process_transaction_usecase.dart` — `TransactionRepository.saveTransaction`
      Se invoca `saveTransaction` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/domain/usecases/process_transaction_usecase.dart` — `TransactionRepository.updateBalance`
      Se invoca `updateBalance` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/presentation/viewmodels/finance_viewmodel.dart` — `AccountRepository.getAccounts`
      Se invoca `getAccounts` sobre `AccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/calculate_balance_usecase_test.dart` — `MockAccountRepository.getAccount`
      Se invoca `getAccount` sobre `MockAccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/calculate_balance_usecase_test.dart` — `MockTransactionRepository.getTransactionsByAccount`
      Se invoca `getTransactionsByAccount` sobre `MockTransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/process_transaction_usecase_test.dart` — `MockAccountRepository.getAccount`
      Se invoca `getAccount` sobre `MockAccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/process_transaction_usecase_test.dart` — `MockTransactionRepository.saveTransaction`
      Se invoca `saveTransaction` sobre `MockTransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/process_transaction_usecase_test.dart` — `MockAccountRepository.updateAccount`
      Se invoca `updateAccount` sobre `MockAccountRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/process_transaction_usecase_test.dart` — `MockTransactionRepository.updateTransaction`
      Se invoca `updateTransaction` sobre `MockTransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (30)

- `pubspec.yaml`
- `lib/main.dart`
- `lib/domain/entities/transaction.dart`
- `lib/domain/entities/account.dart`
- `lib/domain/entities/balance.dart`
- `lib/domain/repositories/transaction_repository.dart`
- `lib/domain/repositories/account_repository.dart`
- `lib/domain/usecases/calculate_balance_usecase.dart`
- `lib/domain/usecases/process_transaction_usecase.dart`
- `lib/domain/usecases/notify_transaction_usecase.dart`
- `lib/data/models/transaction_model.dart`
- `lib/data/models/account_model.dart`
- `lib/data/repositories/transaction_repository_impl.dart`
- `lib/data/repositories/account_repository_impl.dart`
- `lib/data/datasources/local_transaction_datasource.dart`
- `lib/data/datasources/remote_account_datasource.dart`
- `android/app/src/main/AndroidManifest.xml`
- `lib/presentation/screens/home_screen.dart`
- `lib/presentation/screens/transaction_detail_screen.dart`
- `lib/presentation/viewmodels/finance_viewmodel.dart`
- `lib/presentation/widgets/balance_card.dart`
- `lib/presentation/widgets/transaction_list.dart`
- `test/unit/calculate_balance_usecase_test.dart`
- `test/unit/process_transaction_usecase_test.dart`
- `test/unit/transaction_model_test.dart`
- `test/unit/balance_calculation_test.dart`
- `test/bdd/transaction_feature.dart`
- `test/bdd/account_feature.dart`
- `test/integration/finance_flow_test.dart`
- `README.md`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `lib/domain/entities`
- `lib/domain/repositories`
- `lib/domain/usecases`
- `lib/data/models`
- `lib/data/repositories`
- `lib/data/datasources`
- `lib/presentation/screens`
- `lib/presentation/viewmodels`
- `lib/presentation/widgets`
- `test/unit`
- `test/integration`
- `test/bdd`

## Verificacion

```bash
flutter pub get && flutter analyze
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **clean_architecture**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Advanced
- Brecha que el reto ataca: Implementa pruebas unitarias en lenguaje nativo, usa pruebas funcionales automatizadas, explica BDD, interpreta perfilamiento (profiler) de apps, comprende la importancia de servicios virtualizados
- Mision: Candidato con experiencia avanzada en desarrollo móvil con Flutter, trabajando en equipo distribuido

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
