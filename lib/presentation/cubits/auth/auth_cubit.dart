import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth_usecases.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  AuthCubit(
      this._loginUseCase,
      this._registerUseCase,
      this._forgotPasswordUseCase,
      this._updateProfileUseCase,
      this._getCurrentUserUseCase,
      this._logoutUseCase,
      this._deleteAccountUseCase,
      ) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _loginUseCase(email: email, password: password);

    result.fold(
          (failure) {
        print("❌ Login failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (user) {
        print("✅ Login success: ${user.email}, ID: ${user.id}");
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String lang,
    required int avatarId,
    required String phone,
  }) async {
    emit(AuthLoading());

    final result = await _registerUseCase(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      lang: lang,
      avatarId: avatarId,
      phone: phone,
    );

    result.fold(
          (failure) {
        print("❌ Register failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (user) {
        print("✅ Register success: ${user.email}, ID: ${user.id}");
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    final result = await _forgotPasswordUseCase(email: email);
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthSuccess('Password reset email sent successfully')),
    );
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    int? avatarId,
    String? phone,
  }) async {
    emit(AuthLoading());
    final result = await _updateProfileUseCase(
      name: name,
      email: email,
      avatarId: avatarId,
      phone: phone,
    );

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final result = await _getCurrentUserUseCase();
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) {
        if (user == null) {
          emit(AuthUnauthenticated());
        } else {
          emit(AuthAuthenticated(user));
        }
      },
    );
  }

  Future<void> logout() async {
    final result = await _logoutUseCase();
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    final result = await _deleteAccountUseCase();
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthUnauthenticated()),
    );
  }
}
