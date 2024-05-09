part of 'guest_manage_bloc.dart';

@immutable
sealed class GuestManageEvent {}

final class GuestManageRetrieveEvent extends GuestManageEvent {
  final int id;

  GuestManageRetrieveEvent( {required this.id });

}

final class GuestManageSaveEvent extends GuestManageEvent {
  final Guest guest;

  GuestManageSaveEvent( {required this.guest });
}

final class GuestManageDeleteEvent extends GuestManageEvent {
  final int id;

  GuestManageDeleteEvent( {required this.id });
}
