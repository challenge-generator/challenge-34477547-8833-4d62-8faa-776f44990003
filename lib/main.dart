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