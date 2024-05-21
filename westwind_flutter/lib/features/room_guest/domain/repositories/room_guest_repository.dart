


import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class RoomGuestRepository {

   Future<Either<Failure,List<RoomGuest>>> list();
   Future<Either<Failure,RoomGuest>> save({required RoomGuest roomGuest});
   Future<Either<Failure,bool>> delete(int id);
   Future<Either<Failure,RoomGuest>> retrieve( int id);
   Future<Either<Failure,bool>> hasRoomate( int roomId );
   Future<Either<Failure,List<RoomGuest>>> retrieveByRoomId( int roomId );
   Future<Either<Failure,RoomGuest>> checkIn({required RoomGuest checkInRoomGuest, required List<RoomGuest> roommates, required Reservation reservation,});
}