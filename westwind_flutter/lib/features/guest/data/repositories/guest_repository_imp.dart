import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/guest/data/datasources/guest_datasource.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class GuestRepositoryImp implements GuestRepository {
  final GuestDatasource datasource;

  GuestRepositoryImp(this.datasource);


  @override
  Future<Either<Failure, List<Guest>>> list() async {
    try {
      return right(await datasource.list());
    } on ServerException catch (e)  {
      return left( Failure( e.message ) );
    }
  }

  @override
  Future<Either<Failure, Guest>> retrieve(int id) async {
    try {
      return right(await datasource.retrieve(id) );
    } on ServerException catch (e)  {
      return left( Failure( e.message ) );
    }
  }
   
}