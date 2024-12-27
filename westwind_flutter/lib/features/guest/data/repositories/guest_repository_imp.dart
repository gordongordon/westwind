import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/dashboard/util/responsive.dart';
import 'package:westwind_flutter/features/guest/data/datasources/guest_datasource.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class GuestRepositoryImp implements GuestRepository {
  final GuestDatasource datasource;

  GuestRepositoryImp(this.datasource);

  @override
  Future<Either<Failure, List<Guest>>> list() async {
    try {
      final response = await datasource.list();

      final result = response.map(_fromServer).toList();

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Guest>> retrieve(int id) async {
    try {
      //  return right(await datasource.retrieve(id));

      final response = await datasource.retrieve(id);

      final result = _fromServer(response);

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      return right(await datasource.delete(id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Guest>> save(Guest guest) async {
    try {
      final result = _toServer(guest);

      return right(await datasource.save(result));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Guest>> retrieveByPhone(String phone) async {
    try {
      final response = await datasource.retrieveByPhone(phone);

      final result = _fromServer(response);

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Guest _toServer(Guest data) {
    return Guest(
      id: data.id,
      email: data.email,
      dateUpdate: data.dateUpdate != null
          ? TimeManager.instance.toServer(data.dateCreate)
          : null,
      roomGuets: data.roomGuets,
      rigNumber: data.rigNumber,
      company: data.company,
      firstName: data.firstName,
      lastName: data.lastName,
      phone: data.phone,
      isInHouse: data.isInHouse,
      dateCreate: TimeManager.instance.toServer(data.dateCreate),
      rateType: data.rateType,
      staffId: data.staffId,
      companyId: data.companyId,
      accountBalance: data.accountBalance,
    );
  }

  Guest _fromServer(Guest data) {
    return Guest(
      id: data.id,
      email: data.email,
      dateUpdate: data.dateUpdate != null
          ? TimeManager.instance.fromServer(data.dateCreate)
          : null,
      roomGuets: data.roomGuets,
      rigNumber: data.rigNumber,
      company: data.company,
      firstName: data.firstName,
      lastName: data.lastName,
      phone: data.phone,
      isInHouse: data.isInHouse,
      dateCreate: TimeManager.instance.fromServer(data.dateCreate),
      rateType: data.rateType,
      staffId: data.staffId,
      companyId: data.companyId,
      accountBalance: data.accountBalance,
    );
  }
}
