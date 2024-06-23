// guest_policy.dart
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';


abstract interface class RoomGuestPolicy {
  bool canChargeGuest(RoomGuest guest);
  bool canGuestGoHomeWithoutPay(RoomGuest guest);
  bool canGuestStayWithoutDeposit(RoomGuest guest);
  bool canGuestReservateMoreThanOneRoom(RoomGuest guest);
}

// standard_guest_policy.dart
class RooGuestPolicyImpl implements RoomGuestPolicy {
  
  @override
  bool canChargeGuest(RoomGuest guest) {
   // return false;
   debugPrint( guest.stayDate.toLocal().toString() );
   
   // PostDay old then one day.
   final postDay = DateTime.now().getDateOnly();
  // postDay.add( Duration( days: 1 ));

   final result = guest.stayDate.isBefore(postDay);

   return result;
  }
  
  @override
  bool canGuestGoHomeWithoutPay(RoomGuest guest) {
    // TODO: implement canGuestGoHomeWithoutPay
    throw UnimplementedError();
  }
  
  @override
  bool canGuestReservateMoreThanOneRoom(RoomGuest guest) {
    // TODO: implement canGuestReservateMoreThanOneRoom
    throw UnimplementedError();
  }
  
  @override
  bool canGuestStayWithoutDeposit(RoomGuest guest) {
    // TODO: implement canGuestStayWithoutDeposit
    throw UnimplementedError();
  }

  // ... implement other policy methods
}