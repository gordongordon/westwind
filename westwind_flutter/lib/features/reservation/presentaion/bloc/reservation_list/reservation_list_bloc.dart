import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/list_reservation.dart';

part 'reservation_list_event.dart';
part 'reservation_list_state.dart';

class ReservationListBloc
    extends Bloc<ReservationListEvent, ReservationListState> {
  final ListReservationUseCase listReservations;

  ReservationListBloc({required this.listReservations})
      : super(ReservationListStateInitial()) {
    on<ReservationListEvent>((event, emit) {
      emit(ReservationListStateLoading());
    });
    on<FetchReservationsEvent>((_onFetchReservations));
    //   on<RetrieveGuestForReservationEvent>((_onRetrieveGuestForReservation));
  }



  Future<void> _onFetchReservations(
      FetchReservationsEvent event, Emitter<ReservationListState> emit) async {
    emit(ReservationListStateLoading());
       await Future.delayed(Duration(seconds: 1));
    final result = await listReservations(NoParams());

    result.fold(
      (failure) => emit(ReservationListStateFailure(message: failure.message)),
      (reservations) =>
          emit(ReservationListStateLoaded(reservations: reservations)),
    );

    return;
  }
}
