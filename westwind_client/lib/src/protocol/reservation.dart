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
import 'guest.dart' as _i2;
import 'rateType.dart' as _i3;
import 'rateReason.dart' as _i4;
import 'room.dart' as _i5;

abstract class Reservation implements _i1.SerializableModel {
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
    required _i3.RateType rateType,
    required _i4.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i5.Room? room,
  }) = _ReservationImpl;

  factory Reservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reservation(
      id: jsonSerialization['id'] as int?,
      checkInDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkInDate']),
      checkOutDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkOutDate']),
      stayDay: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stayDay']),
      note: jsonSerialization['note'] as String?,
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      rateType:
          _i3.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i4.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
      isCheckedIn: jsonSerialization['isCheckedIn'] as bool,
      isCanceled: jsonSerialization['isCanceled'] as bool,
      isNightShift: jsonSerialization['isNightShift'] as bool,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i5.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
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

  _i3.RateType rateType;

  _i4.RateReason rateReason;

  double rate;

  bool isCheckedIn;

  bool isCanceled;

  bool isNightShift;

  int roomId;

  _i5.Room? room;

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
    _i3.RateType? rateType,
    _i4.RateReason? rateReason,
    double? rate,
    bool? isCheckedIn,
    bool? isCanceled,
    bool? isNightShift,
    int? roomId,
    _i5.Room? room,
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    required _i3.RateType rateType,
    required _i4.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i5.Room? room,
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
    _i3.RateType? rateType,
    _i4.RateReason? rateReason,
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
      room: room is _i5.Room? ? room : this.room?.copyWith(),
    );
  }
}
