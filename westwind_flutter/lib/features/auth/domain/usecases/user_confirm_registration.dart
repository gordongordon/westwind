import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/auth/domain/repositories/auth_repository.dart';

class UserConfirmRegistrationUseCase
    implements UseCase<User, UserConfirmRegistrationParams> {
  final AuthRepository authRepository;

  const UserConfirmRegistrationUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(
      UserConfirmRegistrationParams params) async {
    final result = await authRepository.comfirmRegistration(
      email: params.email,
      verificationCode: params.verificationCode,
      password: params.password,
    );

    return await result.fold((failure) => left(Failure(failure.message)),
        (user) async {
      return await authRepository.loginWithEmailPassword(
        email: params.email,
        password: params.password,
      );
    });
  }
}

class UserConfirmRegistrationParams {
  final String email;
  final String verificationCode;
  final String password;

  const UserConfirmRegistrationParams({
    required this.email,
    required this.verificationCode,
    required this.password,
  });
}
