import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class RateTableDatasource {
  Future<double> getRate(RateType type, RateReason reason);
  Future<double> getSingleRate(RateType type );
  Future<double> getShareRate(RateType type );
}

class RateTableDatasourceImpl implements RateTableDatasource {
  final Client client;

  RateTableDatasourceImpl(this.client);

  @override
  Future<double> getRate(RateType type, RateReason reason) async {
    try {
      final result =
          await client.rateTable.findRate(rateType: type, rateReason: reason);

      if (result == null) {
        throw ServerException(
            "Rate can't be finded base on type of $type and reason of $reason");
      }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<double> getShareRate(RateType type ) async {
    try {
      final result =
          await client.rateTable.findRate(rateType: type, rateReason: RateReason.double );

      if (result == null) {
        throw ServerException(
            "Rate can't be finded base on type of $type and reason of double"); 
      }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<double> getSingleRate(RateType type ) async {
    try {
      final result =
          await client.rateTable.findRate(rateType: type, rateReason: RateReason.single );

      if (result == null) {
        throw ServerException(
            "Rate can't be finded base on type of $type and reason of single");
      }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
