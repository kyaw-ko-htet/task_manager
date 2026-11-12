import 'package:get_it/get_it.dart';
import 'package:my_pocky/core/storage/token_storage.dart';
import 'package:my_pocky/core/network/dio_client.dart';

import 'package:my_pocky/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_pocky/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_pocky/features/products/data/repositories/product_repository_impl.dart';
import 'package:my_pocky/features/products/domain/repositories/product_repository.dart';
import 'package:my_pocky/features/sales/data/repositories/sale_repository_impl.dart';
import 'package:my_pocky/features/sales/domain/repositories/sale_repository.dart';
import 'package:my_pocky/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:my_pocky/features/expenses/domain/repositories/expense_repository.dart';
import 'package:my_pocky/features/dashboard/data/dashboard_repository.dart';
import 'package:my_pocky/features/reports/data/report_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<DioClient>(() => DioClient(tokenStorage: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dioClient: sl(), tokenStorage: sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(dioClient: sl()));
  sl.registerLazySingleton<SaleRepository>(() => SaleRepositoryImpl(dioClient: sl()));
  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl(dioClient: sl()));
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepository(dioClient: sl()));
  sl.registerLazySingleton<ReportRepository>(() => ReportRepository(dioClient: sl()));
}
