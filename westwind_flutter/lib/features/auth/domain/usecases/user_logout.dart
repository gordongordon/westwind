import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/auth/domain/repositories/auth_repository.dart';

class UserLogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  const UserLogoutUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}