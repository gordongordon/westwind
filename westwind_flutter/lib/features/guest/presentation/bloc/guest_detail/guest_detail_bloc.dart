import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_state.dart';


class GuestDetailBloc extends Bloc<GuestDetailEvent, GuestDetailState> {
  final RetrieveGuestUseCase retrieveGuest;

  GuestDetailBloc({required this.retrieveGuest}) : super(GuestDetailtateInitial()) {
    on<GuestDetailEvent>((_, emit) => emit(GuestDetailStateLoading()));
    on<FetchGuestRetrieveEvent>((_onFetchGuest));
  }

  // Note Selected FetchGuestEvent in order to get the id.
  Future<void> _onFetchGuest(
      FetchGuestRetrieveEvent event, Emitter<GuestDetailState> emit) async {
    final result = await retrieveGuest(RetrieveGuestParams(id: event.id ));

    print(result);

    result.fold(
      (failure) => emit(GuestDetailStateFailure(failure.message)),
      (guest) => emit( GuestDetailStateLoaded(guest)),
    );
  }
}


