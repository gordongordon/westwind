
import 'package:flutter/foundation.dart';
import 'package:westwind_client/westwind_client.dart';


@immutable
sealed class GuestDetailState {
  const GuestDetailState();
}

final class GuestRetrieveStateInitial extends GuestDetailState {}

final class GuestRetrieveStateLoading extends GuestDetailState {}

final class GuestRetrieveStateLoaded extends GuestDetailState {
  final Guest guest;

  const GuestRetrieveStateLoaded(this.guest);
}

final class GuestRetrieveStateFailure extends GuestDetailState {
  final String message;

  const GuestRetrieveStateFailure( this.message );

}
