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

abstract class RoomGuest extends _i1.TableRow {
  RoomGuest._({
    int? id,
    required this.roomId,
    this.room,
    required this.stayDate,
    required this.guestId,
    this.guest,
    this.roomTransactions,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.reservationId,
    this.reservation,
    required this.roomStatus,
    required this.checkInDate,
    required this.checkOutDate,
    this.updateDate,
    required this.isCheckOut,
  }) : super(id);

  factory RoomGuest({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDate,
    required int guestId,
    _i2.Guest? guest,
    List<_i2.RoomTransaction>? roomTransactions,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i2.Reservation? reservation,
    required _i2.RoomStatus roomStatus,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    DateTime? updateDate,
    required bool isCheckOut,
  }) = _RoomGuestImpl;

  factory RoomGuest.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomGuest(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomId:
          serializationManager.deserialize<int>(jsonSerialization['roomId']),
      room: serializationManager
          .deserialize<_i2.Room?>(jsonSerialization['room']),
      stayDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['stayDate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      roomTransactions:
          serializationManager.deserialize<List<_i2.RoomTransaction>?>(
              jsonSerialization['roomTransactions']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      rateReason: serializationManager
          .deserialize<_i2.RateReason>(jsonSerialization['rateReason']),
      rate: serializationManager.deserialize<double>(jsonSerialization['rate']),
      reservationId: serializationManager
          .deserialize<int>(jsonSerialization['reservationId']),
      reservation: serializationManager
          .deserialize<_i2.Reservation?>(jsonSerialization['reservation']),
      roomStatus: serializationManager
          .deserialize<_i2.RoomStatus>(jsonSerialization['roomStatus']),
      checkInDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['checkInDate']),
      checkOutDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['checkOutDate']),
      updateDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['updateDate']),
      isCheckOut: serializationManager
          .deserialize<bool>(jsonSerialization['isCheckOut']),
    );
  }

  static final t = RoomGuestTable();

  static const db = RoomGuestRepository._();

  int roomId;

  _i2.Room? room;

  DateTime stayDate;

  int guestId;

  _i2.Guest? guest;

  List<_i2.RoomTransaction>? roomTransactions;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  int reservationId;

  _i2.Reservation? reservation;

  _i2.RoomStatus roomStatus;

  DateTime checkInDate;

  DateTime checkOutDate;

  DateTime? updateDate;

  bool isCheckOut;

  @override
  _i1.Table get table => t;

  RoomGuest copyWith({
    int? id,
    int? roomId,
    _i2.Room? room,
    DateTime? stayDate,
    int? guestId,
    _i2.Guest? guest,
    List<_i2.RoomTransaction>? roomTransactions,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    int? reservationId,
    _i2.Reservation? reservation,
    _i2.RoomStatus? roomStatus,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    DateTime? updateDate,
    bool? isCheckOut,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'stayDate': stayDate.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      if (roomTransactions != null)
        'roomTransactions':
            roomTransactions?.toJson(valueToJson: (v) => v.toJson()),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'reservationId': reservationId,
      if (reservation != null) 'reservation': reservation?.toJson(),
      'roomStatus': roomStatus.toJson(),
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'isCheckOut': isCheckOut,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'roomId': roomId,
      'stayDate': stayDate,
      'guestId': guestId,
      'rateType': rateType,
      'rateReason': rateReason,
      'rate': rate,
      'reservationId': reservationId,
      'roomStatus': roomStatus,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'updateDate': updateDate,
      'isCheckOut': isCheckOut,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.allToJson(),
      'stayDate': stayDate.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.allToJson(),
      if (roomTransactions != null)
        'roomTransactions':
            roomTransactions?.toJson(valueToJson: (v) => v.allToJson()),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'reservationId': reservationId,
      if (reservation != null) 'reservation': reservation?.allToJson(),
      'roomStatus': roomStatus.toJson(),
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'isCheckOut': isCheckOut,
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
      case 'roomId':
        roomId = value;
        return;
      case 'stayDate':
        stayDate = value;
        return;
      case 'guestId':
        guestId = value;
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
      case 'reservationId':
        reservationId = value;
        return;
      case 'roomStatus':
        roomStatus = value;
        return;
      case 'checkInDate':
        checkInDate = value;
        return;
      case 'checkOutDate':
        checkOutDate = value;
        return;
      case 'updateDate':
        updateDate = value;
        return;
      case 'isCheckOut':
        isCheckOut = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<RoomGuest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomGuestInclude? include,
  }) async {
    return session.db.find<RoomGuest>(
      where: where != null ? where(RoomGuest.t) : null,
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
  static Future<RoomGuest?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomGuestInclude? include,
  }) async {
    return session.db.findSingleRow<RoomGuest>(
      where: where != null ? where(RoomGuest.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<RoomGuest?> findById(
    _i1.Session session,
    int id, {
    RoomGuestInclude? include,
  }) async {
    return session.db.findById<RoomGuest>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomGuestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomGuest>(
      where: where(RoomGuest.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    RoomGuest row, {
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
    RoomGuest row, {
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
    RoomGuest row, {
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
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomGuest>(
      where: where != null ? where(RoomGuest.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static RoomGuestInclude include({
    _i2.RoomInclude? room,
    _i2.GuestInclude? guest,
    _i2.RoomTransactionIncludeList? roomTransactions,
    _i2.ReservationInclude? reservation,
  }) {
    return RoomGuestInclude._(
      room: room,
      guest: guest,
      roomTransactions: roomTransactions,
      reservation: reservation,
    );
  }

  static RoomGuestIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomGuestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomGuestTable>? orderByList,
    RoomGuestInclude? include,
  }) {
    return RoomGuestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomGuest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomGuest.t),
      include: include,
    );
  }
}

class _Undefined {}

class _RoomGuestImpl extends RoomGuest {
  _RoomGuestImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDate,
    required int guestId,
    _i2.Guest? guest,
    List<_i2.RoomTransaction>? roomTransactions,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i2.Reservation? reservation,
    required _i2.RoomStatus roomStatus,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    DateTime? updateDate,
    required bool isCheckOut,
  }) : super._(
          id: id,
          roomId: roomId,
          room: room,
          stayDate: stayDate,
          guestId: guestId,
          guest: guest,
          roomTransactions: roomTransactions,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          reservationId: reservationId,
          reservation: reservation,
          roomStatus: roomStatus,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          updateDate: updateDate,
          isCheckOut: isCheckOut,
        );

  @override
  RoomGuest copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    DateTime? stayDate,
    int? guestId,
    Object? guest = _Undefined,
    Object? roomTransactions = _Undefined,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    int? reservationId,
    Object? reservation = _Undefined,
    _i2.RoomStatus? roomStatus,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    Object? updateDate = _Undefined,
    bool? isCheckOut,
  }) {
    return RoomGuest(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      stayDate: stayDate ?? this.stayDate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomTransactions: roomTransactions is List<_i2.RoomTransaction>?
          ? roomTransactions
          : this.roomTransactions?.clone(),
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      reservationId: reservationId ?? this.reservationId,
      reservation: reservation is _i2.Reservation?
          ? reservation
          : this.reservation?.copyWith(),
      roomStatus: roomStatus ?? this.roomStatus,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      isCheckOut: isCheckOut ?? this.isCheckOut,
    );
  }
}

class RoomGuestTable extends _i1.Table {
  RoomGuestTable({super.tableRelation}) : super(tableName: 'room_guest') {
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    stayDate = _i1.ColumnDateTime(
      'stayDate',
      this,
    );
    guestId = _i1.ColumnInt(
      'guestId',
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
    reservationId = _i1.ColumnInt(
      'reservationId',
      this,
    );
    roomStatus = _i1.ColumnEnum(
      'roomStatus',
      this,
      _i1.EnumSerialization.byName,
    );
    checkInDate = _i1.ColumnDateTime(
      'checkInDate',
      this,
    );
    checkOutDate = _i1.ColumnDateTime(
      'checkOutDate',
      this,
    );
    updateDate = _i1.ColumnDateTime(
      'updateDate',
      this,
    );
    isCheckOut = _i1.ColumnBool(
      'isCheckOut',
      this,
    );
  }

  late final _i1.ColumnInt roomId;

  _i2.RoomTable? _room;

  late final _i1.ColumnDateTime stayDate;

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  _i2.RoomTransactionTable? ___roomTransactions;

  _i1.ManyRelation<_i2.RoomTransactionTable>? _roomTransactions;

  late final _i1.ColumnEnum<_i2.RateType> rateType;

  late final _i1.ColumnEnum<_i2.RateReason> rateReason;

  late final _i1.ColumnDouble rate;

  late final _i1.ColumnInt reservationId;

  _i2.ReservationTable? _reservation;

  late final _i1.ColumnEnum<_i2.RoomStatus> roomStatus;

  late final _i1.ColumnDateTime checkInDate;

  late final _i1.ColumnDateTime checkOutDate;

  late final _i1.ColumnDateTime updateDate;

  late final _i1.ColumnBool isCheckOut;

  _i2.RoomTable get room {
    if (_room != null) return _room!;
    _room = _i1.createRelationTable(
      relationFieldName: 'room',
      field: RoomGuest.t.roomId,
      foreignField: _i2.Room.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomTable(tableRelation: foreignTableRelation),
    );
    return _room!;
  }

  _i2.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: RoomGuest.t.guestId,
      foreignField: _i2.Guest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    return _guest!;
  }

  _i2.RoomTransactionTable get __roomTransactions {
    if (___roomTransactions != null) return ___roomTransactions!;
    ___roomTransactions = _i1.createRelationTable(
      relationFieldName: '__roomTransactions',
      field: RoomGuest.t.id,
      foreignField: _i2.RoomTransaction.t.roomGuestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomTransactionTable(tableRelation: foreignTableRelation),
    );
    return ___roomTransactions!;
  }

  _i2.ReservationTable get reservation {
    if (_reservation != null) return _reservation!;
    _reservation = _i1.createRelationTable(
      relationFieldName: 'reservation',
      field: RoomGuest.t.reservationId,
      foreignField: _i2.Reservation.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ReservationTable(tableRelation: foreignTableRelation),
    );
    return _reservation!;
  }

  _i1.ManyRelation<_i2.RoomTransactionTable> get roomTransactions {
    if (_roomTransactions != null) return _roomTransactions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'roomTransactions',
      field: RoomGuest.t.id,
      foreignField: _i2.RoomTransaction.t.roomGuestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomTransactionTable(tableRelation: foreignTableRelation),
    );
    _roomTransactions = _i1.ManyRelation<_i2.RoomTransactionTable>(
      tableWithRelations: relationTable,
      table: _i2.RoomTransactionTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _roomTransactions!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        stayDate,
        guestId,
        rateType,
        rateReason,
        rate,
        reservationId,
        roomStatus,
        checkInDate,
        checkOutDate,
        updateDate,
        isCheckOut,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'room') {
      return room;
    }
    if (relationField == 'guest') {
      return guest;
    }
    if (relationField == 'roomTransactions') {
      return __roomTransactions;
    }
    if (relationField == 'reservation') {
      return reservation;
    }
    return null;
  }
}

@Deprecated('Use RoomGuestTable.t instead.')
RoomGuestTable tRoomGuest = RoomGuestTable();

class RoomGuestInclude extends _i1.IncludeObject {
  RoomGuestInclude._({
    _i2.RoomInclude? room,
    _i2.GuestInclude? guest,
    _i2.RoomTransactionIncludeList? roomTransactions,
    _i2.ReservationInclude? reservation,
  }) {
    _room = room;
    _guest = guest;
    _roomTransactions = roomTransactions;
    _reservation = reservation;
  }

  _i2.RoomInclude? _room;

  _i2.GuestInclude? _guest;

  _i2.RoomTransactionIncludeList? _roomTransactions;

  _i2.ReservationInclude? _reservation;

  @override
  Map<String, _i1.Include?> get includes => {
        'room': _room,
        'guest': _guest,
        'roomTransactions': _roomTransactions,
        'reservation': _reservation,
      };

  @override
  _i1.Table get table => RoomGuest.t;
}

class RoomGuestIncludeList extends _i1.IncludeList {
  RoomGuestIncludeList._({
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomGuest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RoomGuest.t;
}

class RoomGuestRepository {
  const RoomGuestRepository._();

  final attach = const RoomGuestAttachRepository._();

  final attachRow = const RoomGuestAttachRowRepository._();

  final detach = const RoomGuestDetachRepository._();

  final detachRow = const RoomGuestDetachRowRepository._();

  Future<List<RoomGuest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomGuestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomGuestTable>? orderByList,
    _i1.Transaction? transaction,
    RoomGuestInclude? include,
  }) async {
    return session.dbNext.find<RoomGuest>(
      where: where?.call(RoomGuest.t),
      orderBy: orderBy?.call(RoomGuest.t),
      orderByList: orderByList?.call(RoomGuest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoomGuest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomGuestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomGuestTable>? orderByList,
    _i1.Transaction? transaction,
    RoomGuestInclude? include,
  }) async {
    return session.dbNext.findFirstRow<RoomGuest>(
      where: where?.call(RoomGuest.t),
      orderBy: orderBy?.call(RoomGuest.t),
      orderByList: orderByList?.call(RoomGuest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoomGuest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoomGuestInclude? include,
  }) async {
    return session.dbNext.findById<RoomGuest>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<RoomGuest>> insert(
    _i1.Session session,
    List<RoomGuest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<RoomGuest>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomGuest> insertRow(
    _i1.Session session,
    RoomGuest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<RoomGuest>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoomGuest>> update(
    _i1.Session session,
    List<RoomGuest> rows, {
    _i1.ColumnSelections<RoomGuestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<RoomGuest>(
      rows,
      columns: columns?.call(RoomGuest.t),
      transaction: transaction,
    );
  }

  Future<RoomGuest> updateRow(
    _i1.Session session,
    RoomGuest row, {
    _i1.ColumnSelections<RoomGuestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<RoomGuest>(
      row,
      columns: columns?.call(RoomGuest.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<RoomGuest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<RoomGuest>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    RoomGuest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<RoomGuest>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomGuestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<RoomGuest>(
      where: where(RoomGuest.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomGuestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<RoomGuest>(
      where: where?.call(RoomGuest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RoomGuestAttachRepository {
  const RoomGuestAttachRepository._();

  Future<void> roomTransactions(
    _i1.Session session,
    RoomGuest roomGuest,
    List<_i2.RoomTransaction> roomTransaction,
  ) async {
    if (roomTransaction.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomTransaction = roomTransaction
        .map((e) => e.copyWith(roomGuestId: roomGuest.id))
        .toList();
    await session.dbNext.update<_i2.RoomTransaction>(
      $roomTransaction,
      columns: [_i2.RoomTransaction.t.roomGuestId],
    );
  }
}

class RoomGuestAttachRowRepository {
  const RoomGuestAttachRowRepository._();

  Future<void> room(
    _i1.Session session,
    RoomGuest roomGuest,
    _i2.Room room,
  ) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $roomGuest = roomGuest.copyWith(roomId: room.id);
    await session.dbNext.updateRow<RoomGuest>(
      $roomGuest,
      columns: [RoomGuest.t.roomId],
    );
  }

  Future<void> guest(
    _i1.Session session,
    RoomGuest roomGuest,
    _i2.Guest guest,
  ) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomGuest = roomGuest.copyWith(guestId: guest.id);
    await session.dbNext.updateRow<RoomGuest>(
      $roomGuest,
      columns: [RoomGuest.t.guestId],
    );
  }

  Future<void> reservation(
    _i1.Session session,
    RoomGuest roomGuest,
    _i2.Reservation reservation,
  ) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $roomGuest = roomGuest.copyWith(reservationId: reservation.id);
    await session.dbNext.updateRow<RoomGuest>(
      $roomGuest,
      columns: [RoomGuest.t.reservationId],
    );
  }

  Future<void> roomTransactions(
    _i1.Session session,
    RoomGuest roomGuest,
    _i2.RoomTransaction roomTransaction,
  ) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomTransaction = roomTransaction.copyWith(roomGuestId: roomGuest.id);
    await session.dbNext.updateRow<_i2.RoomTransaction>(
      $roomTransaction,
      columns: [_i2.RoomTransaction.t.roomGuestId],
    );
  }
}

class RoomGuestDetachRepository {
  const RoomGuestDetachRepository._();

  Future<void> roomTransactions(
    _i1.Session session,
    List<_i2.RoomTransaction> roomTransaction,
  ) async {
    if (roomTransaction.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomTransaction.id');
    }

    var $roomTransaction =
        roomTransaction.map((e) => e.copyWith(roomGuestId: null)).toList();
    await session.dbNext.update<_i2.RoomTransaction>(
      $roomTransaction,
      columns: [_i2.RoomTransaction.t.roomGuestId],
    );
  }
}

class RoomGuestDetachRowRepository {
  const RoomGuestDetachRowRepository._();

  Future<void> roomTransactions(
    _i1.Session session,
    _i2.RoomTransaction roomTransaction,
  ) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }

    var $roomTransaction = roomTransaction.copyWith(roomGuestId: null);
    await session.dbNext.updateRow<_i2.RoomTransaction>(
      $roomTransaction,
      columns: [_i2.RoomTransaction.t.roomGuestId],
    );
  }
}
