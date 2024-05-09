import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class AuthRepository {

  Either<Failure,User> currentUser();

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> registerWithEmailPassword({
    required String email,
    required String password,
    required String username,
  });

  Future<Either<Failure,User>> comfirmRegistration({
    required String email,
    required String verificationCode,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}
