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

abstract class SystemTime implements _i1.SerializableModel {
  SystemTime._({
    this.id,
    required this.lastAuditDate,
  });

  factory SystemTime({
    int? id,
    required DateTime lastAuditDate,
  }) = _SystemTimeImpl;

  factory SystemTime.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemTime(
      id: jsonSerialization['id'] as int?,
      lastAuditDate: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastAuditDate']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime lastAuditDate;

  SystemTime copyWith({
    int? id,
    DateTime? lastAuditDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lastAuditDate': lastAuditDate.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemTimeImpl extends SystemTime {
  _SystemTimeImpl({
    int? id,
    required DateTime lastAuditDate,
  }) : super._(
          id: id,
          lastAuditDate: lastAuditDate,
        );

  @override
  SystemTime copyWith({
    Object? id = _Undefined,
    DateTime? lastAuditDate,
  }) {
    return SystemTime(
      id: id is int? ? id : this.id,
      lastAuditDate: lastAuditDate ?? this.lastAuditDate,
    );
  }
}
