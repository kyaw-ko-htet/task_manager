import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:my_pocky/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_pocky/features/auth/presentation/pages/login_page.dart';
import 'package:my_pocky/features/auth/presentation/pages/register_page.dart';
import 'package:my_pocky/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:my_pocky/features/products/presentation/pages/products_page.dart';
import 'package:my_pocky/features/products/presentation/pages/product_form_page.dart';
import 'package:my_pocky/features/sales/presentation/pages/sales_page.dart';
import 'package:my_pocky/features/sales/presentation/pages/sale_create_page.dart';
import 'package:my_pocky/features/sales/presentation/pages/sale_detail_page.dart';
import 'package:my_pocky/features/expenses/presentation/pages/expenses_page.dart';
import 'package:my_pocky/features/reports/presentation/pages/reports_page.dart';
import 'package:my_pocky/features/settings/presentation/pages/settings_page.dart';

GoRouter createRouter(ValueNotifier<AuthState> authNotifier) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = authNotifier.value;
      final loggedIn = authState is AuthAuthenticated;
      final loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';
      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterPage()),
      GoRoute(path: '/', builder: (_, _) => const DashboardPage()),
      GoRoute(path: '/products', builder: (_, _) => const ProductsPage()),
      GoRoute(path: '/products/form', builder: (_, _) => const ProductFormPage()),
      GoRoute(path: '/products/:id', builder: (_, state) => ProductFormPage(id: state.pathParameters['id'])),
      GoRoute(path: '/sales', builder: (_, _) => const SalesPage()),
      GoRoute(path: '/sales/new', builder: (_, _) => const SaleCreatePage()),
      GoRoute(path: '/sales/:id', builder: (_, state) => SaleDetailPage(id: state.pathParameters['id']!)),
      GoRoute(path: '/expenses', builder: (_, _) => const ExpensesPage()),
      GoRoute(path: '/reports', builder: (_, _) => const ReportsPage()),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsPage()),
    ],
  );
}
