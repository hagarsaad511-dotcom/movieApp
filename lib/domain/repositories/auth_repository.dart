import 'package:dartz/dartz.dart';

import '../../ui/core/error/failures';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String lang,
    String? avatar,
  });

  Future<Either<Failure, void>> forgotPassword({required String email}); // Make this abstract


  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? email,
    String? avatar,
  });

  Future<Either<Failure, User?>> getCurrentUser();

  Future<Either<Failure, void>> logout();

  Future<bool> isLoggedIn();
}