
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/auth/data/datasources/auth_datasource.dart';
import 'package:westwind_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource dataSource;

  const AuthRepositoryImp(this.dataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final result = await dataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Either<Failure, User> currentUser() {
    final user = dataSource.currentUser();

    if (user == null) {
      return left(const Failure("user not looged in "));
    }

    return right(user);
  }

  @override
  Future<Either<Failure, bool>> registerWithEmailPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final result = await dataSource.registerWithEmailPassword(
        email: email,
        password: password,
        username: username,
      );

      if (result == false) {
        throw ServerException("Can't register a user");
      }

      return right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> comfirmRegistration({
    required String email,
    required String verificationCode,
    required String password,
  }) async {
    try {
      final user = await dataSource.comfirmRegistration(
        email: email,
        verificationCode: verificationCode,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await dataSource.logout();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
