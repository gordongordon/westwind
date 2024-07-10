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

abstract class GuestTransaction extends _i1.TableRow
    implements _i1.ProtocolSerialization {
  GuestTransaction._({
    int? id,
    required this.roomId,
    this.room,
    required this.stateDate,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.roomStatus,
    this.updateDate,
    required this.roomGuestId,
    this.roomGuest,
  }) : super(id);

  factory GuestTransaction({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stateDate,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required _i2.RoomStatus roomStatus,
    DateTime? updateDate,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
  }) = _GuestTransactionImpl;

  factory GuestTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuestTransaction(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i2.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      stateDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stateDate']),
      rateType:
          _i2.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i2.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
      roomStatus:
          _i2.RoomStatus.fromJson((jsonSerialization['roomStatus'] as String)),
      updateDate: jsonSerialization['updateDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateDate']),
      roomGuestId: jsonSerialization['roomGuestId'] as int,
      roomGuest: jsonSerialization['roomGuest'] == null
          ? null
          : _i2.RoomGuest.fromJson(
              (jsonSerialization['roomGuest'] as Map<String, dynamic>)),
    );
  }

  static final t = GuestTransactionTable();

  static const db = GuestTransactionRepository._();

  int roomId;

  _i2.Room? room;

  DateTime stateDate;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  _i2.RoomStatus roomStatus;

  DateTime? updateDate;

  int roomGuestId;

  _i2.RoomGuest? roomGuest;

  @override
  _i1.Table get table => t;

  GuestTransaction copyWith({
    int? id,
    int? roomId,
    _i2.Room? room,
    DateTime? stateDate,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    _i2.RoomStatus? roomStatus,
    DateTime? updateDate,
    int? roomGuestId,
    _i2.RoomGuest? roomGuest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'stateDate': stateDate.toJson(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'roomStatus': roomStatus.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'roomGuestId': roomGuestId,
      if (roomGuest != null) 'roomGuest': roomGuest?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
      'stateDate': stateDate.toJson(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'roomStatus': roomStatus.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'roomGuestId': roomGuestId,
      if (roomGuest != null) 'roomGuest': roomGuest?.toJsonForProtocol(),
    };
  }

  static GuestTransactionInclude include({
    _i2.RoomInclude? room,
    _i2.RoomGuestInclude? roomGuest,
  }) {
    return GuestTransactionInclude._(
      room: room,
      roomGuest: roomGuest,
    );
  }

  static GuestTransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<GuestTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuestTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestTransactionTable>? orderByList,
    GuestTransactionInclude? include,
  }) {
    return GuestTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GuestTransaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GuestTransaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestTransactionImpl extends GuestTransaction {
  _GuestTransactionImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stateDate,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required _i2.RoomStatus roomStatus,
    DateTime? updateDate,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
  }) : super._(
          id: id,
          roomId: roomId,
          room: room,
          stateDate: stateDate,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          roomStatus: roomStatus,
          updateDate: updateDate,
          roomGuestId: roomGuestId,
          roomGuest: roomGuest,
        );

  @override
  GuestTransaction copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    DateTime? stateDate,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    _i2.RoomStatus? roomStatus,
    Object? updateDate = _Undefined,
    int? roomGuestId,
    Object? roomGuest = _Undefined,
  }) {
    return GuestTransaction(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      stateDate: stateDate ?? this.stateDate,
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      roomStatus: roomStatus ?? this.roomStatus,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      roomGuestId: roomGuestId ?? this.roomGuestId,
      roomGuest:
          roomGuest is _i2.RoomGuest? ? roomGuest : this.roomGuest?.copyWith(),
    );
  }
}

class GuestTransactionTable extends _i1.Table {
  GuestTransactionTable({super.tableRelation})
      : super(tableName: 'guest_transaction') {
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    stateDate = _i1.ColumnDateTime(
      'stateDate',
      this,
    );
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
    roomStatus = _i1.ColumnEnum(
      'roomStatus',
      this,
      _i1.EnumSerialization.byName,
    );
    updateDate = _i1.ColumnDateTime(
      'updateDate',
      this,
    );
    roomGuestId = _i1.ColumnInt(
      'roomGuestId',
      this,
    );
  }

  late final _i1.ColumnInt roomId;

  _i2.RoomTable? _room;

  late final _i1.ColumnDateTime stateDate;

  late final _i1.ColumnEnum<_i2.RateType> rateType;

  late final _i1.ColumnEnum<_i2.RateReason> rateReason;

  late final _i1.ColumnDouble rate;

  late final _i1.ColumnEnum<_i2.RoomStatus> roomStatus;

  late final _i1.ColumnDateTime updateDate;

  late final _i1.ColumnInt roomGuestId;

  _i2.RoomGuestTable? _roomGuest;

  _i2.RoomTable get room {
    if (_room != null) return _room!;
    _room = _i1.createRelationTable(
      relationFieldName: 'room',
      field: GuestTransaction.t.roomId,
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
      field: GuestTransaction.t.roomGuestId,
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
        roomId,
        stateDate,
        rateType,
        rateReason,
        rate,
        roomStatus,
        updateDate,
        roomGuestId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'room') {
      return room;
    }
    if (relationField == 'roomGuest') {
      return roomGuest;
    }
    return null;
  }
}

class GuestTransactionInclude extends _i1.IncludeObject {
  GuestTransactionInclude._({
    _i2.RoomInclude? room,
    _i2.RoomGuestInclude? roomGuest,
  }) {
    _room = room;
    _roomGuest = roomGuest;
  }

  _i2.RoomInclude? _room;

  _i2.RoomGuestInclude? _roomGuest;

  @override
  Map<String, _i1.Include?> get includes => {
        'room': _room,
        'roomGuest': _roomGuest,
      };

  @override
  _i1.Table get table => GuestTransaction.t;
}

class GuestTransactionIncludeList extends _i1.IncludeList {
  GuestTransactionIncludeList._({
    _i1.WhereExpressionBuilder<GuestTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GuestTransaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => GuestTransaction.t;
}

class GuestTransactionRepository {
  const GuestTransactionRepository._();

  final attachRow = const GuestTransactionAttachRowRepository._();

  Future<List<GuestTransaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuestTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    GuestTransactionInclude? include,
  }) async {
    return session.db.find<GuestTransaction>(
      where: where?.call(GuestTransaction.t),
      orderBy: orderBy?.call(GuestTransaction.t),
      orderByList: orderByList?.call(GuestTransaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<GuestTransaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<GuestTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    GuestTransactionInclude? include,
  }) async {
    return session.db.findFirstRow<GuestTransaction>(
      where: where?.call(GuestTransaction.t),
      orderBy: orderBy?.call(GuestTransaction.t),
      orderByList: orderByList?.call(GuestTransaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<GuestTransaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    GuestTransactionInclude? include,
  }) async {
    return session.db.findById<GuestTransaction>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<GuestTransaction>> insert(
    _i1.Session session,
    List<GuestTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GuestTransaction>(
      rows,
      transaction: transaction,
    );
  }

  Future<GuestTransaction> insertRow(
    _i1.Session session,
    GuestTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GuestTransaction>(
      row,
      transaction: transaction,
    );
  }

  Future<List<GuestTransaction>> update(
    _i1.Session session,
    List<GuestTransaction> rows, {
    _i1.ColumnSelections<GuestTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GuestTransaction>(
      rows,
      columns: columns?.call(GuestTransaction.t),
      transaction: transaction,
    );
  }

  Future<GuestTransaction> updateRow(
    _i1.Session session,
    GuestTransaction row, {
    _i1.ColumnSelections<GuestTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GuestTransaction>(
      row,
      columns: columns?.call(GuestTransaction.t),
      transaction: transaction,
    );
  }

  Future<List<GuestTransaction>> delete(
    _i1.Session session,
    List<GuestTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GuestTransaction>(
      rows,
      transaction: transaction,
    );
  }

  Future<GuestTransaction> deleteRow(
    _i1.Session session,
    GuestTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GuestTransaction>(
      row,
      transaction: transaction,
    );
  }

  Future<List<GuestTransaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GuestTransaction>(
      where: where(GuestTransaction.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GuestTransaction>(
      where: where?.call(GuestTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class GuestTransactionAttachRowRepository {
  const GuestTransactionAttachRowRepository._();

  Future<void> room(
    _i1.Session session,
    GuestTransaction guestTransaction,
    _i2.Room room,
  ) async {
    if (guestTransaction.id == null) {
      throw ArgumentError.notNull('guestTransaction.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $guestTransaction = guestTransaction.copyWith(roomId: room.id);
    await session.db.updateRow<GuestTransaction>(
      $guestTransaction,
      columns: [GuestTransaction.t.roomId],
    );
  }

  Future<void> roomGuest(
    _i1.Session session,
    GuestTransaction guestTransaction,
    _i2.RoomGuest roomGuest,
  ) async {
    if (guestTransaction.id == null) {
      throw ArgumentError.notNull('guestTransaction.id');
    }
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $guestTransaction =
        guestTransaction.copyWith(roomGuestId: roomGuest.id);
    await session.db.updateRow<GuestTransaction>(
      $guestTransaction,
      columns: [GuestTransaction.t.roomGuestId],
    );
  }
}
