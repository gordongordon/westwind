
import 'package:flutter/foundation.dart';

@immutable
sealed class GuestDetailEvent {}

final class GuestDetailRetrieveEvent extends GuestDetailEvent {
  final int id;

  GuestDetailRetrieveEvent( {required  this.id } );
}



