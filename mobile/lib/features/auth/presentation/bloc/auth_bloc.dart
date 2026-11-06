import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/auth/domain/entities/user.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/core/storage/token_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final TokenStorage tokenStorage;

  AuthBloc({required this.repository, required this.tokenStorage})
    : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheck);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthProfileUpdateRequested>(_onProfileUpdate);
  }

  Future<void> _onCheck(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final token = await tokenStorage.getToken();
    if (token == null) {
      emit(AuthUnauthenticated());
      return;
    }
    try {
      final user = await repository.getProfile();
      emit(AuthAuthenticated(user));
    } catch (_) {
      await tokenStorage.clear();
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.login(email: event.email, password: event.password);
      final user = await repository.getProfile();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.register(
        email: event.email,
        password: event.password,
        name: event.name,
        businessName: event.businessName,
      );
      final user = await repository.getProfile();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onProfileUpdate(
    AuthProfileUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    final current = state;
    if (current is AuthAuthenticated) {
      emit(AuthLoading());
      try {
        final user = await repository.updateProfile(event.data);
        emit(AuthAuthenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthAuthenticated(current.user));
      }
    }
  }
}
