import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Either<Failure,User> currentUser();

  Future<Either<Failure, void>> logout();
}
