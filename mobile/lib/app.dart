import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/core/di/injection.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/theme/app_theme.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

import 'package:mobile/core/storage/token_storage.dart';

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/sales/presentation/bloc/sale_bloc.dart';
import 'features/sales/domain/repositories/sale_repository.dart';
import 'features/expenses/presentation/bloc/expense_bloc.dart';
import 'features/expenses/domain/repositories/expense_repository.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/data/dashboard_repository.dart';
import 'features/reports/presentation/bloc/report_bloc.dart';
import 'features/reports/data/report_repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ValueNotifier<AuthState> _authNotifier;
  late final AuthBloc _authBloc;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authNotifier = ValueNotifier<AuthState>(AuthInitial());
    _authBloc = AuthBloc(
      repository: sl<AuthRepository>(),
      tokenStorage: sl<TokenStorage>(),
    );
    _authBloc.stream.listen((s) => _authNotifier.value = s);
    _authBloc.add(AuthCheckRequested());
    _router = createRouter(_authNotifier);
  }

  @override
  void dispose() {
    _authBloc.close();
    _authNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(repository: sl<ProductRepository>()),
        ),
        BlocProvider<SaleBloc>(
          create: (_) => SaleBloc(repository: sl<SaleRepository>()),
        ),
        BlocProvider<ExpenseBloc>(
          create: (_) => ExpenseBloc(repository: sl<ExpenseRepository>()),
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => DashboardBloc(repository: sl<DashboardRepository>()),
        ),
        BlocProvider<ReportBloc>(
          create: (_) => ReportBloc(repository: sl<ReportRepository>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Daily Sales',
        theme: AppTheme.light(),
        routerConfig: _router,
      ),
    );
  }
}
