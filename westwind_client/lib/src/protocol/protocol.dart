/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'company.dart' as _i2;
import 'errorType.dart' as _i3;
import 'example.dart' as _i4;
import 'guest.dart' as _i5;
import 'guestInOutDate.dart' as _i6;
import 'guestTransaction.dart' as _i7;
import 'inOutReason.dart' as _i8;
import 'itemType.dart' as _i9;
import 'myexception.dart' as _i10;
import 'payment.dart' as _i11;
import 'paymentType.dart' as _i12;
import 'permissionType.dart' as _i13;
import 'rateReason.dart' as _i14;
import 'rateTable.dart' as _i15;
import 'rateType.dart' as _i16;
import 'reservation.dart' as _i17;
import 'room.dart' as _i18;
import 'roomChargeType.dart' as _i19;
import 'roomGuest.dart' as _i20;
import 'roomInOutDate.dart' as _i21;
import 'roomNumber.dart' as _i22;
import 'roomStatus.dart' as _i23;
import 'roomTransaction.dart' as _i24;
import 'staff.dart' as _i25;
import 'transactionType.dart' as _i26;
import 'protocol.dart' as _i27;
import 'package:westwind_client/src/protocol/guest.dart' as _i28;
import 'package:westwind_client/src/protocol/rateTable.dart' as _i29;
import 'package:westwind_client/src/protocol/reservation.dart' as _i30;
import 'package:westwind_client/src/protocol/roomGuest.dart' as _i31;
import 'package:westwind_client/src/protocol/roomTransaction.dart' as _i32;
import 'package:serverpod_auth_client/module.dart' as _i33;
export 'company.dart';
export 'errorType.dart';
export 'example.dart';
export 'guest.dart';
export 'guestInOutDate.dart';
export 'guestTransaction.dart';
export 'inOutReason.dart';
export 'itemType.dart';
export 'myexception.dart';
export 'payment.dart';
export 'paymentType.dart';
export 'permissionType.dart';
export 'rateReason.dart';
export 'rateTable.dart';
export 'rateType.dart';
export 'reservation.dart';
export 'room.dart';
export 'roomChargeType.dart';
export 'roomGuest.dart';
export 'roomInOutDate.dart';
export 'roomNumber.dart';
export 'roomStatus.dart';
export 'roomTransaction.dart';
export 'staff.dart';
export 'transactionType.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Company) {
      return _i2.Company.fromJson(data, this) as T;
    }
    if (t == _i3.ErrorType) {
      return _i3.ErrorType.fromJson(data) as T;
    }
    if (t == _i4.Examplekk) {
      return _i4.Examplekk.fromJson(data, this) as T;
    }
    if (t == _i5.Guest) {
      return _i5.Guest.fromJson(data, this) as T;
    }
    if (t == _i6.GuestInOutDate) {
      return _i6.GuestInOutDate.fromJson(data, this) as T;
    }
    if (t == _i7.GuestTransaction) {
      return _i7.GuestTransaction.fromJson(data, this) as T;
    }
    if (t == _i8.InOutReason) {
      return _i8.InOutReason.fromJson(data) as T;
    }
    if (t == _i9.ItemType) {
      return _i9.ItemType.fromJson(data) as T;
    }
    if (t == _i10.MyException) {
      return _i10.MyException.fromJson(data, this) as T;
    }
    if (t == _i11.Payment) {
      return _i11.Payment.fromJson(data, this) as T;
    }
    if (t == _i12.PaymentType) {
      return _i12.PaymentType.fromJson(data) as T;
    }
    if (t == _i13.PermissionType) {
      return _i13.PermissionType.fromJson(data) as T;
    }
    if (t == _i14.RateReason) {
      return _i14.RateReason.fromJson(data) as T;
    }
    if (t == _i15.RateTable) {
      return _i15.RateTable.fromJson(data, this) as T;
    }
    if (t == _i16.RateType) {
      return _i16.RateType.fromJson(data) as T;
    }
    if (t == _i17.Reservation) {
      return _i17.Reservation.fromJson(data, this) as T;
    }
    if (t == _i18.Room) {
      return _i18.Room.fromJson(data, this) as T;
    }
    if (t == _i19.RoomChargeType) {
      return _i19.RoomChargeType.fromJson(data) as T;
    }
    if (t == _i20.RoomGuest) {
      return _i20.RoomGuest.fromJson(data, this) as T;
    }
    if (t == _i21.RoomInOutDate) {
      return _i21.RoomInOutDate.fromJson(data, this) as T;
    }
    if (t == _i22.RoomNumber) {
      return _i22.RoomNumber.fromJson(data) as T;
    }
    if (t == _i23.RoomStatus) {
      return _i23.RoomStatus.fromJson(data) as T;
    }
    if (t == _i24.RoomTransaction) {
      return _i24.RoomTransaction.fromJson(data, this) as T;
    }
    if (t == _i25.Staff) {
      return _i25.Staff.fromJson(data, this) as T;
    }
    if (t == _i26.TransactionType) {
      return _i26.TransactionType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Company?>()) {
      return (data != null ? _i2.Company.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.ErrorType?>()) {
      return (data != null ? _i3.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Examplekk?>()) {
      return (data != null ? _i4.Examplekk.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.Guest?>()) {
      return (data != null ? _i5.Guest.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.GuestInOutDate?>()) {
      return (data != null ? _i6.GuestInOutDate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i7.GuestTransaction?>()) {
      return (data != null ? _i7.GuestTransaction.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i8.InOutReason?>()) {
      return (data != null ? _i8.InOutReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ItemType?>()) {
      return (data != null ? _i9.ItemType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.MyException?>()) {
      return (data != null ? _i10.MyException.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i11.Payment?>()) {
      return (data != null ? _i11.Payment.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i12.PaymentType?>()) {
      return (data != null ? _i12.PaymentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PermissionType?>()) {
      return (data != null ? _i13.PermissionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.RateReason?>()) {
      return (data != null ? _i14.RateReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.RateTable?>()) {
      return (data != null ? _i15.RateTable.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i16.RateType?>()) {
      return (data != null ? _i16.RateType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Reservation?>()) {
      return (data != null ? _i17.Reservation.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i18.Room?>()) {
      return (data != null ? _i18.Room.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i19.RoomChargeType?>()) {
      return (data != null ? _i19.RoomChargeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.RoomGuest?>()) {
      return (data != null ? _i20.RoomGuest.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i21.RoomInOutDate?>()) {
      return (data != null ? _i21.RoomInOutDate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i22.RoomNumber?>()) {
      return (data != null ? _i22.RoomNumber.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.RoomStatus?>()) {
      return (data != null ? _i23.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RoomTransaction?>()) {
      return (data != null ? _i24.RoomTransaction.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Staff?>()) {
      return (data != null ? _i25.Staff.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i26.TransactionType?>()) {
      return (data != null ? _i26.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i27.Reservation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i27.Reservation>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i27.RoomTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.RoomTransaction>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i28.Guest>) {
      return (data as List).map((e) => deserialize<_i28.Guest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i29.RateTable>) {
      return (data as List).map((e) => deserialize<_i29.RateTable>(e)).toList()
          as dynamic;
    }
    if (t == List<_i30.Reservation>) {
      return (data as List)
          .map((e) => deserialize<_i30.Reservation>(e))
          .toList() as dynamic;
    }
    if (t == List<_i31.RoomGuest>) {
      return (data as List).map((e) => deserialize<_i31.RoomGuest>(e)).toList()
          as dynamic;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == List<_i32.RoomTransaction>) {
      return (data as List)
          .map((e) => deserialize<_i32.RoomTransaction>(e))
          .toList() as dynamic;
    }
    try {
      return _i33.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i33.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Company) {
      return 'Company';
    }
    if (data is _i3.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i4.Examplekk) {
      return 'Examplekk';
    }
    if (data is _i5.Guest) {
      return 'Guest';
    }
    if (data is _i6.GuestInOutDate) {
      return 'GuestInOutDate';
    }
    if (data is _i7.GuestTransaction) {
      return 'GuestTransaction';
    }
    if (data is _i8.InOutReason) {
      return 'InOutReason';
    }
    if (data is _i9.ItemType) {
      return 'ItemType';
    }
    if (data is _i10.MyException) {
      return 'MyException';
    }
    if (data is _i11.Payment) {
      return 'Payment';
    }
    if (data is _i12.PaymentType) {
      return 'PaymentType';
    }
    if (data is _i13.PermissionType) {
      return 'PermissionType';
    }
    if (data is _i14.RateReason) {
      return 'RateReason';
    }
    if (data is _i15.RateTable) {
      return 'RateTable';
    }
    if (data is _i16.RateType) {
      return 'RateType';
    }
    if (data is _i17.Reservation) {
      return 'Reservation';
    }
    if (data is _i18.Room) {
      return 'Room';
    }
    if (data is _i19.RoomChargeType) {
      return 'RoomChargeType';
    }
    if (data is _i20.RoomGuest) {
      return 'RoomGuest';
    }
    if (data is _i21.RoomInOutDate) {
      return 'RoomInOutDate';
    }
    if (data is _i22.RoomNumber) {
      return 'RoomNumber';
    }
    if (data is _i23.RoomStatus) {
      return 'RoomStatus';
    }
    if (data is _i24.RoomTransaction) {
      return 'RoomTransaction';
    }
    if (data is _i25.Staff) {
      return 'Staff';
    }
    if (data is _i26.TransactionType) {
      return 'TransactionType';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i33.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Company') {
      return deserialize<_i2.Company>(data['data']);
    }
    if (data['className'] == 'ErrorType') {
      return deserialize<_i3.ErrorType>(data['data']);
    }
    if (data['className'] == 'Examplekk') {
      return deserialize<_i4.Examplekk>(data['data']);
    }
    if (data['className'] == 'Guest') {
      return deserialize<_i5.Guest>(data['data']);
    }
    if (data['className'] == 'GuestInOutDate') {
      return deserialize<_i6.GuestInOutDate>(data['data']);
    }
    if (data['className'] == 'GuestTransaction') {
      return deserialize<_i7.GuestTransaction>(data['data']);
    }
    if (data['className'] == 'InOutReason') {
      return deserialize<_i8.InOutReason>(data['data']);
    }
    if (data['className'] == 'ItemType') {
      return deserialize<_i9.ItemType>(data['data']);
    }
    if (data['className'] == 'MyException') {
      return deserialize<_i10.MyException>(data['data']);
    }
    if (data['className'] == 'Payment') {
      return deserialize<_i11.Payment>(data['data']);
    }
    if (data['className'] == 'PaymentType') {
      return deserialize<_i12.PaymentType>(data['data']);
    }
    if (data['className'] == 'PermissionType') {
      return deserialize<_i13.PermissionType>(data['data']);
    }
    if (data['className'] == 'RateReason') {
      return deserialize<_i14.RateReason>(data['data']);
    }
    if (data['className'] == 'RateTable') {
      return deserialize<_i15.RateTable>(data['data']);
    }
    if (data['className'] == 'RateType') {
      return deserialize<_i16.RateType>(data['data']);
    }
    if (data['className'] == 'Reservation') {
      return deserialize<_i17.Reservation>(data['data']);
    }
    if (data['className'] == 'Room') {
      return deserialize<_i18.Room>(data['data']);
    }
    if (data['className'] == 'RoomChargeType') {
      return deserialize<_i19.RoomChargeType>(data['data']);
    }
    if (data['className'] == 'RoomGuest') {
      return deserialize<_i20.RoomGuest>(data['data']);
    }
    if (data['className'] == 'RoomInOutDate') {
      return deserialize<_i21.RoomInOutDate>(data['data']);
    }
    if (data['className'] == 'RoomNumber') {
      return deserialize<_i22.RoomNumber>(data['data']);
    }
    if (data['className'] == 'RoomStatus') {
      return deserialize<_i23.RoomStatus>(data['data']);
    }
    if (data['className'] == 'RoomTransaction') {
      return deserialize<_i24.RoomTransaction>(data['data']);
    }
    if (data['className'] == 'Staff') {
      return deserialize<_i25.Staff>(data['data']);
    }
    if (data['className'] == 'TransactionType') {
      return deserialize<_i26.TransactionType>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
