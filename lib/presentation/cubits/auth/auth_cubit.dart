import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/auth_usecases.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase; // Add this
  final UpdateProfileUseCase _updateProfileUseCase;

  AuthCubit(
      this._loginUseCase,
      this._registerUseCase,
      this._forgotPasswordUseCase, // Add this parameter
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
    required String lang,
    String? avatar,
  }) async {
    emit(AuthLoading());

    final result = await _registerUseCase(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      lang: lang,
      avatar: avatar,
    );

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
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

  Future<void> logout() async {
    emit(AuthUnauthenticated());
  }
}