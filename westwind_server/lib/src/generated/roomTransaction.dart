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

abstract class RoomTransaction extends _i1.TableRow
    implements _i1.ProtocolSerialization {
  RoomTransaction._({
    int? id,
    required this.guestId,
    this.guest,
    required this.roomId,
    this.room,
    required this.roomGuestId,
    this.roomGuest,
    required this.stayDay,
    required this.transactionDay,
    required this.transactionType,
    this.updateDate,
    required this.amount,
    required this.tax1,
    required this.tax2,
    required this.tax3,
    required this.total,
    required this.description,
    required this.itemType,
  }) : super(id);

  factory RoomTransaction({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i2.Room? room,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
    required DateTime stayDay,
    required DateTime transactionDay,
    required _i2.TransactionType transactionType,
    DateTime? updateDate,
    required double amount,
    required double tax1,
    required double tax2,
    required double tax3,
    required double total,
    required String description,
    required _i2.ItemType itemType,
  }) = _RoomTransactionImpl;

  factory RoomTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomTransaction(
      id: jsonSerialization['id'] as int?,
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i2.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      roomGuestId: jsonSerialization['roomGuestId'] as int,
      roomGuest: jsonSerialization['roomGuest'] == null
          ? null
          : _i2.RoomGuest.fromJson(
              (jsonSerialization['roomGuest'] as Map<String, dynamic>)),
      stayDay: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stayDay']),
      transactionDay: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['transactionDay']),
      transactionType: _i2.TransactionType.fromJson(
          (jsonSerialization['transactionType'] as String)),
      updateDate: jsonSerialization['updateDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateDate']),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      tax1: (jsonSerialization['tax1'] as num).toDouble(),
      tax2: (jsonSerialization['tax2'] as num).toDouble(),
      tax3: (jsonSerialization['tax3'] as num).toDouble(),
      total: (jsonSerialization['total'] as num).toDouble(),
      description: jsonSerialization['description'] as String,
      itemType:
          _i2.ItemType.fromJson((jsonSerialization['itemType'] as String)),
    );
  }

  static final t = RoomTransactionTable();

  static const db = RoomTransactionRepository._();

  int guestId;

  _i2.Guest? guest;

  int roomId;

  _i2.Room? room;

  int roomGuestId;

  _i2.RoomGuest? roomGuest;

  DateTime stayDay;

  DateTime transactionDay;

  _i2.TransactionType transactionType;

  DateTime? updateDate;

  double amount;

  double tax1;

  double tax2;

  double tax3;

  double total;

  String description;

  _i2.ItemType itemType;

  @override
  _i1.Table get table => t;

  RoomTransaction copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    int? roomId,
    _i2.Room? room,
    int? roomGuestId,
    _i2.RoomGuest? roomGuest,
    DateTime? stayDay,
    DateTime? transactionDay,
    _i2.TransactionType? transactionType,
    DateTime? updateDate,
    double? amount,
    double? tax1,
    double? tax2,
    double? tax3,
    double? total,
    String? description,
    _i2.ItemType? itemType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'roomGuestId': roomGuestId,
      if (roomGuest != null) 'roomGuest': roomGuest?.toJson(),
      'stayDay': stayDay.toJson(),
      'transactionDay': transactionDay.toJson(),
      'transactionType': transactionType.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'total': total,
      'description': description,
      'itemType': itemType.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
      'roomGuestId': roomGuestId,
      if (roomGuest != null) 'roomGuest': roomGuest?.toJsonForProtocol(),
      'stayDay': stayDay.toJson(),
      'transactionDay': transactionDay.toJson(),
      'transactionType': transactionType.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'total': total,
      'description': description,
      'itemType': itemType.toJson(),
    };
  }

  static RoomTransactionInclude include({
    _i2.GuestInclude? guest,
    _i2.RoomInclude? room,
    _i2.RoomGuestInclude? roomGuest,
  }) {
    return RoomTransactionInclude._(
      guest: guest,
      room: room,
      roomGuest: roomGuest,
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
    required DateTime stayDay,
    required DateTime transactionDay,
    required _i2.TransactionType transactionType,
    DateTime? updateDate,
    required double amount,
    required double tax1,
    required double tax2,
    required double tax3,
    required double total,
    required String description,
    required _i2.ItemType itemType,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          roomId: roomId,
          room: room,
          roomGuestId: roomGuestId,
          roomGuest: roomGuest,
          stayDay: stayDay,
          transactionDay: transactionDay,
          transactionType: transactionType,
          updateDate: updateDate,
          amount: amount,
          tax1: tax1,
          tax2: tax2,
          tax3: tax3,
          total: total,
          description: description,
          itemType: itemType,
        );

  @override
  RoomTransaction copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    int? roomGuestId,
    Object? roomGuest = _Undefined,
    DateTime? stayDay,
    DateTime? transactionDay,
    _i2.TransactionType? transactionType,
    Object? updateDate = _Undefined,
    double? amount,
    double? tax1,
    double? tax2,
    double? tax3,
    double? total,
    String? description,
    _i2.ItemType? itemType,
  }) {
    return RoomTransaction(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      roomGuestId: roomGuestId ?? this.roomGuestId,
      roomGuest:
          roomGuest is _i2.RoomGuest? ? roomGuest : this.roomGuest?.copyWith(),
      stayDay: stayDay ?? this.stayDay,
      transactionDay: transactionDay ?? this.transactionDay,
      transactionType: transactionType ?? this.transactionType,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      amount: amount ?? this.amount,
      tax1: tax1 ?? this.tax1,
      tax2: tax2 ?? this.tax2,
      tax3: tax3 ?? this.tax3,
      total: total ?? this.total,
      description: description ?? this.description,
      itemType: itemType ?? this.itemType,
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
    roomGuestId = _i1.ColumnInt(
      'roomGuestId',
      this,
    );
    stayDay = _i1.ColumnDateTime(
      'stayDay',
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
    updateDate = _i1.ColumnDateTime(
      'updateDate',
      this,
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
    total = _i1.ColumnDouble(
      'total',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    itemType = _i1.ColumnEnum(
      'itemType',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  late final _i1.ColumnInt roomId;

  _i2.RoomTable? _room;

  late final _i1.ColumnInt roomGuestId;

  _i2.RoomGuestTable? _roomGuest;

  late final _i1.ColumnDateTime stayDay;

  late final _i1.ColumnDateTime transactionDay;

  late final _i1.ColumnEnum<_i2.TransactionType> transactionType;

  late final _i1.ColumnDateTime updateDate;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnDouble tax1;

  late final _i1.ColumnDouble tax2;

  late final _i1.ColumnDouble tax3;

  late final _i1.ColumnDouble total;

  late final _i1.ColumnString description;

  late final _i1.ColumnEnum<_i2.ItemType> itemType;

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

  _i2.RoomGuestTable get roomGuest {
    if (_roomGuest != null) return _roomGuest!;
    _roomGuest = _i1.createRelationTable(
      relationFieldName: 'roomGuest',
      field: RoomTransaction.t.roomGuestId,
      foreignField: _i2.RoomGuest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomGuestTable(tableRelation: foreignTableRelation),
    );
    return _roomGuest!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        guestId,
        roomId,
        roomGuestId,
        stayDay,
        transactionDay,
        transactionType,
        updateDate,
        amount,
        tax1,
        tax2,
        tax3,
        total,
        description,
        itemType,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guest') {
      return guest;
    }
    if (relationField == 'room') {
      return room;
    }
    if (relationField == 'roomGuest') {
      return roomGuest;
    }
    return null;
  }
}

class RoomTransactionInclude extends _i1.IncludeObject {
  RoomTransactionInclude._({
    _i2.GuestInclude? guest,
    _i2.RoomInclude? room,
    _i2.RoomGuestInclude? roomGuest,
  }) {
    _guest = guest;
    _room = room;
    _roomGuest = roomGuest;
  }

  _i2.GuestInclude? _guest;

  _i2.RoomInclude? _room;

  _i2.RoomGuestInclude? _roomGuest;

  @override
  Map<String, _i1.Include?> get includes => {
        'guest': _guest,
        'room': _room,
        'roomGuest': _roomGuest,
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
    return session.db.find<RoomTransaction>(
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
    return session.db.findFirstRow<RoomTransaction>(
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
    return session.db.findById<RoomTransaction>(
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
    return session.db.insert<RoomTransaction>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomTransaction> insertRow(
    _i1.Session session,
    RoomTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomTransaction>(
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
    return session.db.update<RoomTransaction>(
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
    return session.db.updateRow<RoomTransaction>(
      row,
      columns: columns?.call(RoomTransaction.t),
      transaction: transaction,
    );
  }

  Future<List<RoomTransaction>> delete(
    _i1.Session session,
    List<RoomTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomTransaction>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomTransaction> deleteRow(
    _i1.Session session,
    RoomTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomTransaction>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoomTransaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomTransaction>(
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
    return session.db.count<RoomTransaction>(
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
    await session.db.updateRow<RoomTransaction>(
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
    await session.db.updateRow<RoomTransaction>(
      $roomTransaction,
      columns: [RoomTransaction.t.roomId],
    );
  }

  Future<void> roomGuest(
    _i1.Session session,
    RoomTransaction roomTransaction,
    _i2.RoomGuest roomGuest,
  ) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomTransaction = roomTransaction.copyWith(roomGuestId: roomGuest.id);
    await session.db.updateRow<RoomTransaction>(
      $roomTransaction,
      columns: [RoomTransaction.t.roomGuestId],
    );
  }
}
