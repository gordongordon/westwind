


import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class GuestRepository {
   Future<Either<Failure,List<Guest>>> list();
   Future<Either<Failure, Guest>> retrieve(int id);
}