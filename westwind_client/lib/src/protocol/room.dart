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
    required this.isBigTV,
    required this.isNewAC,
    required this.isNewBed,
    required this.isBigRefergrator,
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
    required String bedType,
    required bool isBigTV,
    required bool isNewAC,
    required bool isNewBed,
    required bool isBigRefergrator,
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
          .deserialize<String>(jsonSerialization['bedType']),
      isBigTV:
          serializationManager.deserialize<bool>(jsonSerialization['isBigTV']),
      isNewAC:
          serializationManager.deserialize<bool>(jsonSerialization['isNewAC']),
      isNewBed:
          serializationManager.deserialize<bool>(jsonSerialization['isNewBed']),
      isBigRefergrator: serializationManager
          .deserialize<bool>(jsonSerialization['isBigRefergrator']),
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

  String bedType;

  bool isBigTV;

  bool isNewAC;

  bool isNewBed;

  bool isBigRefergrator;

  String? note;

  Room copyWith({
    int? id,
    _i2.RoomNumber? roomNumber,
    List<_i2.Reservation>? reservations,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    String? bedType,
    bool? isBigTV,
    bool? isNewAC,
    bool? isNewBed,
    bool? isBigRefergrator,
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
      'bedType': bedType,
      'isBigTV': isBigTV,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'isBigRefergrator': isBigRefergrator,
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
    required String bedType,
    required bool isBigTV,
    required bool isNewAC,
    required bool isNewBed,
    required bool isBigRefergrator,
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
          isBigTV: isBigTV,
          isNewAC: isNewAC,
          isNewBed: isNewBed,
          isBigRefergrator: isBigRefergrator,
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
    String? bedType,
    bool? isBigTV,
    bool? isNewAC,
    bool? isNewBed,
    bool? isBigRefergrator,
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
      isBigTV: isBigTV ?? this.isBigTV,
      isNewAC: isNewAC ?? this.isNewAC,
      isNewBed: isNewBed ?? this.isNewBed,
      isBigRefergrator: isBigRefergrator ?? this.isBigRefergrator,
      note: note is String? ? note : this.note,
    );
  }
}
