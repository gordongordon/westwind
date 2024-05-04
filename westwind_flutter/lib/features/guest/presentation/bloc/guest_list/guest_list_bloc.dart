import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/list_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_state.dart';

class GuestListBloc extends Bloc<GuestListEvent, GuestListState> {
  final ListGuestsUseCase listGuests;

  GuestListBloc({required this.listGuests}) : super(GuestListStateInitial()) {
    on<GuestListEvent>((_, emit) => emit(GuestListStateLoading()));
    on<FetchGuestEvent>((_onFetchGuests));
  }

  Future<void> _onFetchGuests(
      GuestListEvent event, Emitter<GuestListState> emit) async {
    final result = await listGuests(NoParams());

    print(result);

    result.fold(
      (failure) => emit(GuestListStateFailure(failure.message)),
      (guests) => emit( GuestListStateLoaded(guests)),
    );
  }
}
