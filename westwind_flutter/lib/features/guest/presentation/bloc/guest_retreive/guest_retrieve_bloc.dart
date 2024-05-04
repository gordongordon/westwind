import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_retreive/guest_retrieve_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_retreive/guest_retrieve_state.dart';


class GuestRetrieveBloc extends Bloc<GuestRetrieveEvent, GuestRetrieveState> {
  final RetrieveGuestUseCase retrieveGuest;

  GuestRetrieveBloc({required this.retrieveGuest}) : super(GuestRetrieveStateInitial()) {
    on<GuestRetrieveEvent>((_, emit) => emit(GuestRetrieveStateLoading()));
    on<FetchGuestEvent>((_onFetchGuest));
  }

  // Note Selected FetchGuestEvent in order to get the id.
  Future<void> _onFetchGuest(
      FetchGuestEvent event, Emitter<GuestRetrieveState> emit) async {
    final result = await retrieveGuest(RetrieveGuestParams(id: event.id ));

    print(result);

    result.fold(
      (failure) => emit(GuestRetrieveStateFailure(failure.message)),
      (guest) => emit( GuestRetrieveStateLoaded(guest)),
    );
  }
}


