
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class ListGuestsUseCase implements UseCase<List<Guest>,NoParams> {
  final GuestRepository guestRepository;

  const ListGuestsUseCase(this.guestRepository);

  @override
  Future<Either<Failure, List<Guest>>> call(NoParams params) async {
     return await guestRepository.list();
  }

}