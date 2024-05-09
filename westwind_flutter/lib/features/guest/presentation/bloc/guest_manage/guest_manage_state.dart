part of 'guest_manage_bloc.dart';

@immutable
sealed class GuestManageState {}

final class GuestManageStateInitial extends GuestManageState {}

final class GuestManageStateLoading extends GuestManageState {}

final class GuestManageStateRetrieveSuccess extends GuestManageState {
  final Guest guest;

  GuestManageStateRetrieveSuccess({required this.guest});
}

final class GuestManageStateFailure extends GuestManageState {
  final String message;

  GuestManageStateFailure({required this.message});
}

final class GuestManageStateRetrieveSaveSuccess extends GuestManageState {
  final Guest guest;

  GuestManageStateRetrieveSaveSuccess({required this.guest});
}

final class GuestManageStateDeleteSuccess extends GuestManageState {}
