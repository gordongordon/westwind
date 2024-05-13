
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';

import 'package:westwind_flutter/features/reservation/domain/usecases/delete_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/retrieve_guest_for_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/retrieve_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/save_reservation.dart';

part 'reservation_manage_event.dart';
part 'reservation_manage_state.dart';

class ReservationManageBloc
    extends Bloc<ReservationManageEvent, ReservationManageState> {
  final RetrieveReservationUseCase retrieveReservation;
  final SaveReservationUseCase saveReservation;
  final DeleteReservationUseCase deleteReservation;
  final RetrieveGuestForReservationUseCase retrieveGuestForReservation;

  ReservationManageBloc({
    required this.retrieveReservation,
    required this.saveReservation,
    required this.deleteReservation,
    required this.retrieveGuestForReservation,
  }) : super(ReservationManageStateInitial()) {
    on<ReservationManageEvent>((event, emit) {
      emit(ReservationManageStateInitial());
    });
    on<RetrieveReservation>((_onRetrieveReservation));
    on<SaveReservation>((_onSaveReservation));
    on<DeleteReservation>((_onDeleteReservation));
    on<RetrieveGuestForReservation>((_onRetrieveGuestForReservation));
  }

  Future<void> _onRetrieveReservation(
      RetrieveReservation event, Emitter<ReservationManageState> emit) async {
    final result =
        await retrieveReservation(RetrieveReservationParams(id: event.id));

    result.fold(
      (failure) => emit(ReservationManageStateFailure(failure.message)),
      (reservation) => emit(ReservationManageStateRetrieveSuccess(reservation)),
    );
  }

  Future<void> _onSaveReservation(
      SaveReservation event, Emitter<ReservationManageState> emit) async {
    final result = await saveReservation(
        SaveReservationParams(reservation: event.reservation));

    result.fold(
      (failure) => emit(ReservationManageStateFailure(failure.message)),
      (reservation) => emit(ReservationManageStateSaveSuccess(reservation)),
    );
  }

  Future<void> _onDeleteReservation(
      DeleteReservation event, Emitter<ReservationManageState> emit) async {
    final result =
        await deleteReservation(DeleteReservationParams(id: event.id));

    result.fold(
      (failure) => emit(ReservationManageStateFailure(failure.message)),
      (_) => emit(ReservationManageStateDeleteSuccess()),
    );
  }

    Future<void> _onRetrieveGuestForReservation(
      RetrieveGuestForReservation event, Emitter<ReservationManageState> emit) async {
    final result =
        await retrieveGuestForReservation(RetrieveGuestForReservationParams(id: event.id));

    result.fold(
      (failure) => emit(ReservationManageStateFailure(failure.message)),
      (guest) => emit(ReservationManageStateRetrieveGuestSuccess(guest)),
    );
  }
}
