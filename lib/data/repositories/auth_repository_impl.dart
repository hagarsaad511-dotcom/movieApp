import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../ui/core/error/failures';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/local_datasource.dart';
import '../models/auth_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
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
  }) async {
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      final response = await remoteDataSource.register(request);

      // Save token and user locally
      await localDataSource.saveAuthToken(response.token);
      await localDataSource.saveUser(response.user);

      return Right(_mapUserModelToUser(response.user));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
  }) async {
    try {
      final request = ResetPasswordRequest(email: email);
      await remoteDataSource.resetPassword(request);
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
  }) async {
    try {
      final request = UpdateProfileRequest(
        name: name,
        email: email,
        avatar: avatar,
      );
      final updatedUser = await remoteDataSource.updateProfile(request);

      // Update local user data
      await localDataSource.saveUser(updatedUser);

      return Right(_mapUserModelToUser(updatedUser));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getUser();
      if (userModel != null) {
        return Right(_mapUserModelToUser(userModel));
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.removeAuthToken();
      await localDataSource.removeUser();
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

  User _mapUserModelToUser(UserModel userModel) {
    return User(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
      avatar: userModel.avatar,
    );
  }
}