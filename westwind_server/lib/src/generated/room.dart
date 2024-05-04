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

abstract class Room extends _i1.TableRow {
  Room._({
    int? id,
    required this.roomNumber,
    this.reservations,
    required this.roomType,
    required this.roomStatus,
    required this.isAvailable,
    required this.isSmoke,
    required this.bedType,
    required this.isBigTV,
    required this.isNewAC,
    required this.isNewBed,
    required this.isBigRefergrator,
    this.note,
  }) : super(id);

  factory Room({
    int? id,
    required _i2.RoomNumber roomNumber,
    List<_i2.Reservation>? reservations,
    required String roomType,
    required _i2.RoomStatus roomStatus,
    required bool isAvailable,
    required bool isSmoke,
    required String bedType,
    required bool isBigTV,
    required bool isNewAC,
    required bool isNewBed,
    required bool isBigRefergrator,
    String? note,
  }) = _RoomImpl;

  factory Room.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Room(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      reservations: serializationManager.deserialize<List<_i2.Reservation>?>(
          jsonSerialization['reservations']),
      roomType: serializationManager
          .deserialize<String>(jsonSerialization['roomType']),
      roomStatus: serializationManager
          .deserialize<_i2.RoomStatus>(jsonSerialization['roomStatus']),
      isAvailable: serializationManager
          .deserialize<bool>(jsonSerialization['isAvailable']),
      isSmoke:
          serializationManager.deserialize<bool>(jsonSerialization['isSmoke']),
      bedType: serializationManager
          .deserialize<String>(jsonSerialization['bedType']),
      isBigTV:
          serializationManager.deserialize<bool>(jsonSerialization['isBigTV']),
      isNewAC:
          serializationManager.deserialize<bool>(jsonSerialization['isNewAC']),
      isNewBed:
          serializationManager.deserialize<bool>(jsonSerialization['isNewBed']),
      isBigRefergrator: serializationManager
          .deserialize<bool>(jsonSerialization['isBigRefergrator']),
      note:
          serializationManager.deserialize<String?>(jsonSerialization['note']),
    );
  }

  static final t = RoomTable();

  static const db = RoomRepository._();

  _i2.RoomNumber roomNumber;

  List<_i2.Reservation>? reservations;

  String roomType;

  _i2.RoomStatus roomStatus;

  bool isAvailable;

  bool isSmoke;

  String bedType;

  bool isBigTV;

  bool isNewAC;

  bool isNewBed;

  bool isBigRefergrator;

  String? note;

  @override
  _i1.Table get table => t;

  Room copyWith({
    int? id,
    _i2.RoomNumber? roomNumber,
    List<_i2.Reservation>? reservations,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    String? bedType,
    bool? isBigTV,
    bool? isNewAC,
    bool? isNewBed,
    bool? isBigRefergrator,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      if (reservations != null)
        'reservations': reservations?.toJson(valueToJson: (v) => v.toJson()),
      'roomType': roomType,
      'roomStatus': roomStatus.toJson(),
      'isAvailable': isAvailable,
      'isSmoke': isSmoke,
      'bedType': bedType,
      'isBigTV': isBigTV,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'isBigRefergrator': isBigRefergrator,
      if (note != null) 'note': note,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'roomType': roomType,
      'roomStatus': roomStatus,
      'isAvailable': isAvailable,
      'isSmoke': isSmoke,
      'bedType': bedType,
      'isBigTV': isBigTV,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'isBigRefergrator': isBigRefergrator,
      'note': note,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      if (reservations != null)
        'reservations': reservations?.toJson(valueToJson: (v) => v.allToJson()),
      'roomType': roomType,
      'roomStatus': roomStatus.toJson(),
      'isAvailable': isAvailable,
      'isSmoke': isSmoke,
      'bedType': bedType,
      'isBigTV': isBigTV,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'isBigRefergrator': isBigRefergrator,
      if (note != null) 'note': note,
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
      case 'roomType':
        roomType = value;
        return;
      case 'roomStatus':
        roomStatus = value;
        return;
      case 'isAvailable':
        isAvailable = value;
        return;
      case 'isSmoke':
        isSmoke = value;
        return;
      case 'bedType':
        bedType = value;
        return;
      case 'isBigTV':
        isBigTV = value;
        return;
      case 'isNewAC':
        isNewAC = value;
        return;
      case 'isNewBed':
        isNewBed = value;
        return;
      case 'isBigRefergrator':
        isBigRefergrator = value;
        return;
      case 'note':
        note = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Room>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.db.find<Room>(
      where: where != null ? where(Room.t) : null,
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
  static Future<Room?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.db.findSingleRow<Room>(
      where: where != null ? where(Room.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Room?> findById(
    _i1.Session session,
    int id, {
    RoomInclude? include,
  }) async {
    return session.db.findById<Room>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Room>(
      where: where(Room.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Room row, {
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
    Room row, {
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
    Room row, {
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
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Room>(
      where: where != null ? where(Room.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static RoomInclude include({_i2.ReservationIncludeList? reservations}) {
    return RoomInclude._(reservations: reservations);
  }

  static RoomIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTable>? orderByList,
    RoomInclude? include,
  }) {
    return RoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Room.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Room.t),
      include: include,
    );
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required _i2.RoomNumber roomNumber,
    List<_i2.Reservation>? reservations,
    required String roomType,
    required _i2.RoomStatus roomStatus,
    required bool isAvailable,
    required bool isSmoke,
    required String bedType,
    required bool isBigTV,
    required bool isNewAC,
    required bool isNewBed,
    required bool isBigRefergrator,
    String? note,
  }) : super._(
          id: id,
          roomNumber: roomNumber,
          reservations: reservations,
          roomType: roomType,
          roomStatus: roomStatus,
          isAvailable: isAvailable,
          isSmoke: isSmoke,
          bedType: bedType,
          isBigTV: isBigTV,
          isNewAC: isNewAC,
          isNewBed: isNewBed,
          isBigRefergrator: isBigRefergrator,
          note: note,
        );

  @override
  Room copyWith({
    Object? id = _Undefined,
    _i2.RoomNumber? roomNumber,
    Object? reservations = _Undefined,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    String? bedType,
    bool? isBigTV,
    bool? isNewAC,
    bool? isNewBed,
    bool? isBigRefergrator,
    Object? note = _Undefined,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      reservations: reservations is List<_i2.Reservation>?
          ? reservations
          : this.reservations?.clone(),
      roomType: roomType ?? this.roomType,
      roomStatus: roomStatus ?? this.roomStatus,
      isAvailable: isAvailable ?? this.isAvailable,
      isSmoke: isSmoke ?? this.isSmoke,
      bedType: bedType ?? this.bedType,
      isBigTV: isBigTV ?? this.isBigTV,
      isNewAC: isNewAC ?? this.isNewAC,
      isNewBed: isNewBed ?? this.isNewBed,
      isBigRefergrator: isBigRefergrator ?? this.isBigRefergrator,
      note: note is String? ? note : this.note,
    );
  }
}

class RoomTable extends _i1.Table {
  RoomTable({super.tableRelation}) : super(tableName: 'room') {
    roomNumber = _i1.ColumnEnum(
      'roomNumber',
      this,
      _i1.EnumSerialization.byName,
    );
    roomType = _i1.ColumnString(
      'roomType',
      this,
    );
    roomStatus = _i1.ColumnEnum(
      'roomStatus',
      this,
      _i1.EnumSerialization.byName,
    );
    isAvailable = _i1.ColumnBool(
      'isAvailable',
      this,
    );
    isSmoke = _i1.ColumnBool(
      'isSmoke',
      this,
    );
    bedType = _i1.ColumnString(
      'bedType',
      this,
    );
    isBigTV = _i1.ColumnBool(
      'isBigTV',
      this,
    );
    isNewAC = _i1.ColumnBool(
      'isNewAC',
      this,
    );
    isNewBed = _i1.ColumnBool(
      'isNewBed',
      this,
    );
    isBigRefergrator = _i1.ColumnBool(
      'isBigRefergrator',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.RoomNumber> roomNumber;

  _i2.ReservationTable? ___reservations;

  _i1.ManyRelation<_i2.ReservationTable>? _reservations;

  late final _i1.ColumnString roomType;

  late final _i1.ColumnEnum<_i2.RoomStatus> roomStatus;

  late final _i1.ColumnBool isAvailable;

  late final _i1.ColumnBool isSmoke;

  late final _i1.ColumnString bedType;

  late final _i1.ColumnBool isBigTV;

  late final _i1.ColumnBool isNewAC;

  late final _i1.ColumnBool isNewBed;

  late final _i1.ColumnBool isBigRefergrator;

  late final _i1.ColumnString note;

  _i2.ReservationTable get __reservations {
    if (___reservations != null) return ___reservations!;
    ___reservations = _i1.createRelationTable(
      relationFieldName: '__reservations',
      field: Room.t.id,
      foreignField: _i2.Reservation.t.$_roomReservationsRoomId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ReservationTable(tableRelation: foreignTableRelation),
    );
    return ___reservations!;
  }

  _i1.ManyRelation<_i2.ReservationTable> get reservations {
    if (_reservations != null) return _reservations!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'reservations',
      field: Room.t.id,
      foreignField: _i2.Reservation.t.$_roomReservationsRoomId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ReservationTable(tableRelation: foreignTableRelation),
    );
    _reservations = _i1.ManyRelation<_i2.ReservationTable>(
      tableWithRelations: relationTable,
      table: _i2.ReservationTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _reservations!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        roomNumber,
        roomType,
        roomStatus,
        isAvailable,
        isSmoke,
        bedType,
        isBigTV,
        isNewAC,
        isNewBed,
        isBigRefergrator,
        note,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'reservations') {
      return __reservations;
    }
    return null;
  }
}

@Deprecated('Use RoomTable.t instead.')
RoomTable tRoom = RoomTable();

class RoomInclude extends _i1.IncludeObject {
  RoomInclude._({_i2.ReservationIncludeList? reservations}) {
    _reservations = reservations;
  }

  _i2.ReservationIncludeList? _reservations;

  @override
  Map<String, _i1.Include?> get includes => {'reservations': _reservations};

  @override
  _i1.Table get table => Room.t;
}

class RoomIncludeList extends _i1.IncludeList {
  RoomIncludeList._({
    _i1.WhereExpressionBuilder<RoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Room.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Room.t;
}

class RoomRepository {
  const RoomRepository._();

  final attach = const RoomAttachRepository._();

  final attachRow = const RoomAttachRowRepository._();

  final detach = const RoomDetachRepository._();

  final detachRow = const RoomDetachRowRepository._();

  Future<List<Room>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTable>? orderByList,
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.dbNext.find<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Room?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTable>? orderByList,
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.dbNext.findFirstRow<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Room?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.dbNext.findById<Room>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Room>> insert(
    _i1.Session session,
    List<Room> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Room>(
      rows,
      transaction: transaction,
    );
  }

  Future<Room> insertRow(
    _i1.Session session,
    Room row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Room>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Room>> update(
    _i1.Session session,
    List<Room> rows, {
    _i1.ColumnSelections<RoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Room>(
      rows,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  Future<Room> updateRow(
    _i1.Session session,
    Room row, {
    _i1.ColumnSelections<RoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Room>(
      row,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Room> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Room>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Room row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Room>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Room>(
      where: where(Room.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Room>(
      where: where?.call(Room.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RoomAttachRepository {
  const RoomAttachRepository._();

  Future<void> reservations(
    _i1.Session session,
    Room room,
    List<_i2.Reservation> reservation,
  ) async {
    if (reservation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $reservation = reservation
        .map((e) => _i2.ReservationImplicit(
              e,
              $_roomReservationsRoomId: room.id,
            ))
        .toList();
    await session.dbNext.update<_i2.Reservation>(
      $reservation,
      columns: [_i2.Reservation.t.$_roomReservationsRoomId],
    );
  }
}

class RoomAttachRowRepository {
  const RoomAttachRowRepository._();

  Future<void> reservations(
    _i1.Session session,
    Room room,
    _i2.Reservation reservation,
  ) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $reservation = _i2.ReservationImplicit(
      reservation,
      $_roomReservationsRoomId: room.id,
    );
    await session.dbNext.updateRow<_i2.Reservation>(
      $reservation,
      columns: [_i2.Reservation.t.$_roomReservationsRoomId],
    );
  }
}

class RoomDetachRepository {
  const RoomDetachRepository._();

  Future<void> reservations(
    _i1.Session session,
    List<_i2.Reservation> reservation,
  ) async {
    if (reservation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $reservation = reservation
        .map((e) => _i2.ReservationImplicit(
              e,
              $_roomReservationsRoomId: null,
            ))
        .toList();
    await session.dbNext.update<_i2.Reservation>(
      $reservation,
      columns: [_i2.Reservation.t.$_roomReservationsRoomId],
    );
  }
}

class RoomDetachRowRepository {
  const RoomDetachRowRepository._();

  Future<void> reservations(
    _i1.Session session,
    _i2.Reservation reservation,
  ) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $reservation = _i2.ReservationImplicit(
      reservation,
      $_roomReservationsRoomId: null,
    );
    await session.dbNext.updateRow<_i2.Reservation>(
      $reservation,
      columns: [_i2.Reservation.t.$_roomReservationsRoomId],
    );
  }
}
