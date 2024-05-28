import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/room_guest/data/datasources/room_guest_datasource.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class RoomGuestRepositoryImpl implements RoomGuestRepository {
  final RoomGuestDatasource roomGuestDatasource;

  RoomGuestRepositoryImpl(this.roomGuestDatasource);

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      return Right(await roomGuestDatasource.delete(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> hasRoomate(int roomId) async {
    try {
      return Right(await roomGuestDatasource.hasRoomate(roomId));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> list() async {
    try {
      return Right(await roomGuestDatasource.list());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomGuest>> retrieve(int id) async {
    try {
      return Right(await roomGuestDatasource.retrieve(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> retrieveByRoomId(int roomId) async {
    try {
      return Right(await roomGuestDatasource.retrieveByRoomId(roomId));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomGuest>> save(
      {required RoomGuest roomGuest}) async {
    try {
      return Right(await roomGuestDatasource.save(roomGuest));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomGuest>> checkIn({
    required RoomGuest checkInRoomGuest,
    required List<RoomGuest> roommates,
    required Reservation reservation,
  }) async {
    try {
      return Right(
        await roomGuestDatasource.checkInRoomGuest(
            checkInRoomGuest: checkInRoomGuest,
            roommates: roommates,
            reservation: reservation ),
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
