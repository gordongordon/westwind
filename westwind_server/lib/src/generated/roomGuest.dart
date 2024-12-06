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
import 'room.dart' as _i2;
import 'guest.dart' as _i3;
import 'roomTransaction.dart' as _i4;
import 'rateType.dart' as _i5;
import 'rateReason.dart' as _i6;
import 'reservation.dart' as _i7;
import 'roomStatus.dart' as _i8;

abstract class RoomGuest implements _i1.TableRow, _i1.ProtocolSerialization {
  RoomGuest._({
    this.id,
    required this.roomId,
    this.room,
    required this.stayDay,
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
  });

  factory RoomGuest({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDay,
    required int guestId,
    _i3.Guest? guest,
    List<_i4.RoomTransaction>? roomTransactions,
    required _i5.RateType rateType,
    required _i6.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i7.Reservation? reservation,
    required _i8.RoomStatus roomStatus,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    DateTime? updateDate,
    required bool isCheckOut,
  }) = _RoomGuestImpl;

  factory RoomGuest.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomGuest(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i2.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      stayDay: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stayDay']),
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i3.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      roomTransactions: (jsonSerialization['roomTransactions'] as List?)
          ?.map(
              (e) => _i4.RoomTransaction.fromJson((e as Map<String, dynamic>)))
          .toList(),
      rateType:
          _i5.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i6.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
      reservationId: jsonSerialization['reservationId'] as int,
      reservation: jsonSerialization['reservation'] == null
          ? null
          : _i7.Reservation.fromJson(
              (jsonSerialization['reservation'] as Map<String, dynamic>)),
      roomStatus:
          _i8.RoomStatus.fromJson((jsonSerialization['roomStatus'] as String)),
      checkInDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkInDate']),
      checkOutDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkOutDate']),
      updateDate: jsonSerialization['updateDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateDate']),
      isCheckOut: jsonSerialization['isCheckOut'] as bool,
    );
  }

  static final t = RoomGuestTable();

  static const db = RoomGuestRepository._();

  @override
  int? id;

  int roomId;

  _i2.Room? room;

  DateTime stayDay;

  int guestId;

  _i3.Guest? guest;

  List<_i4.RoomTransaction>? roomTransactions;

  _i5.RateType rateType;

  _i6.RateReason rateReason;

  double rate;

  int reservationId;

  _i7.Reservation? reservation;

  _i8.RoomStatus roomStatus;

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
    DateTime? stayDay,
    int? guestId,
    _i3.Guest? guest,
    List<_i4.RoomTransaction>? roomTransactions,
    _i5.RateType? rateType,
    _i6.RateReason? rateReason,
    double? rate,
    int? reservationId,
    _i7.Reservation? reservation,
    _i8.RoomStatus? roomStatus,
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
      'stayDay': stayDay.toJson(),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
      'stayDay': stayDay.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      if (roomTransactions != null)
        'roomTransactions':
            roomTransactions?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'reservationId': reservationId,
      if (reservation != null) 'reservation': reservation?.toJsonForProtocol(),
      'roomStatus': roomStatus.toJson(),
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'isCheckOut': isCheckOut,
    };
  }

  static RoomGuestInclude include({
    _i2.RoomInclude? room,
    _i3.GuestInclude? guest,
    _i4.RoomTransactionIncludeList? roomTransactions,
    _i7.ReservationInclude? reservation,
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomGuestImpl extends RoomGuest {
  _RoomGuestImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDay,
    required int guestId,
    _i3.Guest? guest,
    List<_i4.RoomTransaction>? roomTransactions,
    required _i5.RateType rateType,
    required _i6.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i7.Reservation? reservation,
    required _i8.RoomStatus roomStatus,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    DateTime? updateDate,
    required bool isCheckOut,
  }) : super._(
          id: id,
          roomId: roomId,
          room: room,
          stayDay: stayDay,
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
    DateTime? stayDay,
    int? guestId,
    Object? guest = _Undefined,
    Object? roomTransactions = _Undefined,
    _i5.RateType? rateType,
    _i6.RateReason? rateReason,
    double? rate,
    int? reservationId,
    Object? reservation = _Undefined,
    _i8.RoomStatus? roomStatus,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    Object? updateDate = _Undefined,
    bool? isCheckOut,
  }) {
    return RoomGuest(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      stayDay: stayDay ?? this.stayDay,
      guestId: guestId ?? this.guestId,
      guest: guest is _i3.Guest? ? guest : this.guest?.copyWith(),
      roomTransactions: roomTransactions is List<_i4.RoomTransaction>?
          ? roomTransactions
          : this.roomTransactions?.map((e0) => e0.copyWith()).toList(),
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      reservationId: reservationId ?? this.reservationId,
      reservation: reservation is _i7.Reservation?
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
    stayDay = _i1.ColumnDateTime(
      'stayDay',
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

  late final _i1.ColumnDateTime stayDay;

  late final _i1.ColumnInt guestId;

  _i3.GuestTable? _guest;

  _i4.RoomTransactionTable? ___roomTransactions;

  _i1.ManyRelation<_i4.RoomTransactionTable>? _roomTransactions;

  late final _i1.ColumnEnum<_i5.RateType> rateType;

  late final _i1.ColumnEnum<_i6.RateReason> rateReason;

  late final _i1.ColumnDouble rate;

  late final _i1.ColumnInt reservationId;

  _i7.ReservationTable? _reservation;

  late final _i1.ColumnEnum<_i8.RoomStatus> roomStatus;

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

  _i3.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: RoomGuest.t.guestId,
      foreignField: _i3.Guest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.GuestTable(tableRelation: foreignTableRelation),
    );
    return _guest!;
  }

  _i4.RoomTransactionTable get __roomTransactions {
    if (___roomTransactions != null) return ___roomTransactions!;
    ___roomTransactions = _i1.createRelationTable(
      relationFieldName: '__roomTransactions',
      field: RoomGuest.t.id,
      foreignField: _i4.RoomTransaction.t.roomGuestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RoomTransactionTable(tableRelation: foreignTableRelation),
    );
    return ___roomTransactions!;
  }

  _i7.ReservationTable get reservation {
    if (_reservation != null) return _reservation!;
    _reservation = _i1.createRelationTable(
      relationFieldName: 'reservation',
      field: RoomGuest.t.reservationId,
      foreignField: _i7.Reservation.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.ReservationTable(tableRelation: foreignTableRelation),
    );
    return _reservation!;
  }

  _i1.ManyRelation<_i4.RoomTransactionTable> get roomTransactions {
    if (_roomTransactions != null) return _roomTransactions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'roomTransactions',
      field: RoomGuest.t.id,
      foreignField: _i4.RoomTransaction.t.roomGuestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RoomTransactionTable(tableRelation: foreignTableRelation),
    );
    _roomTransactions = _i1.ManyRelation<_i4.RoomTransactionTable>(
      tableWithRelations: relationTable,
      table: _i4.RoomTransactionTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _roomTransactions!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        stayDay,
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

class RoomGuestInclude extends _i1.IncludeObject {
  RoomGuestInclude._({
    _i2.RoomInclude? room,
    _i3.GuestInclude? guest,
    _i4.RoomTransactionIncludeList? roomTransactions,
    _i7.ReservationInclude? reservation,
  }) {
    _room = room;
    _guest = guest;
    _roomTransactions = roomTransactions;
    _reservation = reservation;
  }

  _i2.RoomInclude? _room;

  _i3.GuestInclude? _guest;

  _i4.RoomTransactionIncludeList? _roomTransactions;

  _i7.ReservationInclude? _reservation;

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
    return session.db.find<RoomGuest>(
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
    return session.db.findFirstRow<RoomGuest>(
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
    return session.db.findById<RoomGuest>(
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
    return session.db.insert<RoomGuest>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomGuest> insertRow(
    _i1.Session session,
    RoomGuest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomGuest>(
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
    return session.db.update<RoomGuest>(
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
    return session.db.updateRow<RoomGuest>(
      row,
      columns: columns?.call(RoomGuest.t),
      transaction: transaction,
    );
  }

  Future<List<RoomGuest>> delete(
    _i1.Session session,
    List<RoomGuest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomGuest>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomGuest> deleteRow(
    _i1.Session session,
    RoomGuest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomGuest>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoomGuest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomGuestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomGuest>(
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
    return session.db.count<RoomGuest>(
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
    List<_i4.RoomTransaction> roomTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (roomTransaction.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomTransaction = roomTransaction
        .map((e) => e.copyWith(roomGuestId: roomGuest.id))
        .toList();
    await session.db.update<_i4.RoomTransaction>(
      $roomTransaction,
      columns: [_i4.RoomTransaction.t.roomGuestId],
      transaction: transaction,
    );
  }
}

class RoomGuestAttachRowRepository {
  const RoomGuestAttachRowRepository._();

  Future<void> room(
    _i1.Session session,
    RoomGuest roomGuest,
    _i2.Room room, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $roomGuest = roomGuest.copyWith(roomId: room.id);
    await session.db.updateRow<RoomGuest>(
      $roomGuest,
      columns: [RoomGuest.t.roomId],
      transaction: transaction,
    );
  }

  Future<void> guest(
    _i1.Session session,
    RoomGuest roomGuest,
    _i3.Guest guest, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomGuest = roomGuest.copyWith(guestId: guest.id);
    await session.db.updateRow<RoomGuest>(
      $roomGuest,
      columns: [RoomGuest.t.guestId],
      transaction: transaction,
    );
  }

  Future<void> reservation(
    _i1.Session session,
    RoomGuest roomGuest,
    _i7.Reservation reservation, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $roomGuest = roomGuest.copyWith(reservationId: reservation.id);
    await session.db.updateRow<RoomGuest>(
      $roomGuest,
      columns: [RoomGuest.t.reservationId],
      transaction: transaction,
    );
  }

  Future<void> roomTransactions(
    _i1.Session session,
    RoomGuest roomGuest,
    _i4.RoomTransaction roomTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomTransaction = roomTransaction.copyWith(roomGuestId: roomGuest.id);
    await session.db.updateRow<_i4.RoomTransaction>(
      $roomTransaction,
      columns: [_i4.RoomTransaction.t.roomGuestId],
      transaction: transaction,
    );
  }
}

class RoomGuestDetachRepository {
  const RoomGuestDetachRepository._();

  Future<void> roomTransactions(
    _i1.Session session,
    List<_i4.RoomTransaction> roomTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (roomTransaction.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomTransaction.id');
    }

    var $roomTransaction =
        roomTransaction.map((e) => e.copyWith(roomGuestId: null)).toList();
    await session.db.update<_i4.RoomTransaction>(
      $roomTransaction,
      columns: [_i4.RoomTransaction.t.roomGuestId],
      transaction: transaction,
    );
  }
}

class RoomGuestDetachRowRepository {
  const RoomGuestDetachRowRepository._();

  Future<void> roomTransactions(
    _i1.Session session,
    _i4.RoomTransaction roomTransaction, {
    _i1.Transaction? transaction,
  }) async {
    if (roomTransaction.id == null) {
      throw ArgumentError.notNull('roomTransaction.id');
    }

    var $roomTransaction = roomTransaction.copyWith(roomGuestId: null);
    await session.db.updateRow<_i4.RoomTransaction>(
      $roomTransaction,
      columns: [_i4.RoomTransaction.t.roomGuestId],
      transaction: transaction,
    );
  }
}
