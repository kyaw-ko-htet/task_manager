import 'package:my_pocky/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.businessName,
    super.phone,
    super.address,
    required super.currency,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        businessName: json['businessName'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        currency: (json['currency'] as String?) ?? 'USD',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'businessName': businessName,
        'phone': phone,
        'address': address,
        'currency': currency,
      };
}
