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

abstract class Room extends _i1.TableRow implements _i1.ProtocolSerialization {
  Room._({
    int? id,
    required this.roomNumber,
    this.reservations,
    required this.roomType,
    required this.roomStatus,
    required this.isAvailable,
    required this.isSmoke,
    required this.bedType,
    required this.numOfBeds,
    required this.isNewAC,
    required this.isNewBed,
    required this.numOfMicrowave,
    required this.isNewRefergrator,
    required this.isBigRefergrator,
    required this.isBigTV,
    required this.isNewTV,
    required this.numOfTableLamp,
    required this.isNewTableLamp,
    required this.numOfStandLamp,
    required this.isNewStandLamp,
    this.note,
  }) : super(id);

  factory Room({
    int? id,
    required String roomNumber,
    List<_i2.Reservation>? reservations,
    required String roomType,
    required _i2.RoomStatus roomStatus,
    required bool isAvailable,
    required bool isSmoke,
    required _i2.BedType bedType,
    required int numOfBeds,
    required bool isNewAC,
    required bool isNewBed,
    required int numOfMicrowave,
    required bool isNewRefergrator,
    required bool isBigRefergrator,
    required bool isBigTV,
    required bool isNewTV,
    required int numOfTableLamp,
    required bool isNewTableLamp,
    required int numOfStandLamp,
    required bool isNewStandLamp,
    String? note,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      roomNumber: jsonSerialization['roomNumber'] as String,
      reservations: (jsonSerialization['reservations'] as List?)
          ?.map((e) => _i2.Reservation.fromJson((e as Map<String, dynamic>)))
          .toList(),
      roomType: jsonSerialization['roomType'] as String,
      roomStatus:
          _i2.RoomStatus.fromJson((jsonSerialization['roomStatus'] as String)),
      isAvailable: jsonSerialization['isAvailable'] as bool,
      isSmoke: jsonSerialization['isSmoke'] as bool,
      bedType: _i2.BedType.fromJson((jsonSerialization['bedType'] as String)),
      numOfBeds: jsonSerialization['numOfBeds'] as int,
      isNewAC: jsonSerialization['isNewAC'] as bool,
      isNewBed: jsonSerialization['isNewBed'] as bool,
      numOfMicrowave: jsonSerialization['numOfMicrowave'] as int,
      isNewRefergrator: jsonSerialization['isNewRefergrator'] as bool,
      isBigRefergrator: jsonSerialization['isBigRefergrator'] as bool,
      isBigTV: jsonSerialization['isBigTV'] as bool,
      isNewTV: jsonSerialization['isNewTV'] as bool,
      numOfTableLamp: jsonSerialization['numOfTableLamp'] as int,
      isNewTableLamp: jsonSerialization['isNewTableLamp'] as bool,
      numOfStandLamp: jsonSerialization['numOfStandLamp'] as int,
      isNewStandLamp: jsonSerialization['isNewStandLamp'] as bool,
      note: jsonSerialization['note'] as String?,
    );
  }

  static final t = RoomTable();

  static const db = RoomRepository._();

  String roomNumber;

  List<_i2.Reservation>? reservations;

  String roomType;

  _i2.RoomStatus roomStatus;

  bool isAvailable;

  bool isSmoke;

  _i2.BedType bedType;

  int numOfBeds;

  bool isNewAC;

  bool isNewBed;

  int numOfMicrowave;

  bool isNewRefergrator;

  bool isBigRefergrator;

  bool isBigTV;

  bool isNewTV;

  int numOfTableLamp;

  bool isNewTableLamp;

  int numOfStandLamp;

  bool isNewStandLamp;

  String? note;

  @override
  _i1.Table get table => t;

  Room copyWith({
    int? id,
    String? roomNumber,
    List<_i2.Reservation>? reservations,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    _i2.BedType? bedType,
    int? numOfBeds,
    bool? isNewAC,
    bool? isNewBed,
    int? numOfMicrowave,
    bool? isNewRefergrator,
    bool? isBigRefergrator,
    bool? isBigTV,
    bool? isNewTV,
    int? numOfTableLamp,
    bool? isNewTableLamp,
    int? numOfStandLamp,
    bool? isNewStandLamp,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      if (reservations != null)
        'reservations': reservations?.toJson(valueToJson: (v) => v.toJson()),
      'roomType': roomType,
      'roomStatus': roomStatus.toJson(),
      'isAvailable': isAvailable,
      'isSmoke': isSmoke,
      'bedType': bedType.toJson(),
      'numOfBeds': numOfBeds,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'numOfMicrowave': numOfMicrowave,
      'isNewRefergrator': isNewRefergrator,
      'isBigRefergrator': isBigRefergrator,
      'isBigTV': isBigTV,
      'isNewTV': isNewTV,
      'numOfTableLamp': numOfTableLamp,
      'isNewTableLamp': isNewTableLamp,
      'numOfStandLamp': numOfStandLamp,
      'isNewStandLamp': isNewStandLamp,
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber,
      if (reservations != null)
        'reservations':
            reservations?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'roomType': roomType,
      'roomStatus': roomStatus.toJson(),
      'isAvailable': isAvailable,
      'isSmoke': isSmoke,
      'bedType': bedType.toJson(),
      'numOfBeds': numOfBeds,
      'isNewAC': isNewAC,
      'isNewBed': isNewBed,
      'numOfMicrowave': numOfMicrowave,
      'isNewRefergrator': isNewRefergrator,
      'isBigRefergrator': isBigRefergrator,
      'isBigTV': isBigTV,
      'isNewTV': isNewTV,
      'numOfTableLamp': numOfTableLamp,
      'isNewTableLamp': isNewTableLamp,
      'numOfStandLamp': numOfStandLamp,
      'isNewStandLamp': isNewStandLamp,
      if (note != null) 'note': note,
    };
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required String roomNumber,
    List<_i2.Reservation>? reservations,
    required String roomType,
    required _i2.RoomStatus roomStatus,
    required bool isAvailable,
    required bool isSmoke,
    required _i2.BedType bedType,
    required int numOfBeds,
    required bool isNewAC,
    required bool isNewBed,
    required int numOfMicrowave,
    required bool isNewRefergrator,
    required bool isBigRefergrator,
    required bool isBigTV,
    required bool isNewTV,
    required int numOfTableLamp,
    required bool isNewTableLamp,
    required int numOfStandLamp,
    required bool isNewStandLamp,
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
          numOfBeds: numOfBeds,
          isNewAC: isNewAC,
          isNewBed: isNewBed,
          numOfMicrowave: numOfMicrowave,
          isNewRefergrator: isNewRefergrator,
          isBigRefergrator: isBigRefergrator,
          isBigTV: isBigTV,
          isNewTV: isNewTV,
          numOfTableLamp: numOfTableLamp,
          isNewTableLamp: isNewTableLamp,
          numOfStandLamp: numOfStandLamp,
          isNewStandLamp: isNewStandLamp,
          note: note,
        );

  @override
  Room copyWith({
    Object? id = _Undefined,
    String? roomNumber,
    Object? reservations = _Undefined,
    String? roomType,
    _i2.RoomStatus? roomStatus,
    bool? isAvailable,
    bool? isSmoke,
    _i2.BedType? bedType,
    int? numOfBeds,
    bool? isNewAC,
    bool? isNewBed,
    int? numOfMicrowave,
    bool? isNewRefergrator,
    bool? isBigRefergrator,
    bool? isBigTV,
    bool? isNewTV,
    int? numOfTableLamp,
    bool? isNewTableLamp,
    int? numOfStandLamp,
    bool? isNewStandLamp,
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
      numOfBeds: numOfBeds ?? this.numOfBeds,
      isNewAC: isNewAC ?? this.isNewAC,
      isNewBed: isNewBed ?? this.isNewBed,
      numOfMicrowave: numOfMicrowave ?? this.numOfMicrowave,
      isNewRefergrator: isNewRefergrator ?? this.isNewRefergrator,
      isBigRefergrator: isBigRefergrator ?? this.isBigRefergrator,
      isBigTV: isBigTV ?? this.isBigTV,
      isNewTV: isNewTV ?? this.isNewTV,
      numOfTableLamp: numOfTableLamp ?? this.numOfTableLamp,
      isNewTableLamp: isNewTableLamp ?? this.isNewTableLamp,
      numOfStandLamp: numOfStandLamp ?? this.numOfStandLamp,
      isNewStandLamp: isNewStandLamp ?? this.isNewStandLamp,
      note: note is String? ? note : this.note,
    );
  }
}

class RoomTable extends _i1.Table {
  RoomTable({super.tableRelation}) : super(tableName: 'room') {
    roomNumber = _i1.ColumnString(
      'roomNumber',
      this,
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
    bedType = _i1.ColumnEnum(
      'bedType',
      this,
      _i1.EnumSerialization.byName,
    );
    numOfBeds = _i1.ColumnInt(
      'numOfBeds',
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
    numOfMicrowave = _i1.ColumnInt(
      'numOfMicrowave',
      this,
    );
    isNewRefergrator = _i1.ColumnBool(
      'isNewRefergrator',
      this,
    );
    isBigRefergrator = _i1.ColumnBool(
      'isBigRefergrator',
      this,
    );
    isBigTV = _i1.ColumnBool(
      'isBigTV',
      this,
    );
    isNewTV = _i1.ColumnBool(
      'isNewTV',
      this,
    );
    numOfTableLamp = _i1.ColumnInt(
      'numOfTableLamp',
      this,
    );
    isNewTableLamp = _i1.ColumnBool(
      'isNewTableLamp',
      this,
    );
    numOfStandLamp = _i1.ColumnInt(
      'numOfStandLamp',
      this,
    );
    isNewStandLamp = _i1.ColumnBool(
      'isNewStandLamp',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
  }

  late final _i1.ColumnString roomNumber;

  _i2.ReservationTable? ___reservations;

  _i1.ManyRelation<_i2.ReservationTable>? _reservations;

  late final _i1.ColumnString roomType;

  late final _i1.ColumnEnum<_i2.RoomStatus> roomStatus;

  late final _i1.ColumnBool isAvailable;

  late final _i1.ColumnBool isSmoke;

  late final _i1.ColumnEnum<_i2.BedType> bedType;

  late final _i1.ColumnInt numOfBeds;

  late final _i1.ColumnBool isNewAC;

  late final _i1.ColumnBool isNewBed;

  late final _i1.ColumnInt numOfMicrowave;

  late final _i1.ColumnBool isNewRefergrator;

  late final _i1.ColumnBool isBigRefergrator;

  late final _i1.ColumnBool isBigTV;

  late final _i1.ColumnBool isNewTV;

  late final _i1.ColumnInt numOfTableLamp;

  late final _i1.ColumnBool isNewTableLamp;

  late final _i1.ColumnInt numOfStandLamp;

  late final _i1.ColumnBool isNewStandLamp;

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
        numOfBeds,
        isNewAC,
        isNewBed,
        numOfMicrowave,
        isNewRefergrator,
        isBigRefergrator,
        isBigTV,
        isNewTV,
        numOfTableLamp,
        isNewTableLamp,
        numOfStandLamp,
        isNewStandLamp,
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
    return session.db.find<Room>(
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
    return session.db.findFirstRow<Room>(
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
    return session.db.findById<Room>(
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
    return session.db.insert<Room>(
      rows,
      transaction: transaction,
    );
  }

  Future<Room> insertRow(
    _i1.Session session,
    Room row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Room>(
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
    return session.db.update<Room>(
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
    return session.db.updateRow<Room>(
      row,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  Future<List<Room>> delete(
    _i1.Session session,
    List<Room> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Room>(
      rows,
      transaction: transaction,
    );
  }

  Future<Room> deleteRow(
    _i1.Session session,
    Room row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Room>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Room>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Room>(
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
    return session.db.count<Room>(
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
    await session.db.update<_i2.Reservation>(
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
    await session.db.updateRow<_i2.Reservation>(
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
    await session.db.update<_i2.Reservation>(
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
    await session.db.updateRow<_i2.Reservation>(
      $reservation,
      columns: [_i2.Reservation.t.$_roomReservationsRoomId],
    );
  }
}
