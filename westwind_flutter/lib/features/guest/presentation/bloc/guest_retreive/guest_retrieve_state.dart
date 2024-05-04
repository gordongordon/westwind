
import 'package:flutter/foundation.dart';
import 'package:westwind_client/westwind_client.dart';


@immutable
sealed class GuestRetrieveState {
  const GuestRetrieveState();
}

final class GuestRetrieveStateInitial extends GuestRetrieveState {}

final class GuestRetrieveStateLoading extends GuestRetrieveState {}

final class GuestRetrieveStateLoaded extends GuestRetrieveState {
  final Guest guest;

  const GuestRetrieveStateLoaded(this.guest);
}

final class GuestRetrieveStateFailure extends GuestRetrieveState {
  final String message;

  const GuestRetrieveStateFailure( this.message );

}
