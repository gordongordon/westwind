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
import 'guest.dart' as _i4;
import 'guestInOutDate.dart' as _i5;
import 'guestTransaction.dart' as _i6;
import 'inOutReason.dart' as _i7;
import 'myexception.dart' as _i8;
import 'payment.dart' as _i9;
import 'paymentType.dart' as _i10;
import 'permissionType.dart' as _i11;
import 'rateReason.dart' as _i12;
import 'rateTable.dart' as _i13;
import 'rateType.dart' as _i14;
import 'reservation.dart' as _i15;
import 'room.dart' as _i16;
import 'roomChargeType.dart' as _i17;
import 'roomGuest.dart' as _i18;
import 'roomInOutDate.dart' as _i19;
import 'roomNumber.dart' as _i20;
import 'roomStatus.dart' as _i21;
import 'roomTransaction.dart' as _i22;
import 'staff.dart' as _i23;
import 'protocol.dart' as _i24;
import 'package:westwind_client/src/protocol/guest.dart' as _i25;
import 'package:westwind_client/src/protocol/rateTable.dart' as _i26;
import 'package:westwind_client/src/protocol/reservation.dart' as _i27;
import 'package:westwind_client/src/protocol/roomGuest.dart' as _i28;
import 'package:serverpod_auth_client/module.dart' as _i29;
export 'company.dart';
export 'errorType.dart';
export 'guest.dart';
export 'guestInOutDate.dart';
export 'guestTransaction.dart';
export 'inOutReason.dart';
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
    if (t == _i4.Guest) {
      return _i4.Guest.fromJson(data, this) as T;
    }
    if (t == _i5.GuestInOutDate) {
      return _i5.GuestInOutDate.fromJson(data, this) as T;
    }
    if (t == _i6.GuestTransaction) {
      return _i6.GuestTransaction.fromJson(data, this) as T;
    }
    if (t == _i7.InOutReason) {
      return _i7.InOutReason.fromJson(data) as T;
    }
    if (t == _i8.MyException) {
      return _i8.MyException.fromJson(data, this) as T;
    }
    if (t == _i9.Payment) {
      return _i9.Payment.fromJson(data, this) as T;
    }
    if (t == _i10.PaymentType) {
      return _i10.PaymentType.fromJson(data) as T;
    }
    if (t == _i11.PermissionType) {
      return _i11.PermissionType.fromJson(data) as T;
    }
    if (t == _i12.RateReason) {
      return _i12.RateReason.fromJson(data) as T;
    }
    if (t == _i13.RateTable) {
      return _i13.RateTable.fromJson(data, this) as T;
    }
    if (t == _i14.RateType) {
      return _i14.RateType.fromJson(data) as T;
    }
    if (t == _i15.Reservation) {
      return _i15.Reservation.fromJson(data, this) as T;
    }
    if (t == _i16.Room) {
      return _i16.Room.fromJson(data, this) as T;
    }
    if (t == _i17.RoomChargeType) {
      return _i17.RoomChargeType.fromJson(data) as T;
    }
    if (t == _i18.RoomGuest) {
      return _i18.RoomGuest.fromJson(data, this) as T;
    }
    if (t == _i19.RoomInOutDate) {
      return _i19.RoomInOutDate.fromJson(data, this) as T;
    }
    if (t == _i20.RoomNumber) {
      return _i20.RoomNumber.fromJson(data) as T;
    }
    if (t == _i21.RoomStatus) {
      return _i21.RoomStatus.fromJson(data) as T;
    }
    if (t == _i22.RoomTransaction) {
      return _i22.RoomTransaction.fromJson(data, this) as T;
    }
    if (t == _i23.Staff) {
      return _i23.Staff.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Company?>()) {
      return (data != null ? _i2.Company.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.ErrorType?>()) {
      return (data != null ? _i3.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Guest?>()) {
      return (data != null ? _i4.Guest.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.GuestInOutDate?>()) {
      return (data != null ? _i5.GuestInOutDate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i6.GuestTransaction?>()) {
      return (data != null ? _i6.GuestTransaction.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i7.InOutReason?>()) {
      return (data != null ? _i7.InOutReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.MyException?>()) {
      return (data != null ? _i8.MyException.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i9.Payment?>()) {
      return (data != null ? _i9.Payment.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i10.PaymentType?>()) {
      return (data != null ? _i10.PaymentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.PermissionType?>()) {
      return (data != null ? _i11.PermissionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.RateReason?>()) {
      return (data != null ? _i12.RateReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.RateTable?>()) {
      return (data != null ? _i13.RateTable.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i14.RateType?>()) {
      return (data != null ? _i14.RateType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Reservation?>()) {
      return (data != null ? _i15.Reservation.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i16.Room?>()) {
      return (data != null ? _i16.Room.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i17.RoomChargeType?>()) {
      return (data != null ? _i17.RoomChargeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.RoomGuest?>()) {
      return (data != null ? _i18.RoomGuest.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i19.RoomInOutDate?>()) {
      return (data != null ? _i19.RoomInOutDate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i20.RoomNumber?>()) {
      return (data != null ? _i20.RoomNumber.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.RoomStatus?>()) {
      return (data != null ? _i21.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RoomTransaction?>()) {
      return (data != null ? _i22.RoomTransaction.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i23.Staff?>()) {
      return (data != null ? _i23.Staff.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<List<_i24.Reservation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.Reservation>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i24.Guest>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.Guest>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i25.Guest>) {
      return (data as List).map((e) => deserialize<_i25.Guest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i26.RateTable>) {
      return (data as List).map((e) => deserialize<_i26.RateTable>(e)).toList()
          as dynamic;
    }
    if (t == List<_i27.Reservation>) {
      return (data as List)
          .map((e) => deserialize<_i27.Reservation>(e))
          .toList() as dynamic;
    }
    if (t == List<_i28.RoomGuest>) {
      return (data as List).map((e) => deserialize<_i28.RoomGuest>(e)).toList()
          as dynamic;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    try {
      return _i29.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i29.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Company) {
      return 'Company';
    }
    if (data is _i3.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i4.Guest) {
      return 'Guest';
    }
    if (data is _i5.GuestInOutDate) {
      return 'GuestInOutDate';
    }
    if (data is _i6.GuestTransaction) {
      return 'GuestTransaction';
    }
    if (data is _i7.InOutReason) {
      return 'InOutReason';
    }
    if (data is _i8.MyException) {
      return 'MyException';
    }
    if (data is _i9.Payment) {
      return 'Payment';
    }
    if (data is _i10.PaymentType) {
      return 'PaymentType';
    }
    if (data is _i11.PermissionType) {
      return 'PermissionType';
    }
    if (data is _i12.RateReason) {
      return 'RateReason';
    }
    if (data is _i13.RateTable) {
      return 'RateTable';
    }
    if (data is _i14.RateType) {
      return 'RateType';
    }
    if (data is _i15.Reservation) {
      return 'Reservation';
    }
    if (data is _i16.Room) {
      return 'Room';
    }
    if (data is _i17.RoomChargeType) {
      return 'RoomChargeType';
    }
    if (data is _i18.RoomGuest) {
      return 'RoomGuest';
    }
    if (data is _i19.RoomInOutDate) {
      return 'RoomInOutDate';
    }
    if (data is _i20.RoomNumber) {
      return 'RoomNumber';
    }
    if (data is _i21.RoomStatus) {
      return 'RoomStatus';
    }
    if (data is _i22.RoomTransaction) {
      return 'RoomTransaction';
    }
    if (data is _i23.Staff) {
      return 'Staff';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i29.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Company') {
      return deserialize<_i2.Company>(data['data']);
    }
    if (data['className'] == 'ErrorType') {
      return deserialize<_i3.ErrorType>(data['data']);
    }
    if (data['className'] == 'Guest') {
      return deserialize<_i4.Guest>(data['data']);
    }
    if (data['className'] == 'GuestInOutDate') {
      return deserialize<_i5.GuestInOutDate>(data['data']);
    }
    if (data['className'] == 'GuestTransaction') {
      return deserialize<_i6.GuestTransaction>(data['data']);
    }
    if (data['className'] == 'InOutReason') {
      return deserialize<_i7.InOutReason>(data['data']);
    }
    if (data['className'] == 'MyException') {
      return deserialize<_i8.MyException>(data['data']);
    }
    if (data['className'] == 'Payment') {
      return deserialize<_i9.Payment>(data['data']);
    }
    if (data['className'] == 'PaymentType') {
      return deserialize<_i10.PaymentType>(data['data']);
    }
    if (data['className'] == 'PermissionType') {
      return deserialize<_i11.PermissionType>(data['data']);
    }
    if (data['className'] == 'RateReason') {
      return deserialize<_i12.RateReason>(data['data']);
    }
    if (data['className'] == 'RateTable') {
      return deserialize<_i13.RateTable>(data['data']);
    }
    if (data['className'] == 'RateType') {
      return deserialize<_i14.RateType>(data['data']);
    }
    if (data['className'] == 'Reservation') {
      return deserialize<_i15.Reservation>(data['data']);
    }
    if (data['className'] == 'Room') {
      return deserialize<_i16.Room>(data['data']);
    }
    if (data['className'] == 'RoomChargeType') {
      return deserialize<_i17.RoomChargeType>(data['data']);
    }
    if (data['className'] == 'RoomGuest') {
      return deserialize<_i18.RoomGuest>(data['data']);
    }
    if (data['className'] == 'RoomInOutDate') {
      return deserialize<_i19.RoomInOutDate>(data['data']);
    }
    if (data['className'] == 'RoomNumber') {
      return deserialize<_i20.RoomNumber>(data['data']);
    }
    if (data['className'] == 'RoomStatus') {
      return deserialize<_i21.RoomStatus>(data['data']);
    }
    if (data['className'] == 'RoomTransaction') {
      return deserialize<_i22.RoomTransaction>(data['data']);
    }
    if (data['className'] == 'Staff') {
      return deserialize<_i23.Staff>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
