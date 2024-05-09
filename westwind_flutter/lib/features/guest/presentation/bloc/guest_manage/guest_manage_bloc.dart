import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

  GuestManageBloc({required this.retrieveGuest, required this.saveGuest, required this.deleteGuest  }) : super(GuestManageStateInitial()) {
    on<GuestManageEvent>((event, emit) => emit( GuestManageStateLoading()));
    on<GuestManageSaveEvent>((event, emit) => emit( GuestManageStateRetrieveSaveSuccess(guest: event.guest)));
  }
}
