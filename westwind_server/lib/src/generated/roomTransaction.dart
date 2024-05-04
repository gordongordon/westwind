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
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class RoomTransaction extends _i1.TableRow {
  RoomTransaction._({
    int? id,
    required this.roomNumber,
    required this.dateState,
    required this.rateType,
    required this.rate,
    required this.dateCreate,
    this.dateUpdate,
    this.guests,
  }) : super(id);

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

  static final t = RoomTransactionTable();

  static const db = RoomTransactionRepository._();

  _i2.RoomNumber roomNumber;

  DateTime dateState;

  _i2.RateType rateType;

  double rate;

  DateTime dateCreate;

  DateTime? dateUpdate;

  List<_i2.Guest>? guests;

  @override
  _i1.Table get table => t;

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

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'dateState': dateState,
      'rateType': rateType,
      'rate': rate,
      'dateCreate': dateCreate,
      'dateUpdate': dateUpdate,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      'dateState': dateState.toJson(),
      'rateType': rateType.toJson(),
      'rate': rate,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.allToJson()),
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
      case 'roomNumber':
        roomNumber = value;
        return;
      case 'dateState':
        dateState = value;
        return;
      case 'rateType':
        rateType = value;
        return;
      case 'rate':
        rate = value;
        return;
      case 'dateCreate':
        dateCreate = value;
        return;
      case 'dateUpdate':
        dateUpdate = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<RoomTransaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomTransactionInclude? include,
  }) async {
    return session.db.find<RoomTransaction>(
      where: where != null ? where(RoomTransaction.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<RoomTransaction?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomTransactionInclude? include,
  }) async {
    return session.db.findSingleRow<RoomTransaction>(
      where: where != null ? where(RoomTransaction.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<RoomTransaction?> findById(
    _i1.Session session,
    int id, {
    RoomTransactionInclude? include,
  }) async {
    return session.db.findById<RoomTransaction>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomTransaction>(
      where: where(RoomTransaction.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    RoomTransaction row, {
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
    RoomTransaction row, {
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
    RoomTransaction row, {
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
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomTransaction>(
      where: where != null ? where(RoomTransaction.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static RoomTransactionInclude include({_i2.GuestIncludeList? guests}) {
    return RoomTransactionInclude._(guests: guests);
  }

  static RoomTransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTransactionTable>? orderByList,
    RoomTransactionInclude? include,
  }) {
    return RoomTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomTransaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomTransaction.t),
      include: include,
    );
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

class RoomTransactionTable extends _i1.Table {
  RoomTransactionTable({super.tableRelation})
      : super(tableName: 'room_transaction') {
    roomNumber = _i1.ColumnEnum(
      'roomNumber',
      this,
      _i1.EnumSerialization.byName,
    );
    dateState = _i1.ColumnDateTime(
      'dateState',
      this,
    );
    rateType = _i1.ColumnEnum(
      'rateType',
      this,
      _i1.EnumSerialization.byName,
    );
    rate = _i1.ColumnDouble(
      'rate',
      this,
    );
    dateCreate = _i1.ColumnDateTime(
      'dateCreate',
      this,
    );
    dateUpdate = _i1.ColumnDateTime(
      'dateUpdate',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.RoomNumber> roomNumber;

  late final _i1.ColumnDateTime dateState;

  late final _i1.ColumnEnum<_i2.RateType> rateType;

  late final _i1.ColumnDouble rate;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateUpdate;

  _i2.GuestTable? ___guests;

  _i1.ManyRelation<_i2.GuestTable>? _guests;

  _i2.GuestTable get __guests {
    if (___guests != null) return ___guests!;
    ___guests = _i1.createRelationTable(
      relationFieldName: '__guests',
      field: RoomTransaction.t.id,
      foreignField: _i2.Guest.t.$_roomTransactionGuestsRoomTransactionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    return ___guests!;
  }

  _i1.ManyRelation<_i2.GuestTable> get guests {
    if (_guests != null) return _guests!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'guests',
      field: RoomTransaction.t.id,
      foreignField: _i2.Guest.t.$_roomTransactionGuestsRoomTransactionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    _guests = _i1.ManyRelation<_i2.GuestTable>(
      tableWithRelations: relationTable,
      table: _i2.GuestTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _guests!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        roomNumber,
        dateState,
        rateType,
        rate,
        dateCreate,
        dateUpdate,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guests') {
      return __guests;
    }
    return null;
  }
}

@Deprecated('Use RoomTransactionTable.t instead.')
RoomTransactionTable tRoomTransaction = RoomTransactionTable();

class RoomTransactionInclude extends _i1.IncludeObject {
  RoomTransactionInclude._({_i2.GuestIncludeList? guests}) {
    _guests = guests;
  }

  _i2.GuestIncludeList? _guests;

  @override
  Map<String, _i1.Include?> get includes => {'guests': _guests};

  @override
  _i1.Table get table => RoomTransaction.t;
}

class RoomTransactionIncludeList extends _i1.IncludeList {
  RoomTransactionIncludeList._({
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomTransaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RoomTransaction.t;
}

class RoomTransactionRepository {
  const RoomTransactionRepository._();

  final attach = const RoomTransactionAttachRepository._();

  final attachRow = const RoomTransactionAttachRowRepository._();

  final detach = const RoomTransactionDetachRepository._();

  final detachRow = const RoomTransactionDetachRowRepository._();

  Future<List<RoomTransaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    RoomTransactionInclude? include,
  }) async {
    return session.dbNext.find<RoomTransaction>(
      where: where?.call(RoomTransaction.t),
      orderBy: orderBy?.call(RoomTransaction.t),
      orderByList: orderByList?.call(RoomTransaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoomTransaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    RoomTransactionInclude? include,
  }) async {
    return session.dbNext.findFirstRow<RoomTransaction>(
      where: where?.call(RoomTransaction.t),
      orderBy: orderBy?.call(RoomTransaction.t),
      orderByList: orderByList?.call(RoomTransaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoomTransaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoomTransactionInclude? include,
  }) async {
    return session.dbNext.findById<RoomTransaction>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<RoomTransaction>> insert(
    _i1.Session session,
    List<RoomTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<RoomTransaction>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomTransaction> insertRow(
    _i1.Session session,
    RoomTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<RoomTransaction>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoomTransaction>> update(
    _i1.Session session,
    List<RoomTransaction> rows, {
    _i1.ColumnSelections<RoomTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<RoomTransaction>(
      rows,
      columns: columns?.call(RoomTransaction.t),
      transaction: transaction,
    );
  }

  Future<RoomTransaction> updateRow(
    _i1.Session session,
    RoomTransaction row, {
    _i1.ColumnSelections<RoomTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<RoomTransaction>(
      row,
      columns: columns?.call(RoomTransaction.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<RoomTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<RoomTransaction>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    RoomTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<RoomTransaction>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<RoomTransaction>(
      where: where(RoomTransaction.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<RoomTransaction>(
      where: where?.call(RoomTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RoomTransactionAttachRepository {
  const RoomTransactionAttachRepository._();

  Future<void> guests(
    _i1.Session session,
    RoomTransaction roomTransaction,
    List<_i2.Guest> guest,
  ) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }

    var $guest = guest
        .map((e) => _i2.GuestImplicit(
              e,
              $_roomTransactionGuestsRoomTransactionId: roomTransaction.id,
            ))
        .toList();
    await session.dbNext.update<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.$_roomTransactionGuestsRoomTransactionId],
    );
  }
}

class RoomTransactionAttachRowRepository {
  const RoomTransactionAttachRowRepository._();

  Future<void> guests(
    _i1.Session session,
    RoomTransaction roomTransaction,
    _i2.Guest guest,
  ) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }

    var $guest = _i2.GuestImplicit(
      guest,
      $_roomTransactionGuestsRoomTransactionId: roomTransaction.id,
    );
    await session.dbNext.updateRow<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.$_roomTransactionGuestsRoomTransactionId],
    );
  }
}

class RoomTransactionDetachRepository {
  const RoomTransactionDetachRepository._();

  Future<void> guests(
    _i1.Session session,
    List<_i2.Guest> guest,
  ) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest
        .map((e) => _i2.GuestImplicit(
              e,
              $_roomTransactionGuestsRoomTransactionId: null,
            ))
        .toList();
    await session.dbNext.update<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.$_roomTransactionGuestsRoomTransactionId],
    );
  }
}

class RoomTransactionDetachRowRepository {
  const RoomTransactionDetachRowRepository._();

  Future<void> guests(
    _i1.Session session,
    _i2.Guest guest,
  ) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = _i2.GuestImplicit(
      guest,
      $_roomTransactionGuestsRoomTransactionId: null,
    );
    await session.dbNext.updateRow<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.$_roomTransactionGuestsRoomTransactionId],
    );
  }
}
