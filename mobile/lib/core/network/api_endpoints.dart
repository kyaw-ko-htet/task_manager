class ApiEndpoints {
  ApiEndpoints._();

  static const authRegister = '/auth/register';
  static const authLogin = '/auth/login';
  static const authMe = '/auth/me';
  static const authProfile = '/auth/profile';

  static const products = '/products';
  static String product(String id) => '/products/$id';

  static const sales = '/sales';
  static String sale(String id) => '/sales/$id';

  static const expenses = '/expenses';
  static String expense(String id) => '/expenses/$id';

  static const dashboardSummary = '/dashboard/summary';

  static const reportsSales = '/reports/sales';
  static const reportsExpenses = '/reports/expenses';
  static const reportsSummary = '/reports/summary';
}
