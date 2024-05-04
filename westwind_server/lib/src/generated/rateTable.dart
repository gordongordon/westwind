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

abstract class RateTable extends _i1.TableRow {
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
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'rateType': rateType,
      'rateReason': rateReason,
      'rate': rate,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'rateType':
        rateType = value;
        return;
      case 'rateReason':
        rateReason = value;
        return;
      case 'rate':
        rate = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<RateTable>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<RateTable>(
      where: where != null ? where(RateTable.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<RateTable?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<RateTable>(
      where: where != null ? where(RateTable.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<RateTable?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<RateTable>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RateTableTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RateTable>(
      where: where(RateTable.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.update instead.')
  static Future<bool> update(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  @Deprecated(
      'Will be removed in 2.0.0. Use: db.insert instead. Important note: In db.insert, the object you pass in is no longer modified, instead a new copy with the added row is returned which contains the inserted id.')
  static Future<void> insert(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.count instead.')
  static Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RateTableTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RateTable>(
      where: where != null ? where(RateTable.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
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

@Deprecated('Use RateTableTable.t instead.')
RateTableTable tRateTable = RateTableTable();

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
    return session.dbNext.find<RateTable>(
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
    return session.dbNext.findFirstRow<RateTable>(
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
    return session.dbNext.findById<RateTable>(
      id,
      transaction: transaction,
    );
  }

  Future<List<RateTable>> insert(
    _i1.Session session,
    List<RateTable> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<RateTable>(
      rows,
      transaction: transaction,
    );
  }

  Future<RateTable> insertRow(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<RateTable>(
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
    return session.dbNext.update<RateTable>(
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
    return session.dbNext.updateRow<RateTable>(
      row,
      columns: columns?.call(RateTable.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<RateTable> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<RateTable>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    RateTable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<RateTable>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RateTableTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<RateTable>(
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
    return session.dbNext.count<RateTable>(
      where: where?.call(RateTable.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
