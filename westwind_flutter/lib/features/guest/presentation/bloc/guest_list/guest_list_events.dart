

import 'package:flutter/foundation.dart';
import 'package:westwind_client/westwind_client.dart';

@immutable
sealed class GuestListEvent {}

final class FetchGuestsEvent extends GuestListEvent {}

final class DeleteGuestEvent extends GuestListEvent {
  final int id;

  DeleteGuestEvent( {required  this.id } );
}



