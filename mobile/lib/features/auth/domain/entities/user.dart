class User {
  final String id;
  final String email;
  final String name;
  final String? businessName;
  final String? phone;
  final String? address;
  final String currency;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.businessName,
    this.phone,
    this.address,
    required this.currency,
  });
}
