import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/auth_models.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth_usecases.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase; // ✅ new
  final UpdateProfileUseCase _updateProfileUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  AuthCubit(
      this._loginUseCase,
      this._registerUseCase,
      this._resetPasswordUseCase, // ✅ inject
      this._updateProfileUseCase,
      this._getCurrentUserUseCase,
      this._logoutUseCase,
      this._deleteAccountUseCase,
      this._googleLoginUseCase,
      ) : super(AuthInitial());

  // helper for logging transitions
  void _logState(AuthState state) {
    print("🔄 AuthCubit → ${state.runtimeType}");
  }

  @override
  void emit(AuthState state) {
    _logState(state);
    super.emit(state);
  }

  // -------------------------------
  // 🔑 Auth methods
  // -------------------------------

  Future<void> login({required String email, required String password}) async {
    print("📤 AuthCubit → login request: {email: $email, password: ******}");
    emit(AuthLoading());

    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthAuthenticated(user)),
    );
  }


Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(AuthError("Google sign-in cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCred.user;

      if (firebaseUser != null) {
        final user = User.fromFirebase(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          displayName: firebaseUser.displayName,
          phoneNumber: firebaseUser.phoneNumber,
          photoUrl: firebaseUser.photoURL,
        );

        // ✅ Save Firebase user locally so getCurrentUser works after restart
        final userModel = UserModel.fromFirebase(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          displayName: firebaseUser.displayName,
          phoneNumber: firebaseUser.phoneNumber,
          photoUrl: firebaseUser.photoURL,
        );
        await _googleLoginUseCase.saveLocalUser(userModel);

        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Google sign-in failed"));
      }
    } catch (e) {
      emit(AuthError("Google sign-in error: $e"));
    }
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
    print("📤 AuthCubit → register request: {"
        "name: $name, email: $email, password: ******, "
        "password_confirmation: ******, lang: $lang, avatarId: $avatarId, phone: $phone}");

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
        print("✅ Register success response: ${jsonEncode(user.toJson())}");
        // ⚠️ backend doesn’t log in user, so don’t emit AuthAuthenticated
        emit(AuthSuccess('Account created successfully for ${user.email}'));
      },
    );
  }


  /// ✅ NEW: Reset password
  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    print("📤 AuthCubit → resetPassword request: {oldPassword: ******, newPassword: ******}");
    emit(AuthLoading());

    final result = await _resetPasswordUseCase(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    result.fold(
          (failure) {
        print("❌ ResetPassword failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (_) {
        print("✅ ResetPassword success");
        emit(AuthSuccess("Password reset successfully"));
      },
    );
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    int? avatarId,
    String? phone,
  }) async {
    print("📤 AuthCubit → updateProfile request: "
        "{name: $name, email: $email, avatarId: $avatarId, phone: $phone}");
    emit(AuthLoading());

    final result = await _updateProfileUseCase(
      name: name,
      email: email,
      avatarId: avatarId,
      phone: phone,
    );

    result.fold(
          (failure) {
        print("❌ UpdateProfile failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (user) {
        print("✅ UpdateProfile success response: ${jsonEncode(user.toJson())}");
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> getCurrentUser() async {
    print("📤 AuthCubit → getCurrentUser request");
    emit(AuthLoading());

    final result = await _getCurrentUserUseCase();
    result.fold(
          (failure) {
        print("❌ getCurrentUser failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (user) {
        if (user == null) {
          print("ℹ️ No current user found → AuthUnauthenticated");
          emit(AuthUnauthenticated());
        } else {
          print("✅ getCurrentUser success response: ${jsonEncode(user.toJson())}");
          emit(AuthAuthenticated(user));
        }
      },
    );
  }

  Future<void> logout() async {
    print("📤 AuthCubit → logout request");
    final result = await _logoutUseCase();
    result.fold(
          (failure) {
        print("❌ Logout failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (_) {
        print("✅ Logout success → AuthUnauthenticated");
        emit(AuthUnauthenticated());
      },
    );
  }

  Future<void> deleteAccount() async {
    print("📤 AuthCubit → deleteAccount request");
    emit(AuthLoading());

    final result = await _deleteAccountUseCase();
    result.fold(
          (failure) {
        print("❌ DeleteAccount failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (_) {
        print("✅ DeleteAccount success → AuthUnauthenticated");
        emit(AuthUnauthenticated());
      },
    );
  }
}
