import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class RoomRepository {
   Future<Either<Failure, List<Room>>> list();
   Future<Either<Failure, Room>> retrieve(int id);
}

