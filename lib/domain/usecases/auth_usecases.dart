import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../ui/core/error/failures';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
@injectable
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String lang,
    String? avatar,
  }) async {
    return await repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      lang: lang,
      avatar: avatar,
    );
  }
}
@injectable
class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
  }) async {
    return await repository.forgotPassword(email: email);
  }
}

@injectable
class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, User>> call({
    String? name,
    String? email,
    String? avatar,
  }) async {
    return await repository.updateProfile(
      name: name,
      email: email,
      avatar: avatar,
    );
  }
}

@injectable
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
}

@injectable
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}

@injectable
class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}