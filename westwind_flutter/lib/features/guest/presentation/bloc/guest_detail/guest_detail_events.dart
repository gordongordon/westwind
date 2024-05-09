
import 'package:flutter/foundation.dart';

@immutable
sealed class GuestDetailEvent {}

final class FetchGuestRetrieveEvent extends GuestDetailEvent {
  final int id;

  FetchGuestRetrieveEvent( {required  this.id } );
}



