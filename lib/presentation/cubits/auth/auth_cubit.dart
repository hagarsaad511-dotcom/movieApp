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

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await _loginUseCase.call(
      email: email,
      password: password,
    );
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String lang,
    String? avatar,
    String? phone,
  }) async {
    emit(AuthLoading());
    final result = await _registerUseCase.call(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      lang: lang,
      avatar: avatar,
      phone: phone,
    );
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    final result = await _forgotPasswordUseCase.call(email: email);
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthSuccess('Password reset email sent successfully')),
    );
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatar,
    String? phone,
  }) async {
    emit(AuthLoading());
    final result = await _updateProfileUseCase.call(
      name: name,
      email: email,
      avatar: avatar,
      phone: phone,
    );
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final result = await _getCurrentUserUseCase.call();
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
    final result = await _logoutUseCase.call();
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    final result = await _deleteAccountUseCase.call();
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthUnauthenticated()),
    );
  }
}
