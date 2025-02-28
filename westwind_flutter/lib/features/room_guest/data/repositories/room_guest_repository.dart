import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
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
      // When fetching from server
      final response = await roomGuestDatasource.list();

      final result = response.map(_fromServer).toList();

      return Right(result);

      //    return Right(await roomGuestDatasource.list());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> listButCheckOut() async {
    try {
      final response = await roomGuestDatasource.listButCheckOut();

      final result = response.map(_fromServer).toList();

      return Right(result);

      //   return Right(await roomGuestDatasource.listButCheckOut());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

    @override
  Future<Either<Failure, List<RoomGuest>>> listButCheckIn() async {
    try {
      final response = await roomGuestDatasource.listButCheckIn();

      final result = response.map(_fromServer).toList();

      return Right(result);

      //   return Right(await roomGuestDatasource.listButCheckOut());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomGuest>> retrieve(int id) async {
    try {
      final data = await roomGuestDatasource.retrieve(id);

      final result = _fromServer(data);

      return Right(result);

      //   return Right(await roomGuestDatasource.retrieve(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> retrieveByRoomId(int roomId) async {
    try {
      final response = await roomGuestDatasource.retrieveByRoomId(roomId);

      final result = response.map(_fromServer).toList();

      return Right(result);

      // return Right(await roomGuestDatasource.retrieveByRoomId(roomId));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomGuest>> save(
      {required RoomGuest roomGuest}) async {
    try {
      //   final data = roomGuest;

      final result = _toServer(roomGuest);

      return Right(await roomGuestDatasource.save(result));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomGuest>> checkIn({
    required RoomGuest checkInRoomGuest,
//    required List<RoomGuest> roommates,
    required Reservation reservation,
  }) async {
    try {
      final dataCheckInRoomGuest = _toServer(checkInRoomGuest);

      //! not sure the time ?
      //! reservation may need to toServer
      return Right(
        await roomGuestDatasource.checkInRoomGuest(
            checkInRoomGuest: dataCheckInRoomGuest,
            //      roommates: roommates,
            reservation: reservation),
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> update(
      {required List<RoomGuest> roomGuests}) async {
    try {
      final result = roomGuests.map(_toServer).toList();

      return Right(await roomGuestDatasource.update(roomGuests: result));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> retrieveRoommatesSameStayDayById(
      int roomGuestId) async {
    try {
      final response = await roomGuestDatasource
          .retrieveRoommatesSameStayDayById(roomGuestId);

      final result = response.map(_fromServer).toList();

      //     return Right(await roomGuestDatasource
      //       .retrieveRoommatesSameStayDayById(roomGuestId));
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>>
      retrieveRoommatesSameStayDayWithOutGoHomeById(int roomGuestId) async {
    try {
      final response = await roomGuestDatasource
          .retrieveRoommatesSameStayDayWithOutGoHomeById(roomGuestId);

      final result = response.map(_fromServer).toList();

      return Right(result);
      //    return Right(await roomGuestDatasource
      //       .retrieveRoommatesSameStayDayWithOutGoHomeById(roomGuestId));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> updateRateSameStayDayByReasonAndId(
      int roomGuestId, RateReason reason, double rate) async {
    try {
      return Right(await roomGuestDatasource.updateRateSameStayDayByReasonAndId(
          roomGuestId, reason, rate));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  RoomGuest _toServer(RoomGuest data) {
    return RoomGuest(
      id: data.id,
      roomTransactions: data.roomTransactions,
      roomId: data.roomId,
      stayDay: TimeManager.instance.toServer(data.stayDay),
      reservation: data.reservation,
      updateDate: data.updateDate != null
          ? TimeManager.instance.toServer(data.updateDate!)
          : null,
      guest: data.guest,
      guestId: data.guestId,
      rateType: data.rateType,
      rateReason: data.rateReason,
      rate: data.rate,
      reservationId: data.reservationId,
      roomStatus: data.roomStatus,
      checkInDate: TimeManager.instance.toServer(data.checkInDate),
      checkOutDate: TimeManager.instance.toServer(data.checkOutDate),
      isCheckOut: data.isCheckOut,
      note: data.note,
    );
  }

  RoomGuest _fromServer(RoomGuest data) {
    return RoomGuest(
      id: data.id,
      roomTransactions: data.roomTransactions,
      roomId: data.roomId,
      stayDay: TimeManager.instance.fromServer(data.stayDay),
      reservation: data.reservation,
      updateDate: data.updateDate != null
          ? TimeManager.instance.fromServer(data.updateDate!)
          : null,
      guest: data.guest,
      guestId: data.guestId,
      rateType: data.rateType,
      rateReason: data.rateReason,
      rate: data.rate,
      reservationId: data.reservationId,
      roomStatus: data.roomStatus,
      checkInDate: TimeManager.instance.fromServer(data.checkInDate),
      checkOutDate: TimeManager.instance.fromServer(data.checkOutDate),
      isCheckOut: data.isCheckOut,
      note: data.note,
    );
  }

  @override
  Future<Either<Failure, RoomGuest?>> updateNote(
      {required int roomGuestId, required String note}) async {
    try {
      return Right(await roomGuestDatasource.updateNote(
          roomGuestId: roomGuestId, note: note));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> findRoomGuestsForWindow(
      DateTime startDate, DateTime endDate) async {
    try {
      // When fetching from server
      final response = await roomGuestDatasource.findRoomGuestsForWindow(
        TimeManager.instance.toServer(startDate),
        TimeManager.instance.toServer(endDate),
      );

      final result = response.map(_fromServer).toList();

      return Right(result);

      //    return Right(await roomGuestDatasource.list());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
