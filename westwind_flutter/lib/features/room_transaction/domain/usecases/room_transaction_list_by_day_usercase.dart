import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class ListRoomTransactionsByDayUseCase implements UseCase<List<RoomTransaction>, ListRoomTransactionsByDayParams> {
  final RoomTransactionRepository _repository;

  const ListRoomTransactionsByDayUseCase(this._repository);

  @override
  Future<Either<Failure, List<RoomTransaction>>> call(ListRoomTransactionsByDayParams params) async {
    return await _repository.listByDay(params.day);
  }
}


class ListRoomTransactionsByDayParams {
  final DateTime day;

  const ListRoomTransactionsByDayParams({required this.day});
}