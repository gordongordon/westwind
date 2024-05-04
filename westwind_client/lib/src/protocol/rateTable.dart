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

abstract class RateTable extends _i1.SerializableEntity {
  RateTable._({
    this.id,
    required this.rateType,
    required this.rateReason,
    required this.rate,
  });

  factory RateTable({
    int? id,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
  }) = _RateTableImpl;

  factory RateTable.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RateTable(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      rateReason: serializationManager
          .deserialize<_i2.RateReason>(jsonSerialization['rateReason']),
      rate: serializationManager.deserialize<double>(jsonSerialization['rate']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  RateTable copyWith({
    int? id,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
    };
  }
}

class _Undefined {}

class _RateTableImpl extends RateTable {
  _RateTableImpl({
    int? id,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
  }) : super._(
          id: id,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
        );

  @override
  RateTable copyWith({
    Object? id = _Undefined,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
  }) {
    return RateTable(
      id: id is int? ? id : this.id,
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
    );
  }
}
