/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class Reservation extends _i1.SerializableEntity {
  Reservation._({
    this.id,
    required this.checkInDate,
    required this.checkOutDate,
    required this.stayDay,
    this.note,
    required this.dateCreate,
    this.dateUpdate,
    required this.guestId,
    this.guest,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.isCheckedIn,
    required this.isCanceled,
    required this.isNightShift,
    required this.roomId,
    this.room,
  });

  factory Reservation({
    int? id,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required DateTime stayDay,
    String? note,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i2.Room? room,
  }) = _ReservationImpl;

  factory Reservation.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Reservation(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      checkInDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['checkInDate']),
      checkOutDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['checkOutDate']),
      stayDay: serializationManager
          .deserialize<DateTime>(jsonSerialization['stayDay']),
      note:
          serializationManager.deserialize<String?>(jsonSerialization['note']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      rateReason: serializationManager
          .deserialize<_i2.RateReason>(jsonSerialization['rateReason']),
      rate: serializationManager.deserialize<double>(jsonSerialization['rate']),
      isCheckedIn: serializationManager
          .deserialize<bool>(jsonSerialization['isCheckedIn']),
      isCanceled: serializationManager
          .deserialize<bool>(jsonSerialization['isCanceled']),
      isNightShift: serializationManager
          .deserialize<bool>(jsonSerialization['isNightShift']),
      roomId:
          serializationManager.deserialize<int>(jsonSerialization['roomId']),
      room: serializationManager
          .deserialize<_i2.Room?>(jsonSerialization['room']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime checkInDate;

  DateTime checkOutDate;

  DateTime stayDay;

  String? note;

  DateTime dateCreate;

  DateTime? dateUpdate;

  int guestId;

  _i2.Guest? guest;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  bool isCheckedIn;

  bool isCanceled;

  bool isNightShift;

  int roomId;

  _i2.Room? room;

  Reservation copyWith({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    DateTime? stayDay,
    String? note,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? guestId,
    _i2.Guest? guest,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    bool? isCheckedIn,
    bool? isCanceled,
    bool? isNightShift,
    int? roomId,
    _i2.Room? room,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      'stayDay': stayDay.toJson(),
      if (note != null) 'note': note,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'isCheckedIn': isCheckedIn,
      'isCanceled': isCanceled,
      'isNightShift': isNightShift,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
    };
  }
}

class _Undefined {}

class _ReservationImpl extends Reservation {
  _ReservationImpl({
    int? id,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required DateTime stayDay,
    String? note,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i2.Room? room,
  }) : super._(
          id: id,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          stayDay: stayDay,
          note: note,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          guestId: guestId,
          guest: guest,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          isCheckedIn: isCheckedIn,
          isCanceled: isCanceled,
          isNightShift: isNightShift,
          roomId: roomId,
          room: room,
        );

  @override
  Reservation copyWith({
    Object? id = _Undefined,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    DateTime? stayDay,
    Object? note = _Undefined,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    bool? isCheckedIn,
    bool? isCanceled,
    bool? isNightShift,
    int? roomId,
    Object? room = _Undefined,
  }) {
    return Reservation(
      id: id is int? ? id : this.id,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      stayDay: stayDay ?? this.stayDay,
      note: note is String? ? note : this.note,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCanceled: isCanceled ?? this.isCanceled,
      isNightShift: isNightShift ?? this.isNightShift,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
    );
  }
}
