import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/room/data/datasources/room_datasource.dart';
import 'package:westwind_flutter/features/room/domain/repositories/room_repository.dart';

class RoomRepositoryImp implements RoomRepository {
  final RoomDatasource datasource;

  RoomRepositoryImp(this.datasource);


  @override
  Future<Either<Failure, List<Room>>> list() async {
    try {
      return right(await datasource.list());
    } on ServerException catch (e)  {
      return left( Failure( e.message ) );
    }
  }

  @override
  Future<Either<Failure, Room>> retrieve(int id) async {
    try {
      return right(await datasource.retrieve(id) );
    } on ServerException catch (e)  {
      return left( Failure( e.message ) );
    }
  }
  
  
}