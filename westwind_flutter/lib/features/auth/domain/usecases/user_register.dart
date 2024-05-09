
import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/auth/domain/repositories/auth_repository.dart';

class UserRegisterUseCase implements UseCase<bool, UserRegisterParams> {
  final AuthRepository authRepository;

  const UserRegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(UserRegisterParams params) async {
    return await authRepository.registerWithEmailPassword(
      email: params.email,
      password: params.password,
      username: params.username,
    );
  }
}

class UserRegisterParams {
  final String email;
  final String password;
  final String username;

  const UserRegisterParams({
    required this.email,
    required this.password,
    required this.username,
  });
}
