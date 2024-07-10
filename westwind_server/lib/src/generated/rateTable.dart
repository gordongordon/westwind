/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class RateTable extends _i1.TableRow
    implements _i1.ProtocolSerialization {
  RateTable._({
    int? id,
    required this.rateType,
    required this.rateReason,
    required this.rate,
  }) : super(id);

  factory RateTable({
    int? id,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
  }) = _RateTableImpl;

  factory RateTable.fromJson(Map<String, dynamic> jsonSerialization) {
    return RateTable(
      id: jsonSerialization['id'] as int?,
      rateType:
          _i2.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i2.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
    );
  }

  static final t = RateTableTable();

  static const db = RateTableRepository._();

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  @override
  _i1.Table get table => t;

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

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
    };
  }

  static RateTableInclude include() {
    return RateTableInclude._();
  }

  static RateTableIncludeList includeList({
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RateTableTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RateTableTable>? orderByList,
    RateTableInclude? include,
  }) {
    return RateTableIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RateTable.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RateTable.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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

class RateTableTable extends _i1.Table {
  RateTableTable({super.tableRelation}) : super(tableName: 'rate_table') {
    rateType = _i1.ColumnEnum(
      'rateType',
      this,
      _i1.EnumSerialization.byName,
    );
    rateReason = _i1.ColumnEnum(
      'rateReason',
      this,
      _i1.EnumSerialization.byName,
    );
    rate = _i1.ColumnDouble(
      'rate',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.RateType> rateType;

  late final _i1.ColumnEnum<_i2.RateReason> rateReason;

  late final _i1.ColumnDouble rate;

  @override
  List<_i1.Column> get columns => [
        id,
        rateType,
        rateReason,
        rate,
      ];
}

class RateTableInclude extends _i1.IncludeObject {
  RateTableInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => RateTable.t;
}

class RateTableIncludeList extends _i1.IncludeList {
  RateTableIncludeList._({
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RateTable.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RateTable.t;
}

class RateTableRepository {
  const RateTableRepository._();

  Future<List<RateTable>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RateTableTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RateTableTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<RateTable>(
      where: where?.call(RateTable.t),
      orderBy: orderBy?.call(RateTable.t),
      orderByList: orderByList?.call(RateTable.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RateTable?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? offset,
    _i1.OrderByBuilder<RateTableTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RateTableTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<RateTable>(
      where: where?.call(RateTable.t),
      orderBy: orderBy?.call(RateTable.t),
      orderByList: orderByList?.call(RateTable.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RateTable?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<RateTable>(
      id,
      transaction: transaction,
    );
  }

  Future<List<RateTable>> insert(
    _i1.Session session,
    List<RateTable> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RateTable>(
      rows,
      transaction: transaction,
    );
  }

  Future<RateTable> insertRow(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RateTable>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RateTable>> update(
    _i1.Session session,
    List<RateTable> rows, {
    _i1.ColumnSelections<RateTableTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RateTable>(
      rows,
      columns: columns?.call(RateTable.t),
      transaction: transaction,
    );
  }

  Future<RateTable> updateRow(
    _i1.Session session,
    RateTable row, {
    _i1.ColumnSelections<RateTableTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RateTable>(
      row,
      columns: columns?.call(RateTable.t),
      transaction: transaction,
    );
  }

  Future<List<RateTable>> delete(
    _i1.Session session,
    List<RateTable> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RateTable>(
      rows,
      transaction: transaction,
    );
  }

  Future<RateTable> deleteRow(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RateTable>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RateTable>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RateTableTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RateTable>(
      where: where(RateTable.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RateTable>(
      where: where?.call(RateTable.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
