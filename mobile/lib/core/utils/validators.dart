class Validators {
  Validators._();

  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    if (!v.contains('@')) return 'Invalid email';
    return null;
  }

  static String? number(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    if (double.tryParse(v) == null) return 'Invalid number';
    return null;
  }

  static String? positiveInt(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = int.tryParse(v);
    if (n == null || n <= 0) return 'Must be positive integer';
    return null;
  }
}
