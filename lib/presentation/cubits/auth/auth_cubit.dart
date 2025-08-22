import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/auth_usecases.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  AuthCubit(
      this._loginUseCase,
      this._registerUseCase,
      this._resetPasswordUseCase,
      this._updateProfileUseCase,
      ) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await _loginUseCase(email: email, password: password);

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
  }) async {
    emit(AuthLoading());

    final result = await _registerUseCase(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());

    final result = await _resetPasswordUseCase(email: email);

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> logout() async {
    emit(AuthUnauthenticated());
  }
}
