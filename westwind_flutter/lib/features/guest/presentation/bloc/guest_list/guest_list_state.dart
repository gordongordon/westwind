
import 'package:flutter/foundation.dart';
import 'package:westwind_client/westwind_client.dart';


@immutable
sealed class GuestListState {
  const GuestListState();
}

final class GuestListStateInitial extends GuestListState {}

final class GuestListStateLoading extends GuestListState {}

final class GuestListStateLoaded extends GuestListState {
  final List<Guest> guests;

  const GuestListStateLoaded(this.guests);
}

final class GuestListStateFailure extends GuestListState {
  final String message;

  const GuestListStateFailure( this.message );

}

