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

abstract class Reservation extends _i1.TableRow
    implements _i1.ProtocolSerialization {
  Reservation._({
    int? id,
    required this.checkInDate,
    required this.checkOutDate,
    required this.stayDay,
    this.note,
    required this.dateCreate,
    this.dateUpdate,
    required this.guestId,
    this.guest,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.isCheckedIn,
    required this.isCanceled,
    required this.isNightShift,
    required this.roomId,
    this.room,
  }) : super(id);

  factory Reservation({
    int? id,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required DateTime stayDay,
    String? note,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i2.Room? room,
  }) = _ReservationImpl;

  factory Reservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reservation(
      id: jsonSerialization['id'] as int?,
      checkInDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkInDate']),
      checkOutDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkOutDate']),
      stayDay: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stayDay']),
      note: jsonSerialization['note'] as String?,
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      rateType:
          _i2.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i2.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
      isCheckedIn: jsonSerialization['isCheckedIn'] as bool,
      isCanceled: jsonSerialization['isCanceled'] as bool,
      isNightShift: jsonSerialization['isNightShift'] as bool,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i2.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
    );
  }

  static final t = ReservationTable();

  static const db = ReservationRepository._();

  DateTime checkInDate;

  DateTime checkOutDate;

  DateTime stayDay;

  String? note;

  DateTime dateCreate;

  DateTime? dateUpdate;

  int guestId;

  _i2.Guest? guest;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  bool isCheckedIn;

  bool isCanceled;

  bool isNightShift;

  int roomId;

  _i2.Room? room;

  int? _roomReservationsRoomId;

  @override
  _i1.Table get table => t;

  Reservation copyWith({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    DateTime? stayDay,
    String? note,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? guestId,
    _i2.Guest? guest,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    bool? isCheckedIn,
    bool? isCanceled,
    bool? isNightShift,
    int? roomId,
    _i2.Room? room,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      'stayDay': stayDay.toJson(),
      if (note != null) 'note': note,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'isCheckedIn': isCheckedIn,
      'isCanceled': isCanceled,
      'isNightShift': isNightShift,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      if (_roomReservationsRoomId != null)
        '_roomReservationsRoomId': _roomReservationsRoomId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      'stayDay': stayDay.toJson(),
      if (note != null) 'note': note,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'isCheckedIn': isCheckedIn,
      'isCanceled': isCanceled,
      'isNightShift': isNightShift,
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
    };
  }

  static ReservationInclude include({
    _i2.GuestInclude? guest,
    _i2.RoomInclude? room,
  }) {
    return ReservationInclude._(
      guest: guest,
      room: room,
    );
  }

  static ReservationIncludeList includeList({
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReservationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReservationTable>? orderByList,
    ReservationInclude? include,
  }) {
    return ReservationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reservation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Reservation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReservationImpl extends Reservation {
  _ReservationImpl({
    int? id,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required DateTime stayDay,
    String? note,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i2.Room? room,
  }) : super._(
          id: id,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          stayDay: stayDay,
          note: note,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          guestId: guestId,
          guest: guest,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          isCheckedIn: isCheckedIn,
          isCanceled: isCanceled,
          isNightShift: isNightShift,
          roomId: roomId,
          room: room,
        );

  @override
  Reservation copyWith({
    Object? id = _Undefined,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    DateTime? stayDay,
    Object? note = _Undefined,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    bool? isCheckedIn,
    bool? isCanceled,
    bool? isNightShift,
    int? roomId,
    Object? room = _Undefined,
  }) {
    return Reservation(
      id: id is int? ? id : this.id,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      stayDay: stayDay ?? this.stayDay,
      note: note is String? ? note : this.note,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCanceled: isCanceled ?? this.isCanceled,
      isNightShift: isNightShift ?? this.isNightShift,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
    );
  }
}

class ReservationImplicit extends _ReservationImpl {
  ReservationImplicit._({
    int? id,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required DateTime stayDay,
    String? note,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required bool isCheckedIn,
    required bool isCanceled,
    required bool isNightShift,
    required int roomId,
    _i2.Room? room,
    this.$_roomReservationsRoomId,
  }) : super(
          id: id,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          stayDay: stayDay,
          note: note,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          guestId: guestId,
          guest: guest,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          isCheckedIn: isCheckedIn,
          isCanceled: isCanceled,
          isNightShift: isNightShift,
          roomId: roomId,
          room: room,
        );

  factory ReservationImplicit(
    Reservation reservation, {
    int? $_roomReservationsRoomId,
  }) {
    return ReservationImplicit._(
      id: reservation.id,
      checkInDate: reservation.checkInDate,
      checkOutDate: reservation.checkOutDate,
      stayDay: reservation.stayDay,
      note: reservation.note,
      dateCreate: reservation.dateCreate,
      dateUpdate: reservation.dateUpdate,
      guestId: reservation.guestId,
      guest: reservation.guest,
      rateType: reservation.rateType,
      rateReason: reservation.rateReason,
      rate: reservation.rate,
      isCheckedIn: reservation.isCheckedIn,
      isCanceled: reservation.isCanceled,
      isNightShift: reservation.isNightShift,
      roomId: reservation.roomId,
      room: reservation.room,
      $_roomReservationsRoomId: $_roomReservationsRoomId,
    );
  }

  int? $_roomReservationsRoomId;

  @override
  Map<String, dynamic> toJson() {
    var jsonMap = super.toJson();
    jsonMap.addAll({'_roomReservationsRoomId': $_roomReservationsRoomId});
    return jsonMap;
  }
}

class ReservationTable extends _i1.Table {
  ReservationTable({super.tableRelation}) : super(tableName: 'reservation') {
    checkInDate = _i1.ColumnDateTime(
      'checkInDate',
      this,
    );
    checkOutDate = _i1.ColumnDateTime(
      'checkOutDate',
      this,
    );
    stayDay = _i1.ColumnDateTime(
      'stayDay',
      this,
    );
    note = _i1.ColumnString(
      'note',
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
    isCheckedIn = _i1.ColumnBool(
      'isCheckedIn',
      this,
    );
    isCanceled = _i1.ColumnBool(
      'isCanceled',
      this,
    );
    isNightShift = _i1.ColumnBool(
      'isNightShift',
      this,
    );
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    $_roomReservationsRoomId = _i1.ColumnInt(
      '_roomReservationsRoomId',
      this,
    );
  }

  late final _i1.ColumnDateTime checkInDate;

  late final _i1.ColumnDateTime checkOutDate;

  late final _i1.ColumnDateTime stayDay;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateUpdate;

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  late final _i1.ColumnEnum<_i2.RateType> rateType;

  late final _i1.ColumnEnum<_i2.RateReason> rateReason;

  late final _i1.ColumnDouble rate;

  late final _i1.ColumnBool isCheckedIn;

  late final _i1.ColumnBool isCanceled;

  late final _i1.ColumnBool isNightShift;

  late final _i1.ColumnInt roomId;

  _i2.RoomTable? _room;

  late final _i1.ColumnInt $_roomReservationsRoomId;

  _i2.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: Reservation.t.guestId,
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
      field: Reservation.t.roomId,
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
        checkInDate,
        checkOutDate,
        stayDay,
        note,
        dateCreate,
        dateUpdate,
        guestId,
        rateType,
        rateReason,
        rate,
        isCheckedIn,
        isCanceled,
        isNightShift,
        roomId,
        $_roomReservationsRoomId,
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

class ReservationInclude extends _i1.IncludeObject {
  ReservationInclude._({
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
  _i1.Table get table => Reservation.t;
}

class ReservationIncludeList extends _i1.IncludeList {
  ReservationIncludeList._({
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reservation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Reservation.t;
}

class ReservationRepository {
  const ReservationRepository._();

  final attachRow = const ReservationAttachRowRepository._();

  Future<List<Reservation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReservationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReservationTable>? orderByList,
    _i1.Transaction? transaction,
    ReservationInclude? include,
  }) async {
    return session.db.find<Reservation>(
      where: where?.call(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Reservation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReservationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReservationTable>? orderByList,
    _i1.Transaction? transaction,
    ReservationInclude? include,
  }) async {
    return session.db.findFirstRow<Reservation>(
      where: where?.call(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Reservation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ReservationInclude? include,
  }) async {
    return session.db.findById<Reservation>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Reservation>> insert(
    _i1.Session session,
    List<Reservation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Reservation>(
      rows,
      transaction: transaction,
    );
  }

  Future<Reservation> insertRow(
    _i1.Session session,
    Reservation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reservation>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Reservation>> update(
    _i1.Session session,
    List<Reservation> rows, {
    _i1.ColumnSelections<ReservationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Reservation>(
      rows,
      columns: columns?.call(Reservation.t),
      transaction: transaction,
    );
  }

  Future<Reservation> updateRow(
    _i1.Session session,
    Reservation row, {
    _i1.ColumnSelections<ReservationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reservation>(
      row,
      columns: columns?.call(Reservation.t),
      transaction: transaction,
    );
  }

  Future<List<Reservation>> delete(
    _i1.Session session,
    List<Reservation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Reservation>(
      rows,
      transaction: transaction,
    );
  }

  Future<Reservation> deleteRow(
    _i1.Session session,
    Reservation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reservation>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Reservation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReservationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Reservation>(
      where: where(Reservation.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Reservation>(
      where: where?.call(Reservation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ReservationAttachRowRepository {
  const ReservationAttachRowRepository._();

  Future<void> guest(
    _i1.Session session,
    Reservation reservation,
    _i2.Guest guest,
  ) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $reservation = reservation.copyWith(guestId: guest.id);
    await session.db.updateRow<Reservation>(
      $reservation,
      columns: [Reservation.t.guestId],
    );
  }

  Future<void> room(
    _i1.Session session,
    Reservation reservation,
    _i2.Room room,
  ) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $reservation = reservation.copyWith(roomId: room.id);
    await session.db.updateRow<Reservation>(
      $reservation,
      columns: [Reservation.t.roomId],
    );
  }
}
