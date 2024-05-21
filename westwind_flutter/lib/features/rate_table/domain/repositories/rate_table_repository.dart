

import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class RateTableRepository {
   
   Future<Either<Failure, double>> getRate( RateType type, RateReason reason );
   Future<Either<Failure, double>> getSingleRate( RateType type );
   Future<Either<Failure, double>> getShareRate( RateType typpe );

}