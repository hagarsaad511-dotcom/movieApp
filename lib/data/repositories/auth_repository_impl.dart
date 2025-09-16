import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../ui/core/error/failures.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/local_datasource.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final SharedPreferences sharedPreferences;
  final InternetConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.remoteDataSource,
      this.localDataSource, {
        required this.sharedPreferences,
        required this.connectionChecker,
      });

  String _extractMessage(dynamic error) {
    // If remoteDataSource throws Exception('Failed to register: { ... }'), trim it
    if (error is Exception) {
      final msg = error.toString();
      return msg.replaceFirst('Exception: ', '');
    }
    return error?.toString() ?? 'Unknown error';
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final request = LoginRequest(email: email, password: password);
      print("📤 Login request: ${request.toJson()}");

      final response = await remoteDataSource.login(request);
      print("✅ Login response: ${response.toJson()}");

      // Save token only (backend doesn’t send user object here)
      await localDataSource.saveAuthToken(response.token);

      // Since backend doesn’t give user data on login,
      // just return a placeholder user with email.
      final user = User(
        id: '',
        // no user id from backend
        name: '',
        // not provided
        email: email,
        avatarId: null,
        phone: null,
      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String lang,
    required int avatarId,
    required String phone,
  }) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        lang: lang,
        avatarId: avatarId,
        phone: phone,
      );
      print("📤 Register request: ${request.toJson()}");

      // Backend returns: { message: "...", data: { ...user... } }
      final response = await remoteDataSource.register(request);
      print("✅ Register response: ${response.toJson()}");

      final userModel = response.data;
      if (userModel == null) {
        return Left(
            ServerFailure('Registration succeeded but no user returned'));
      }

      // Backend does NOT send token on register — only user data.
      // Save only the user locally so 'getCurrentUser' can read it.
      await localDataSource.saveUser(userModel);

      // Return the mapped domain User
      return Right(_mapUserModelToUser(userModel));
    } catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      await remoteDataSource.resetPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    }
  }


  @override
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? email,
    int? avatarId,
    String? phone,
  }) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final request = UpdateProfileRequest(
        name: name,
        email: email,
        avatarId: avatarId,
        phone: phone,
      );
      print("📤 UpdateProfile request: ${request.toJson()}");

      final updatedUser = await remoteDataSource.updateProfile(request);
      print("✅ UpdateProfile response: ${updatedUser.toJson()}");

      await localDataSource.saveUser(updatedUser);

      return Right(_mapUserModelToUser(updatedUser));
    } catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    }
  }
  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("✅ ForgotPassword: reset email sent to $email");
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to send reset email"));
    } catch (e) {
      return Left(ServerFailure("Forgot password error: $e"));
    }
  }

  User _mapUserModelToUser(UserModel model) {
    return User(
      id: model.id,
      name: model.name,
      email: model.email,
      avatarId: model.avatarId,
      phone: model.phone,
      createdAt: model.createdAt != null
          ? DateTime.tryParse(model.createdAt!)
          : null,
      updatedAt: model.updatedAt != null
          ? DateTime.tryParse(model.updatedAt!)
          : null,
    );
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getUser();
      if (userModel == null) {
        print("ℹ️ getCurrentUser: no user cached");
        return const Right(null);
      }

      print("ℹ️ getCurrentUser: ${userModel.toJson()}");

      // ✅ Detect Firebase-only user
      final isFirebaseUser = userModel.avatarId == null &&
          (userModel.createdAt != null && userModel.createdAt!.isNotEmpty);

      if (isFirebaseUser) {
        print("ℹ️ Detected Firebase user (no avatarId, has createdAt)");
        final user = User(
          id: userModel.id,
          name: userModel.name,
          email: userModel.email,
          avatarId: null,
          phone: userModel.phone,
          createdAt: userModel.createdAt != null
              ? DateTime.tryParse(userModel.createdAt!)
              : DateTime.now(),
          updatedAt: userModel.updatedAt != null
              ? DateTime.tryParse(userModel.updatedAt!)
              : DateTime.now(),
        );
        return Right(user);
      }

      // ✅ Default: backend user flow
      return Right(_mapUserModelToUser(userModel));
    } catch (e) {
      return Left(CacheFailure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuthData();
      print("✅ Logout: local auth data cleared");
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(_extractMessage(e)));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await localDataSource.getAuthToken();
    print("ℹ️ isLoggedIn: token=${token != null && token.isNotEmpty}");
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    if (!await connectionChecker.hasConnection) {
      await localDataSource.clearAuthData();
      print("⚠️ DeleteAccount: no connection, cleared local only");
      return const Right(null);
    }
    try {
      await remoteDataSource.deleteAccount();
      print("✅ DeleteAccount response: success");

      await localDataSource.clearAuthData();
      return const Right(null);
    } catch (e) {
      await localDataSource.clearAuthData();
      return Left(ServerFailure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle(
      {required String idToken}) async {
    try {
      // Use FirebaseAuth to get the current user
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        return Left(ServerFailure("No Firebase user found"));
      }

      // ✅ Map Firebase user → UserModel
      final userModel = UserModel.fromFirebase(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? "",
        displayName: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL,
      );

      // Save locally so getCurrentUser() works after restart
      await localDataSource.saveUser(userModel);

      // Map → domain User
      final user = User.fromFirebase(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? "",
        displayName: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL,
      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure("Google login failed: $e"));
    }
  }
}
