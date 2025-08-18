import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import 'package:movie_app/lib/ui/core/error/failures';

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
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? email,
    String? avatar,
  });

  Future<Either<Failure, User?>> getCurrentUser();

  Future<Either<Failure, void>> logout();

  Future<bool> isLoggedIn();
}