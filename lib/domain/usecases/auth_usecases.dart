import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/local_datasource.dart';
import '../../data/models/auth_models.dart';
import '../../ui/core/error/failures.dart';
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
    required String confirmPassword,
    required String lang,
    required int avatarId,
    required String phone,
  }) async {
    return await repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      lang: lang,
      avatarId: avatarId,
      phone: phone,
    );
  }
}
@injectable
class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await repository.resetPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}

@injectable
class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, User>> call({
    String? name,
    String? email,
    int? avatarId,
    String? phone,
  }) async {
    return await repository.updateProfile(
      name: name,
      email: email,
      avatarId: avatarId,
      phone: phone,
    );
  }
}
@injectable
class GoogleLoginUseCase {
  final AuthRepository repository;
  final LocalDataSource localDataSource; // ✅ add LocalDataSource

  GoogleLoginUseCase(this.repository, this.localDataSource);

  Future<Either<Failure, User>> call({required String idToken}) {
    return repository.loginWithGoogle(idToken: idToken);
  }

  /// ✅ Helper for Firebase-only mode:
  /// Allows AuthCubit to persist a Firebase user locally.
  Future<void> saveLocalUser(UserModel user) async {
    await localDataSource.saveUser(user);
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

@injectable
class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.deleteAccount();
  }
}
