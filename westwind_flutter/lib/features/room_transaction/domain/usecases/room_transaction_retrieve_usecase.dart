import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class RetrieveRoomTransactionUseCase implements UseCase<RoomTransaction, RetrieveRoomTransactionParams> {
  final RoomTransactionRepository _repository;

  const RetrieveRoomTransactionUseCase(this._repository);

  @override
  Future<Either<Failure, RoomTransaction>> call(RetrieveRoomTransactionParams params) async {
    return await _repository.retrieve(params.id);
  }
}

class RetrieveRoomTransactionParams {
  final int id;
  const RetrieveRoomTransactionParams({required this.id});
}
