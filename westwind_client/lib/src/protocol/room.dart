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

abstract class Room extends _i1.SerializableEntity {
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

  factory Room.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Room(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      reservations: serializationManager.deserialize<List<_i2.Reservation>?>(
          jsonSerialization['reservations']),
      roomType: serializationManager
          .deserialize<String>(jsonSerialization['roomType']),
      roomStatus: serializationManager
          .deserialize<_i2.RoomStatus>(jsonSerialization['roomStatus']),
      isAvailable: serializationManager
          .deserialize<bool>(jsonSerialization['isAvailable']),
      isSmoke:
          serializationManager.deserialize<bool>(jsonSerialization['isSmoke']),
      bedType: serializationManager
          .deserialize<_i2.BedType>(jsonSerialization['bedType']),
      numOfBeds:
          serializationManager.deserialize<int>(jsonSerialization['numOfBeds']),
      isNewAC:
          serializationManager.deserialize<bool>(jsonSerialization['isNewAC']),
      isNewBed:
          serializationManager.deserialize<bool>(jsonSerialization['isNewBed']),
      numOfMicrowave: serializationManager
          .deserialize<int>(jsonSerialization['numOfMicrowave']),
      isNewRefergrator: serializationManager
          .deserialize<bool>(jsonSerialization['isNewRefergrator']),
      isBigRefergrator: serializationManager
          .deserialize<bool>(jsonSerialization['isBigRefergrator']),
      isBigTV:
          serializationManager.deserialize<bool>(jsonSerialization['isBigTV']),
      isNewTV:
          serializationManager.deserialize<bool>(jsonSerialization['isNewTV']),
      numOfTableLamp: serializationManager
          .deserialize<int>(jsonSerialization['numOfTableLamp']),
      isNewTableLamp: serializationManager
          .deserialize<bool>(jsonSerialization['isNewTableLamp']),
      numOfStandLamp: serializationManager
          .deserialize<int>(jsonSerialization['numOfStandLamp']),
      isNewStandLamp: serializationManager
          .deserialize<bool>(jsonSerialization['isNewStandLamp']),
      note:
          serializationManager.deserialize<String?>(jsonSerialization['note']),
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
