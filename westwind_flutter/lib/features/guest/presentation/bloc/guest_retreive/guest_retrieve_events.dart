
import 'package:flutter/foundation.dart';

@immutable
sealed class GuestRetrieveEvent {}

final class FetchGuestEvent extends GuestRetrieveEvent {
  final int id;

  FetchGuestEvent( {required  this.id } );
}



