
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';

class RateTableGetRateUseCase
    implements UseCase<double, RateTableGetRateParams> {
  final RateTableRepository rateTableRepository;

  RateTableGetRateUseCase( this.rateTableRepository);

  @override
  Future<Either<Failure, double>> call(RateTableGetRateParams params ) async {
    return  await rateTableRepository.getRate(
         params.type, params.reason);  
  }
}

class RateTableGetRateParams {
  final RateType type;
  final RateReason reason;

  RateTableGetRateParams({required this.type, required this.reason});
}
