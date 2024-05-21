

import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/rate_table/data/datasources/rate_table_datasource.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';

class RateTableRepositoryImpl implements RateTableRepository {
   
   final RateTableDatasource rateTableDatasource;

   RateTableRepositoryImpl( this.rateTableDatasource );

  @override
  Future<Either<Failure, double>> getRate( RateType type, RateReason reason) async {
    
      try {
         return right( await rateTableDatasource.getRate( type,  reason));
      } on ServerException catch (e) {
         return left( Failure(e.message ));
      }
   
  }
  
  @override
  Future<Either<Failure, double>> getShareRate(RateType type) async {
      try {
         return right( await rateTableDatasource.getShareRate( type ));
      } on ServerException catch (e) {
         return left( Failure(e.message ));
      }
  }
  
  @override
  Future<Either<Failure, double>> getSingleRate(RateType type) async {
      try {
         return right( await rateTableDatasource.getSingleRate( type ));
      } on ServerException catch (e) {
         return left( Failure(e.message ));
      }
  }

  
  
}