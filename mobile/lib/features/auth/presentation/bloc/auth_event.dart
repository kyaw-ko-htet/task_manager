part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String? businessName;
  AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    this.businessName,
  });
}

class AuthLogoutRequested extends AuthEvent {}

class AuthProfileUpdateRequested extends AuthEvent {
  final Map<String, dynamic> data;
  AuthProfileUpdateRequested(this.data);
}
