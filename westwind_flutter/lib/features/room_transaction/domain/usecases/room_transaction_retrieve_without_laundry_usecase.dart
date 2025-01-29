import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class RetrieveRoomTransactionWithOutLaundryUseCase implements UseCase<List<RoomTransaction>, RetrieveRoomTransactionWithOutLaundryParams> {
  final RoomTransactionRepository _repository;

  const RetrieveRoomTransactionWithOutLaundryUseCase(this._repository);

  @override
  Future<Either<Failure, List<RoomTransaction>>> call(RetrieveRoomTransactionWithOutLaundryParams params) async {
    return await _repository.getTransactionsForRoomGuestWithOutLaundry(params.id);
  }
}

class RetrieveRoomTransactionWithOutLaundryParams {
  final int id;
  const RetrieveRoomTransactionWithOutLaundryParams({required this.id});
}
