import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/auth/domain/repositories/auth_repository.dart';

class CurrentUserUseCase implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  const CurrentUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return authRepository.currentUser();
  }
}