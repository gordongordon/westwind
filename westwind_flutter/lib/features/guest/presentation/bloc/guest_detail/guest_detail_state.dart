
import 'package:flutter/foundation.dart';
import 'package:westwind_client/westwind_client.dart';


@immutable
sealed class GuestDetailState {
  const GuestDetailState();
}

final class GuestDetailtateInitial extends GuestDetailState {}

final class GuestDetailStateLoading extends GuestDetailState {}

final class GuestDetailStateLoaded extends GuestDetailState {
  final Guest guest;

  const GuestDetailStateLoaded(this.guest);
}

final class GuestDetailStateFailure extends GuestDetailState {
  final String message;

  const GuestDetailStateFailure( this.message );

}
