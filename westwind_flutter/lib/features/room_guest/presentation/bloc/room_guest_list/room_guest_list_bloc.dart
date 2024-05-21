import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'room_guest_list_event.dart';
part 'room_guest_list_state.dart';

class RoomGuestListBloc extends Bloc<RoomGuestListEvent, RoomGuestListState> {
  RoomGuestListBloc() : super(RoomGuestListInitial()) {
    on<RoomGuestListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
