import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class CreateRoomTransactionUseCase implements UseCase<RoomTransaction, CreateRoomTransactionParams> {
  final RoomTransactionRepository _repository;

  const CreateRoomTransactionUseCase(this._repository);

  @override
  Future<Either<Failure, RoomTransaction>> call(CreateRoomTransactionParams params) async {
    return await _repository.create(params.roomTransaction);
  }
}

class CreateRoomTransactionParams {
  final RoomTransaction roomTransaction;
  const CreateRoomTransactionParams({required this.roomTransaction});
}
