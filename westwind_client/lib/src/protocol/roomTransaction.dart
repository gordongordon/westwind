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

abstract class RoomTransaction extends _i1.SerializableEntity {
  RoomTransaction._({
    this.id,
    required this.roomNumber,
    required this.dateState,
    required this.rateType,
    required this.rate,
    required this.dateCreate,
    this.dateUpdate,
    this.guests,
  });

  factory RoomTransaction({
    int? id,
    required _i2.RoomNumber roomNumber,
    required DateTime dateState,
    required _i2.RateType rateType,
    required double rate,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    List<_i2.Guest>? guests,
  }) = _RoomTransactionImpl;

  factory RoomTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomTransaction(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      dateState: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateState']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      rate: serializationManager.deserialize<double>(jsonSerialization['rate']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      guests: serializationManager
          .deserialize<List<_i2.Guest>?>(jsonSerialization['guests']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.RoomNumber roomNumber;

  DateTime dateState;

  _i2.RateType rateType;

  double rate;

  DateTime dateCreate;

  DateTime? dateUpdate;

  List<_i2.Guest>? guests;

  RoomTransaction copyWith({
    int? id,
    _i2.RoomNumber? roomNumber,
    DateTime? dateState,
    _i2.RateType? rateType,
    double? rate,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    List<_i2.Guest>? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      'dateState': dateState.toJson(),
      'rateType': rateType.toJson(),
      'rate': rate,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJson()),
    };
  }
}

class _Undefined {}

class _RoomTransactionImpl extends RoomTransaction {
  _RoomTransactionImpl({
    int? id,
    required _i2.RoomNumber roomNumber,
    required DateTime dateState,
    required _i2.RateType rateType,
    required double rate,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    List<_i2.Guest>? guests,
  }) : super._(
          id: id,
          roomNumber: roomNumber,
          dateState: dateState,
          rateType: rateType,
          rate: rate,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          guests: guests,
        );

  @override
  RoomTransaction copyWith({
    Object? id = _Undefined,
    _i2.RoomNumber? roomNumber,
    DateTime? dateState,
    _i2.RateType? rateType,
    double? rate,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    Object? guests = _Undefined,
  }) {
    return RoomTransaction(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      dateState: dateState ?? this.dateState,
      rateType: rateType ?? this.rateType,
      rate: rate ?? this.rate,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      guests: guests is List<_i2.Guest>? ? guests : this.guests?.clone(),
    );
  }
}
