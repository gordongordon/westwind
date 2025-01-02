/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'bedType.dart' as _i2;
import 'company.dart' as _i3;
import 'errorType.dart' as _i4;
import 'example.dart' as _i5;
import 'guest.dart' as _i6;
import 'guestInOutDate.dart' as _i7;
import 'guestTransaction.dart' as _i8;
import 'inOutReason.dart' as _i9;
import 'itemType.dart' as _i10;
import 'myexception.dart' as _i11;
import 'payment.dart' as _i12;
import 'paymentType.dart' as _i13;
import 'permissionType.dart' as _i14;
import 'rateReason.dart' as _i15;
import 'rateTable.dart' as _i16;
import 'rateType.dart' as _i17;
import 'reservation.dart' as _i18;
import 'room.dart' as _i19;
import 'roomChargeType.dart' as _i20;
import 'roomGuest.dart' as _i21;
import 'roomInOutDate.dart' as _i22;
import 'roomNumber.dart' as _i23;
import 'roomStatus.dart' as _i24;
import 'roomTransaction.dart' as _i25;
import 'staff.dart' as _i26;
import 'system_time.dart' as _i27;
import 'transactionType.dart' as _i28;
import 'package:westwind_client/src/protocol/guest.dart' as _i29;
import 'package:westwind_client/src/protocol/rateTable.dart' as _i30;
import 'package:westwind_client/src/protocol/reservation.dart' as _i31;
import 'package:westwind_client/src/protocol/room.dart' as _i32;
import 'package:westwind_client/src/protocol/roomGuest.dart' as _i33;
import 'package:westwind_client/src/protocol/roomTransaction.dart' as _i34;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i35;
export 'bedType.dart';
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
export 'system_time.dart';
export 'transactionType.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.BedType) {
      return _i2.BedType.fromJson(data) as T;
    }
    if (t == _i3.Company) {
      return _i3.Company.fromJson(data) as T;
    }
    if (t == _i4.ErrorType) {
      return _i4.ErrorType.fromJson(data) as T;
    }
    if (t == _i5.Examplekk) {
      return _i5.Examplekk.fromJson(data) as T;
    }
    if (t == _i6.Guest) {
      return _i6.Guest.fromJson(data) as T;
    }
    if (t == _i7.GuestInOutDate) {
      return _i7.GuestInOutDate.fromJson(data) as T;
    }
    if (t == _i8.GuestTransaction) {
      return _i8.GuestTransaction.fromJson(data) as T;
    }
    if (t == _i9.InOutReason) {
      return _i9.InOutReason.fromJson(data) as T;
    }
    if (t == _i10.ItemType) {
      return _i10.ItemType.fromJson(data) as T;
    }
    if (t == _i11.MyException) {
      return _i11.MyException.fromJson(data) as T;
    }
    if (t == _i12.Payment) {
      return _i12.Payment.fromJson(data) as T;
    }
    if (t == _i13.PaymentType) {
      return _i13.PaymentType.fromJson(data) as T;
    }
    if (t == _i14.PermissionType) {
      return _i14.PermissionType.fromJson(data) as T;
    }
    if (t == _i15.RateReason) {
      return _i15.RateReason.fromJson(data) as T;
    }
    if (t == _i16.RateTable) {
      return _i16.RateTable.fromJson(data) as T;
    }
    if (t == _i17.RateType) {
      return _i17.RateType.fromJson(data) as T;
    }
    if (t == _i18.Reservation) {
      return _i18.Reservation.fromJson(data) as T;
    }
    if (t == _i19.Room) {
      return _i19.Room.fromJson(data) as T;
    }
    if (t == _i20.RoomChargeType) {
      return _i20.RoomChargeType.fromJson(data) as T;
    }
    if (t == _i21.RoomGuest) {
      return _i21.RoomGuest.fromJson(data) as T;
    }
    if (t == _i22.RoomInOutDate) {
      return _i22.RoomInOutDate.fromJson(data) as T;
    }
    if (t == _i23.RoomNumber) {
      return _i23.RoomNumber.fromJson(data) as T;
    }
    if (t == _i24.RoomStatus) {
      return _i24.RoomStatus.fromJson(data) as T;
    }
    if (t == _i25.RoomTransaction) {
      return _i25.RoomTransaction.fromJson(data) as T;
    }
    if (t == _i26.Staff) {
      return _i26.Staff.fromJson(data) as T;
    }
    if (t == _i27.SystemTime) {
      return _i27.SystemTime.fromJson(data) as T;
    }
    if (t == _i28.TransactionType) {
      return _i28.TransactionType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BedType?>()) {
      return (data != null ? _i2.BedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Company?>()) {
      return (data != null ? _i3.Company.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ErrorType?>()) {
      return (data != null ? _i4.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Examplekk?>()) {
      return (data != null ? _i5.Examplekk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Guest?>()) {
      return (data != null ? _i6.Guest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.GuestInOutDate?>()) {
      return (data != null ? _i7.GuestInOutDate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.GuestTransaction?>()) {
      return (data != null ? _i8.GuestTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.InOutReason?>()) {
      return (data != null ? _i9.InOutReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ItemType?>()) {
      return (data != null ? _i10.ItemType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.MyException?>()) {
      return (data != null ? _i11.MyException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Payment?>()) {
      return (data != null ? _i12.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PaymentType?>()) {
      return (data != null ? _i13.PaymentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PermissionType?>()) {
      return (data != null ? _i14.PermissionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.RateReason?>()) {
      return (data != null ? _i15.RateReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.RateTable?>()) {
      return (data != null ? _i16.RateTable.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RateType?>()) {
      return (data != null ? _i17.RateType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Reservation?>()) {
      return (data != null ? _i18.Reservation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Room?>()) {
      return (data != null ? _i19.Room.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.RoomChargeType?>()) {
      return (data != null ? _i20.RoomChargeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.RoomGuest?>()) {
      return (data != null ? _i21.RoomGuest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RoomInOutDate?>()) {
      return (data != null ? _i22.RoomInOutDate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.RoomNumber?>()) {
      return (data != null ? _i23.RoomNumber.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RoomStatus?>()) {
      return (data != null ? _i24.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.RoomTransaction?>()) {
      return (data != null ? _i25.RoomTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.Staff?>()) {
      return (data != null ? _i26.Staff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SystemTime?>()) {
      return (data != null ? _i27.SystemTime.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.TransactionType?>()) {
      return (data != null ? _i28.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i6.Guest>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.Guest>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i21.RoomGuest>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i21.RoomGuest>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i18.Reservation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i18.Reservation>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i25.RoomTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.RoomTransaction>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i29.Guest>) {
      return (data as List).map((e) => deserialize<_i29.Guest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i30.RateTable>) {
      return (data as List).map((e) => deserialize<_i30.RateTable>(e)).toList()
          as dynamic;
    }
    if (t == List<_i31.Reservation>) {
      return (data as List)
          .map((e) => deserialize<_i31.Reservation>(e))
          .toList() as dynamic;
    }
    if (t == List<_i32.Room>) {
      return (data as List).map((e) => deserialize<_i32.Room>(e)).toList()
          as dynamic;
    }
    if (t == List<_i33.RoomGuest>) {
      return (data as List).map((e) => deserialize<_i33.RoomGuest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i34.RoomTransaction>) {
      return (data as List)
          .map((e) => deserialize<_i34.RoomTransaction>(e))
          .toList() as dynamic;
    }
    try {
      return _i35.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.BedType) {
      return 'BedType';
    }
    if (data is _i3.Company) {
      return 'Company';
    }
    if (data is _i4.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i5.Examplekk) {
      return 'Examplekk';
    }
    if (data is _i6.Guest) {
      return 'Guest';
    }
    if (data is _i7.GuestInOutDate) {
      return 'GuestInOutDate';
    }
    if (data is _i8.GuestTransaction) {
      return 'GuestTransaction';
    }
    if (data is _i9.InOutReason) {
      return 'InOutReason';
    }
    if (data is _i10.ItemType) {
      return 'ItemType';
    }
    if (data is _i11.MyException) {
      return 'MyException';
    }
    if (data is _i12.Payment) {
      return 'Payment';
    }
    if (data is _i13.PaymentType) {
      return 'PaymentType';
    }
    if (data is _i14.PermissionType) {
      return 'PermissionType';
    }
    if (data is _i15.RateReason) {
      return 'RateReason';
    }
    if (data is _i16.RateTable) {
      return 'RateTable';
    }
    if (data is _i17.RateType) {
      return 'RateType';
    }
    if (data is _i18.Reservation) {
      return 'Reservation';
    }
    if (data is _i19.Room) {
      return 'Room';
    }
    if (data is _i20.RoomChargeType) {
      return 'RoomChargeType';
    }
    if (data is _i21.RoomGuest) {
      return 'RoomGuest';
    }
    if (data is _i22.RoomInOutDate) {
      return 'RoomInOutDate';
    }
    if (data is _i23.RoomNumber) {
      return 'RoomNumber';
    }
    if (data is _i24.RoomStatus) {
      return 'RoomStatus';
    }
    if (data is _i25.RoomTransaction) {
      return 'RoomTransaction';
    }
    if (data is _i26.Staff) {
      return 'Staff';
    }
    if (data is _i27.SystemTime) {
      return 'SystemTime';
    }
    if (data is _i28.TransactionType) {
      return 'TransactionType';
    }
    className = _i35.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BedType') {
      return deserialize<_i2.BedType>(data['data']);
    }
    if (dataClassName == 'Company') {
      return deserialize<_i3.Company>(data['data']);
    }
    if (dataClassName == 'ErrorType') {
      return deserialize<_i4.ErrorType>(data['data']);
    }
    if (dataClassName == 'Examplekk') {
      return deserialize<_i5.Examplekk>(data['data']);
    }
    if (dataClassName == 'Guest') {
      return deserialize<_i6.Guest>(data['data']);
    }
    if (dataClassName == 'GuestInOutDate') {
      return deserialize<_i7.GuestInOutDate>(data['data']);
    }
    if (dataClassName == 'GuestTransaction') {
      return deserialize<_i8.GuestTransaction>(data['data']);
    }
    if (dataClassName == 'InOutReason') {
      return deserialize<_i9.InOutReason>(data['data']);
    }
    if (dataClassName == 'ItemType') {
      return deserialize<_i10.ItemType>(data['data']);
    }
    if (dataClassName == 'MyException') {
      return deserialize<_i11.MyException>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i12.Payment>(data['data']);
    }
    if (dataClassName == 'PaymentType') {
      return deserialize<_i13.PaymentType>(data['data']);
    }
    if (dataClassName == 'PermissionType') {
      return deserialize<_i14.PermissionType>(data['data']);
    }
    if (dataClassName == 'RateReason') {
      return deserialize<_i15.RateReason>(data['data']);
    }
    if (dataClassName == 'RateTable') {
      return deserialize<_i16.RateTable>(data['data']);
    }
    if (dataClassName == 'RateType') {
      return deserialize<_i17.RateType>(data['data']);
    }
    if (dataClassName == 'Reservation') {
      return deserialize<_i18.Reservation>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_i19.Room>(data['data']);
    }
    if (dataClassName == 'RoomChargeType') {
      return deserialize<_i20.RoomChargeType>(data['data']);
    }
    if (dataClassName == 'RoomGuest') {
      return deserialize<_i21.RoomGuest>(data['data']);
    }
    if (dataClassName == 'RoomInOutDate') {
      return deserialize<_i22.RoomInOutDate>(data['data']);
    }
    if (dataClassName == 'RoomNumber') {
      return deserialize<_i23.RoomNumber>(data['data']);
    }
    if (dataClassName == 'RoomStatus') {
      return deserialize<_i24.RoomStatus>(data['data']);
    }
    if (dataClassName == 'RoomTransaction') {
      return deserialize<_i25.RoomTransaction>(data['data']);
    }
    if (dataClassName == 'Staff') {
      return deserialize<_i26.Staff>(data['data']);
    }
    if (dataClassName == 'SystemTime') {
      return deserialize<_i27.SystemTime>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i28.TransactionType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i35.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
