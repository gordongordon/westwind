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
    required this.guestId,
    this.guest,
    required this.roomId,
    this.room,
    required this.transactionDay,
    required this.transactionType,
    required this.amount,
    required this.tax1,
    required this.tax2,
    required this.tax3,
    required this.description,
  }) : super(id);

  factory RoomTransaction({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i2.Room? room,
    required DateTime transactionDay,
    required _i2.TransactionType transactionType,
    required double amount,
    required double tax1,
    required double tax2,
    required double tax3,
    required String description,
  }) = _RoomTransactionImpl;

  factory RoomTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomTransaction(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      roomId:
          serializationManager.deserialize<int>(jsonSerialization['roomId']),
      room: serializationManager
          .deserialize<_i2.Room?>(jsonSerialization['room']),
      transactionDay: serializationManager
          .deserialize<DateTime>(jsonSerialization['transactionDay']),
      transactionType: serializationManager.deserialize<_i2.TransactionType>(
          jsonSerialization['transactionType']),
      amount:
          serializationManager.deserialize<double>(jsonSerialization['amount']),
      tax1: serializationManager.deserialize<double>(jsonSerialization['tax1']),
      tax2: serializationManager.deserialize<double>(jsonSerialization['tax2']),
      tax3: serializationManager.deserialize<double>(jsonSerialization['tax3']),
      description: serializationManager
          .deserialize<String>(jsonSerialization['description']),
    );
  }

  static final t = RoomTransactionTable();

  static const db = RoomTransactionRepository._();

  int guestId;

  _i2.Guest? guest;

  int roomId;

  _i2.Room? room;

  DateTime transactionDay;

  _i2.TransactionType transactionType;

  double amount;

  double tax1;

  double tax2;

  double tax3;

  String description;

  @override
  _i1.Table get table => t;

  RoomTransaction copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    int? roomId,
    _i2.Room? room,
    DateTime? transactionDay,
    _i2.TransactionType? transactionType,
    double? amount,
    double? tax1,
    double? tax2,
    double? tax3,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'transactionDay': transactionDay.toJson(),
      'transactionType': transactionType.toJson(),
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'description': description,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'guestId': guestId,
      'roomId': roomId,
      'transactionDay': transactionDay,
      'transactionType': transactionType,
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.allToJson(),
      'roomId': roomId,
      if (room != null) 'room': room?.allToJson(),
      'transactionDay': transactionDay.toJson(),
      'transactionType': transactionType.toJson(),
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'description': description,
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
      case 'guestId':
        guestId = value;
        return;
      case 'roomId':
        roomId = value;
        return;
      case 'transactionDay':
        transactionDay = value;
        return;
      case 'transactionType':
        transactionType = value;
        return;
      case 'amount':
        amount = value;
        return;
      case 'tax1':
        tax1 = value;
        return;
      case 'tax2':
        tax2 = value;
        return;
      case 'tax3':
        tax3 = value;
        return;
      case 'description':
        description = value;
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

  static RoomTransactionInclude include({
    _i2.GuestInclude? guest,
    _i2.RoomInclude? room,
  }) {
    return RoomTransactionInclude._(
      guest: guest,
      room: room,
    );
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
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i2.Room? room,
    required DateTime transactionDay,
    required _i2.TransactionType transactionType,
    required double amount,
    required double tax1,
    required double tax2,
    required double tax3,
    required String description,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          roomId: roomId,
          room: room,
          transactionDay: transactionDay,
          transactionType: transactionType,
          amount: amount,
          tax1: tax1,
          tax2: tax2,
          tax3: tax3,
          description: description,
        );

  @override
  RoomTransaction copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    DateTime? transactionDay,
    _i2.TransactionType? transactionType,
    double? amount,
    double? tax1,
    double? tax2,
    double? tax3,
    String? description,
  }) {
    return RoomTransaction(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      transactionDay: transactionDay ?? this.transactionDay,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      tax1: tax1 ?? this.tax1,
      tax2: tax2 ?? this.tax2,
      tax3: tax3 ?? this.tax3,
      description: description ?? this.description,
    );
  }
}

class RoomTransactionTable extends _i1.Table {
  RoomTransactionTable({super.tableRelation})
      : super(tableName: 'room_transaction') {
    guestId = _i1.ColumnInt(
      'guestId',
      this,
    );
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    transactionDay = _i1.ColumnDateTime(
      'transactionDay',
      this,
    );
    transactionType = _i1.ColumnEnum(
      'transactionType',
      this,
      _i1.EnumSerialization.byName,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    tax1 = _i1.ColumnDouble(
      'tax1',
      this,
    );
    tax2 = _i1.ColumnDouble(
      'tax2',
      this,
    );
    tax3 = _i1.ColumnDouble(
      'tax3',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  late final _i1.ColumnInt roomId;

  _i2.RoomTable? _room;

  late final _i1.ColumnDateTime transactionDay;

  late final _i1.ColumnEnum<_i2.TransactionType> transactionType;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnDouble tax1;

  late final _i1.ColumnDouble tax2;

  late final _i1.ColumnDouble tax3;

  late final _i1.ColumnString description;

  _i2.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: RoomTransaction.t.guestId,
      foreignField: _i2.Guest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    return _guest!;
  }

  _i2.RoomTable get room {
    if (_room != null) return _room!;
    _room = _i1.createRelationTable(
      relationFieldName: 'room',
      field: RoomTransaction.t.roomId,
      foreignField: _i2.Room.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomTable(tableRelation: foreignTableRelation),
    );
    return _room!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        guestId,
        roomId,
        transactionDay,
        transactionType,
        amount,
        tax1,
        tax2,
        tax3,
        description,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guest') {
      return guest;
    }
    if (relationField == 'room') {
      return room;
    }
    return null;
  }
}

@Deprecated('Use RoomTransactionTable.t instead.')
RoomTransactionTable tRoomTransaction = RoomTransactionTable();

class RoomTransactionInclude extends _i1.IncludeObject {
  RoomTransactionInclude._({
    _i2.GuestInclude? guest,
    _i2.RoomInclude? room,
  }) {
    _guest = guest;
    _room = room;
  }

  _i2.GuestInclude? _guest;

  _i2.RoomInclude? _room;

  @override
  Map<String, _i1.Include?> get includes => {
        'guest': _guest,
        'room': _room,
      };

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

  final attachRow = const RoomTransactionAttachRowRepository._();

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

class RoomTransactionAttachRowRepository {
  const RoomTransactionAttachRowRepository._();

  Future<void> guest(
    _i1.Session session,
    RoomTransaction roomTransaction,
    _i2.Guest guest,
  ) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomTransaction = roomTransaction.copyWith(guestId: guest.id);
    await session.dbNext.updateRow<RoomTransaction>(
      $roomTransaction,
      columns: [RoomTransaction.t.guestId],
    );
  }

  Future<void> room(
    _i1.Session session,
    RoomTransaction roomTransaction,
    _i2.Room room,
  ) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $roomTransaction = roomTransaction.copyWith(roomId: room.id);
    await session.dbNext.updateRow<RoomTransaction>(
      $roomTransaction,
      columns: [RoomTransaction.t.roomId],
    );
  }
}
