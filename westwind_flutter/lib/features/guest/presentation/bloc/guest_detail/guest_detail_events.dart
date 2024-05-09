
import 'package:flutter/foundation.dart';

@immutable
sealed class GuestDetailEvent {}

final class FetchGuestEvent extends GuestDetailEvent {
  final int id;

  FetchGuestEvent( {required  this.id } );
}



