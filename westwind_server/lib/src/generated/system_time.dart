/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class SystemTime implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = SystemTimeTable();

  static const db = SystemTimeRepository._();

  @override
  int? id;

  DateTime lastAuditDate;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'lastAuditDate': lastAuditDate.toJson(),
    };
  }

  static SystemTimeInclude include() {
    return SystemTimeInclude._();
  }

  static SystemTimeIncludeList includeList({
    _i1.WhereExpressionBuilder<SystemTimeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemTimeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemTimeTable>? orderByList,
    SystemTimeInclude? include,
  }) {
    return SystemTimeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemTime.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SystemTime.t),
      include: include,
    );
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

class SystemTimeTable extends _i1.Table {
  SystemTimeTable({super.tableRelation}) : super(tableName: 'system_time') {
    lastAuditDate = _i1.ColumnDateTime(
      'lastAuditDate',
      this,
    );
  }

  late final _i1.ColumnDateTime lastAuditDate;

  @override
  List<_i1.Column> get columns => [
        id,
        lastAuditDate,
      ];
}

class SystemTimeInclude extends _i1.IncludeObject {
  SystemTimeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => SystemTime.t;
}

class SystemTimeIncludeList extends _i1.IncludeList {
  SystemTimeIncludeList._({
    _i1.WhereExpressionBuilder<SystemTimeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SystemTime.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => SystemTime.t;
}

class SystemTimeRepository {
  const SystemTimeRepository._();

  Future<List<SystemTime>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemTimeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemTimeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemTimeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SystemTime>(
      where: where?.call(SystemTime.t),
      orderBy: orderBy?.call(SystemTime.t),
      orderByList: orderByList?.call(SystemTime.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<SystemTime?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemTimeTable>? where,
    int? offset,
    _i1.OrderByBuilder<SystemTimeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemTimeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SystemTime>(
      where: where?.call(SystemTime.t),
      orderBy: orderBy?.call(SystemTime.t),
      orderByList: orderByList?.call(SystemTime.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<SystemTime?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SystemTime>(
      id,
      transaction: transaction,
    );
  }

  Future<List<SystemTime>> insert(
    _i1.Session session,
    List<SystemTime> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SystemTime>(
      rows,
      transaction: transaction,
    );
  }

  Future<SystemTime> insertRow(
    _i1.Session session,
    SystemTime row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SystemTime>(
      row,
      transaction: transaction,
    );
  }

  Future<List<SystemTime>> update(
    _i1.Session session,
    List<SystemTime> rows, {
    _i1.ColumnSelections<SystemTimeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SystemTime>(
      rows,
      columns: columns?.call(SystemTime.t),
      transaction: transaction,
    );
  }

  Future<SystemTime> updateRow(
    _i1.Session session,
    SystemTime row, {
    _i1.ColumnSelections<SystemTimeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SystemTime>(
      row,
      columns: columns?.call(SystemTime.t),
      transaction: transaction,
    );
  }

  Future<List<SystemTime>> delete(
    _i1.Session session,
    List<SystemTime> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SystemTime>(
      rows,
      transaction: transaction,
    );
  }

  Future<SystemTime> deleteRow(
    _i1.Session session,
    SystemTime row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SystemTime>(
      row,
      transaction: transaction,
    );
  }

  Future<List<SystemTime>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SystemTimeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SystemTime>(
      where: where(SystemTime.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemTimeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SystemTime>(
      where: where?.call(SystemTime.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
