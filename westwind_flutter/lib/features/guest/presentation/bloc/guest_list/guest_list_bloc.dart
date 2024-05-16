import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/delete_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/list_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_state.dart';

class GuestListBloc extends Bloc<GuestListEvent, GuestListState> {
  final ListGuestsUseCase listGuests;
  final DeleteGuestUseCase deleteGuest;


  GuestListBloc({required this.listGuests, required this.deleteGuest})
      : super(GuestListStateInitial()) {
    on<GuestListEvent>((_, emit) => emit(GuestListStateLoading()));
    on<FetchGuestsEvent>((_onFetchGuests));
    on<DeleteGuestEvent>((_onDeleteGuest));
  
  }




  Future<void> _onFetchGuests(
      GuestListEvent event, Emitter<GuestListState> emit) async {

        emit( GuestListStateLoading());
    final result = await listGuests(NoParams());

    // print(result);

    result.fold(
      (failure) => emit(GuestListStateFailure(failure.message)),
      (guests) {
        //     emit(GuestListStateLoading());
        emit(GuestListStateLoaded(guests));
      },
    );
  }

  Future<void> _onDeleteGuest(
      DeleteGuestEvent event, Emitter<GuestListState> emit) async {
                emit( GuestListStateLoading());
    final isDelete = await deleteGuest(DeleteGuestParams(id: event.id));
    final result = await listGuests(NoParams());

    print(isDelete);

    isDelete.fold(
      (failure) => emit(GuestListStateFailure(failure.message)),
      (r) {
        result.fold(
          (failure) => emit(GuestListStateFailure(failure.message)),
          (guests) {
            emit(GuestListStateLoaded(guests));
          },
        );
      },
    );
  }

}
