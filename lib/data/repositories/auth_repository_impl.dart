import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../ui/core/error/failures';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/local_datasource.dart';
import '../models/auth_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final SharedPreferences sharedPreferences;
  final InternetConnectionChecker connectionChecker;

  AuthRepositoryImpl(
      this.remoteDataSource,
      this.localDataSource, {
        required this.sharedPreferences,
        required this.connectionChecker,
      });

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
      final response = await remoteDataSource.login(request);

      // Save token and user locally
      await localDataSource.saveAuthToken(response.token);
      await localDataSource.saveUser(response.user);

      return Right(_mapUserModelToUser(response.user));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String lang,
    String? avatar,
    String? phone,
  }) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        lang: lang,
        avatar: avatar,
        phone: phone,
      );

      final response = await remoteDataSource.register(request);

      // Persist auth token & user locally
      await localDataSource.saveAuthToken(response.token);
      await localDataSource.saveUser(response.user);

      return Right(_mapUserModelToUser(response.user));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final request = ForgotPasswordRequest(email: email);
      await remoteDataSource.forgotPassword(request);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? email,
    String? avatar,
    String? phone,
  }) async {
    if (!await connectionChecker.hasConnection) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final request = UpdateProfileRequest(
        name: name,
        email: email,
        avatar: avatar,
        phone: phone,
      );
      final updatedUser = await remoteDataSource.updateProfile(request);

      // Update local user data
      await localDataSource.saveUser(updatedUser);

      return Right(_mapUserModelToUser(updatedUser));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Mapper from UserModel → domain User
  User _mapUserModelToUser(UserModel model) {
    return User(
      id: model.id,
      name: model.name,
      email: model.email,
      avatar: model.avatar,
      phone: model.phone,
    );
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getUser();
      if (userModel == null) {
        return const Right(null);
      }
      return Right(_mapUserModelToUser(userModel));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuthData();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await localDataSource.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    if (!await connectionChecker.hasConnection) {
      // Fallback for dev/demo mode — clear local user
      await localDataSource.clearAuthData();
      return const Right(null);
    }
    try {
      await remoteDataSource.deleteAccount();
      await localDataSource.clearAuthData();
      return const Right(null);
    } catch (e) {
      // In dev, clear local even if API fails
      await localDataSource.clearAuthData();
      return Left(ServerFailure('Failed to delete account: $e'));
    }
  }
}
