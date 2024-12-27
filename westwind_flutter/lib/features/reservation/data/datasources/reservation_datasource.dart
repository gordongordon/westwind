import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class ReservationDatasource {
  Future<List<Reservation>> list();
  Future<List<Reservation>> listButCanceled();
  Future<List<Reservation>> listButCanceledAndCheckIn();
  Future<Reservation> retrieve(int id);
  Future<bool> delete(int id);
  Future<Reservation> save(Reservation reservation);
  Future<bool> checkIn(int id);
}

class ReservationDatasourceImp implements ReservationDatasource {
  final Client client;

  const ReservationDatasourceImp(this.client);

  @override
  Future<bool> delete(id) async {

    try {
        final result = await client.reservation.delete(id);

        if ( result == false ) {
          throw ServerException("Reservation with $id can't be deleted");
        }
        return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Reservation>> list() async {
    try {
      return await client.reservation.list();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

    @override
  Future<List<Reservation>> listButCanceled() async {
    try {
      return await client.reservation.listButCanceled();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

    @override
  Future<List<Reservation>> listButCanceledAndCheckIn() async {
    try {
      return await client.reservation.listButCanceledAndCheckIn();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Reservation> retrieve(int id) async {
     try {
         final result = await client.reservation.retrieve( id: id );
         if ( result == null) {
            throw ServerException("Reservation with $id can't be retrieved! ");
         }
         
         return result;

     } catch (e) {
      throw ServerException(e.toString());
     }
  }

  @override
  Future<Reservation> save(Reservation reservation) async {
    try {
         final result =  await client.reservation.save(reservation);

         if ( result.id == null ) {
            throw ServerException("Reservation can't be saved! ");
         }

         return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<bool> checkIn(int id)async {
      try {
    //      final result = await client.reservation.checkInReservation(reservationId: id);
          final result = await client.reservation.checkIn(reservationId: id);
          if ( result == false ) {
            throw ServerException("Reservation with $id can't be checked in! ");
          }
          return result;
      } catch (e) {
        throw ServerException(e.toString());
      }
  }
}
