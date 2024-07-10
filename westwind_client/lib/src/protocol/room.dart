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

abstract class Room implements _i1.SerializableModel {
  Room._({
    this.id,
    required this.roomNumber,
    this.reservations,
    required this.roomType,
    required this.roomStatus,
    required this.isAvailable,
    required this.isSmoke,
    required this.bedType,
    required this.numOfBeds,
    required this.isNewAC,
    required this.isNewBed,
    required this.numOfMicrowave,
    required this.isNewRefergrator,
    required this.isBigRefergrator,
    required this.isBigTV,
    required this.isNewTV,
    required this.numOfTableLamp,
    required this.isNewTableLamp,
    required this.numOfStandLamp,
    required this.isNewStandLamp,
    this.note,
  });

  factory Room({
    int? id,
    required _i2.RoomNumber roomNumber,
    List<_i2.Reservation>? reservations,
    required String roomType,
    required _i2.RoomStatus roomStatus,
    required bool isAvailable,
    required bool isSmoke,
    required _i2.BedType bedType,
    required int numOfBeds,
    required bool isNewAC,
    required bool isNewBed,
    required int numOfMicrowave,
    required bool isNewRefergrator,
    required bool isBigRefergrator,
    required bool isBigTV,
    required bool isNewTV,
    required int numOfTableLamp,
    required bool isNewTableLamp,
    required int numOfStandLamp,
    required bool isNewStandLamp,
    String? note,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      roomNumber:
          _i2.RoomNumber.fromJson((jsonSerialization['roomNumber'] as String)),
      reservations: (jsonSerialization['reservations'] as List?)
          ?.map((e) => _i2.Reservation.fromJson((e as Map<String, dynamic>)))
          .toList(),
      roomType: jsonSerialization['roomType'] as String,
      roomStatus:
          _i2.RoomStatus.fromJson((jsonSerialization['roomStatus'] as String)),
      isAvailable: jsonSerialization['isAvailable'] as bool,
      isSmoke: jsonSerialization['isSmoke'] as bool,
      bedType: _i2.BedType.fromJson((jsonSerialization['bedType'] as String)),
      numOfBeds: jsonSerialization['numOfBeds'] as int,
      isNewAC: jsonSerialization['isNewAC'] as bool,
      isNewBed: jsonSerialization['isNewBed'] as bool,
      numOfMicrowave: jsonSerialization['numOfMicrowave'] as int,
      isNewRefergrator: jsonSerialization['isNewRefergrator'] as bool,
      isBigRefergrator: jsonSerialization['isBigRefergrator'] as bool,
      isBigTV: jsonSerialization['isBigTV'] as bool,
      isNewTV: jsonSerialization['isNewTV'] as bool,
      numOfTableLamp: jsonSerialization['numOfTableLamp'] as int,
      isNewTableLamp: jsonSerialization['isNewTableLamp'] as bool,
      numOfStandLamp: jsonSerialization['numOfStandLamp'] as int,
      isNewStandLamp: jsonSerialization['isNewStandLamp'] as bool,
      note: jsonSerialization['note'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.RoomNumber roomNumber;

  List<_i2.Reservation>? reservations;

  String roomType;

  _i2.RoomStatus roomStatus;

  bool isAvailable;

  bool isSmoke;

  _i2.BedType bedType;

  int numOfBeds;

  bool isNewAC;

  bool isNewBed;

  int numOfMicrowave;

  bool isNewRefergrator;

  bool isBigRefergrator;

  bool isBigTV;

  bool isNewTV;

  int numOfTableLamp;

  bool isNewTableLamp;

  int numOfStandLamp;

  bool isNewStandLamp;

  String? note;

  Room copyWith({
    int? id,
    _i2.RoomNumber? roomNumber,
    List<_i2.Reservation>? reservations,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    _i2.BedType? bedType,
    int? numOfBeds,
    bool? isNewAC,
    bool? isNewBed,
    int? numOfMicrowave,
    bool? isNewRefergrator,
    bool? isBigRefergrator,
    bool? isBigTV,
    bool? isNewTV,
    int? numOfTableLamp,
    bool? isNewTableLamp,
    int? numOfStandLamp,
    bool? isNewStandLamp,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      if (reservations != null)
        'reservations': reservations?.toJson(valueToJson: (v) => v.toJson()),
      'roomType': roomType,
      'roomStatus': roomStatus.toJson(),
      'isAvailable': isAvailable,
      'isSmoke': isSmoke,
      'bedType': bedType.toJson(),
      'numOfBeds': numOfBeds,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'numOfMicrowave': numOfMicrowave,
      'isNewRefergrator': isNewRefergrator,
      'isBigRefergrator': isBigRefergrator,
      'isBigTV': isBigTV,
      'isNewTV': isNewTV,
      'numOfTableLamp': numOfTableLamp,
      'isNewTableLamp': isNewTableLamp,
      'numOfStandLamp': numOfStandLamp,
      'isNewStandLamp': isNewStandLamp,
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required _i2.RoomNumber roomNumber,
    List<_i2.Reservation>? reservations,
    required String roomType,
    required _i2.RoomStatus roomStatus,
    required bool isAvailable,
    required bool isSmoke,
    required _i2.BedType bedType,
    required int numOfBeds,
    required bool isNewAC,
    required bool isNewBed,
    required int numOfMicrowave,
    required bool isNewRefergrator,
    required bool isBigRefergrator,
    required bool isBigTV,
    required bool isNewTV,
    required int numOfTableLamp,
    required bool isNewTableLamp,
    required int numOfStandLamp,
    required bool isNewStandLamp,
    String? note,
  }) : super._(
          id: id,
          roomNumber: roomNumber,
          reservations: reservations,
          roomType: roomType,
          roomStatus: roomStatus,
          isAvailable: isAvailable,
          isSmoke: isSmoke,
          bedType: bedType,
          numOfBeds: numOfBeds,
          isNewAC: isNewAC,
          isNewBed: isNewBed,
          numOfMicrowave: numOfMicrowave,
          isNewRefergrator: isNewRefergrator,
          isBigRefergrator: isBigRefergrator,
          isBigTV: isBigTV,
          isNewTV: isNewTV,
          numOfTableLamp: numOfTableLamp,
          isNewTableLamp: isNewTableLamp,
          numOfStandLamp: numOfStandLamp,
          isNewStandLamp: isNewStandLamp,
          note: note,
        );

  @override
  Room copyWith({
    Object? id = _Undefined,
    _i2.RoomNumber? roomNumber,
    Object? reservations = _Undefined,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    _i2.BedType? bedType,
    int? numOfBeds,
    bool? isNewAC,
    bool? isNewBed,
    int? numOfMicrowave,
    bool? isNewRefergrator,
    bool? isBigRefergrator,
    bool? isBigTV,
    bool? isNewTV,
    int? numOfTableLamp,
    bool? isNewTableLamp,
    int? numOfStandLamp,
    bool? isNewStandLamp,
    Object? note = _Undefined,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      reservations: reservations is List<_i2.Reservation>?
          ? reservations
          : this.reservations?.clone(),
      roomType: roomType ?? this.roomType,
      roomStatus: roomStatus ?? this.roomStatus,
      isAvailable: isAvailable ?? this.isAvailable,
      isSmoke: isSmoke ?? this.isSmoke,
      bedType: bedType ?? this.bedType,
      numOfBeds: numOfBeds ?? this.numOfBeds,
      isNewAC: isNewAC ?? this.isNewAC,
      isNewBed: isNewBed ?? this.isNewBed,
      numOfMicrowave: numOfMicrowave ?? this.numOfMicrowave,
      isNewRefergrator: isNewRefergrator ?? this.isNewRefergrator,
      isBigRefergrator: isBigRefergrator ?? this.isBigRefergrator,
      isBigTV: isBigTV ?? this.isBigTV,
      isNewTV: isNewTV ?? this.isNewTV,
      numOfTableLamp: numOfTableLamp ?? this.numOfTableLamp,
      isNewTableLamp: isNewTableLamp ?? this.isNewTableLamp,
      numOfStandLamp: numOfStandLamp ?? this.numOfStandLamp,
      isNewStandLamp: isNewStandLamp ?? this.isNewStandLamp,
      note: note is String? ? note : this.note,
    );
  }
}
