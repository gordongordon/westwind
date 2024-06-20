import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class DeleteRoomTransactionUseCase implements UseCase<bool, DeleteRoomTransactionParams> {
  final RoomTransactionRepository _repository;

  const DeleteRoomTransactionUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(DeleteRoomTransactionParams params) async {
    return await _repository.delete(params.id);
  }
}

class DeleteRoomTransactionParams {
  final int id;
  const DeleteRoomTransactionParams({required this.id});
}
