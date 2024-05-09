import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/delete_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/save_guest.dart';

part 'guest_manage_event.dart';
part 'guest_manage_state.dart';

class GuestManageBloc extends Bloc<GuestManageEvent, GuestManageState> {
  final RetrieveGuestUseCase retrieveGuest;
  final SaveGuestUseCase saveGuest;
  final DeleteGuestUseCase deleteGuest;

  GuestManageBloc({
    required this.retrieveGuest,
    required this.saveGuest,
    required this.deleteGuest,
  }) : super(GuestManageStateInitial()) {
    on<GuestManageEvent>((event, emit) => emit(GuestManageStateLoading()));
    on<GuestManageRetrieveEvent>((_onRetrieveGuest));
    on<GuestManageSaveEvent>((_onSaveGuest));
    on<GuestManageDeleteEvent>((_onDeleteGuest));
  }

  FutureOr<void> _onRetrieveGuest(
      GuestManageRetrieveEvent event, Emitter<GuestManageState> emit) async {
    final result = await retrieveGuest(RetrieveGuestParams(id: event.id));

       print(result);
       print( "onRetrieveEvent");

    result.fold((failure) => emit(GuestManageStateFailure(failure.message)),
        (guest) => emit(GuestManageStateRetrieveSuccess(guest: guest)));

  }

  FutureOr<void> _onSaveGuest(
      GuestManageSaveEvent event, Emitter<GuestManageState> emit) async {
    final result = await saveGuest(SaveGuestParams(guest: event.guest));

    result.fold((failure) => emit(GuestManageStateFailure(failure.message)),
        (guest) => emit(GuestManageStateSaveSuccess(guest: guest)));
  }

  FutureOr<void> _onDeleteGuest(
      GuestManageDeleteEvent event, Emitter<GuestManageState> emit) async {
    final isDelete = await deleteGuest(DeleteGuestParams(id: event.id));

    // print(isDelete);

    isDelete.fold(
      (failure) => emit(GuestManageStateFailure(failure.message)),
      (_) => emit(GuestManageStateDeleteSuccess()),
    );
  }
}
