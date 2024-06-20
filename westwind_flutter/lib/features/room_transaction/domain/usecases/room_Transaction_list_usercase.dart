import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class ListRoomTransactionsUseCase implements UseCase<List<RoomTransaction>, NoParams> {
  final RoomTransactionRepository _repository;

  const ListRoomTransactionsUseCase(this._repository);

  @override
  Future<Either<Failure, List<RoomTransaction>>> call(NoParams params) async {
    return await _repository.list();
  }
}
