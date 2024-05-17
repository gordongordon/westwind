part of 'guest_manage_bloc.dart';

@immutable
sealed class GuestManageState {}

final class GuestManageStateInitial extends GuestManageState {}

final class GuestManageStateLoading extends GuestManageState {}

final class GuestManageStateRetrieveSuccess extends GuestManageState {
  final Guest guest;

  GuestManageStateRetrieveSuccess({required this.guest});
}

final class GuestManageStateRetrieveByPhoneSuccess extends GuestManageState {
  final Guest guest;

  GuestManageStateRetrieveByPhoneSuccess({required this.guest});
}

final class GuestManageStateFailure extends GuestManageState {
  final String message;

  GuestManageStateFailure( this.message );
}

final class GuestManageStateSaveSuccess extends GuestManageState {
  final Guest guest;

  GuestManageStateSaveSuccess({required this.guest});
}

final class GuestManageStateDeleteSuccess extends GuestManageState {}
