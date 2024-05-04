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

abstract class RoomInOutDate extends _i1.TableRow {
  RoomInOutDate._({
    int? id,
    this.checkInDate,
    this.checkOutDate,
    required this.guestId,
    this.guest,
    required this.roomNumber,
    required this.dateCreate,
  }) : super(id);

  factory RoomInOutDate({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
  }) = _RoomInOutDateImpl;

  factory RoomInOutDate.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomInOutDate(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      checkInDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['checkInDate']),
      checkOutDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['checkOutDate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
    );
  }

  static final t = RoomInOutDateTable();

  static const db = RoomInOutDateRepository._();

  DateTime? checkInDate;

  DateTime? checkOutDate;

  int guestId;

  _i2.Guest? guest;

  _i2.RoomNumber roomNumber;

  DateTime dateCreate;

  @override
  _i1.Table get table => t;

  RoomInOutDate copyWith({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guestId,
    _i2.Guest? guest,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (checkInDate != null) 'checkInDate': checkInDate?.toJson(),
      if (checkOutDate != null) 'checkOutDate': checkOutDate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'guestId': guestId,
      'roomNumber': roomNumber,
      'dateCreate': dateCreate,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      if (checkInDate != null) 'checkInDate': checkInDate?.toJson(),
      if (checkOutDate != null) 'checkOutDate': checkOutDate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.allToJson(),
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
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
      case 'checkInDate':
        checkInDate = value;
        return;
      case 'checkOutDate':
        checkOutDate = value;
        return;
      case 'guestId':
        guestId = value;
        return;
      case 'roomNumber':
        roomNumber = value;
        return;
      case 'dateCreate':
        dateCreate = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<RoomInOutDate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomInOutDateInclude? include,
  }) async {
    return session.db.find<RoomInOutDate>(
      where: where != null ? where(RoomInOutDate.t) : null,
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
  static Future<RoomInOutDate?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    RoomInOutDateInclude? include,
  }) async {
    return session.db.findSingleRow<RoomInOutDate>(
      where: where != null ? where(RoomInOutDate.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<RoomInOutDate?> findById(
    _i1.Session session,
    int id, {
    RoomInOutDateInclude? include,
  }) async {
    return session.db.findById<RoomInOutDate>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomInOutDateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomInOutDate>(
      where: where(RoomInOutDate.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    RoomInOutDate row, {
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
    RoomInOutDate row, {
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
    RoomInOutDate row, {
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
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomInOutDate>(
      where: where != null ? where(RoomInOutDate.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static RoomInOutDateInclude include({_i2.GuestInclude? guest}) {
    return RoomInOutDateInclude._(guest: guest);
  }

  static RoomInOutDateIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomInOutDateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomInOutDateTable>? orderByList,
    RoomInOutDateInclude? include,
  }) {
    return RoomInOutDateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomInOutDate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomInOutDate.t),
      include: include,
    );
  }
}

class _Undefined {}

class _RoomInOutDateImpl extends RoomInOutDate {
  _RoomInOutDateImpl({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
  }) : super._(
          id: id,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          guestId: guestId,
          guest: guest,
          roomNumber: roomNumber,
          dateCreate: dateCreate,
        );

  @override
  RoomInOutDate copyWith({
    Object? id = _Undefined,
    Object? checkInDate = _Undefined,
    Object? checkOutDate = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
  }) {
    return RoomInOutDate(
      id: id is int? ? id : this.id,
      checkInDate: checkInDate is DateTime? ? checkInDate : this.checkInDate,
      checkOutDate:
          checkOutDate is DateTime? ? checkOutDate : this.checkOutDate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomNumber: roomNumber ?? this.roomNumber,
      dateCreate: dateCreate ?? this.dateCreate,
    );
  }
}

class RoomInOutDateTable extends _i1.Table {
  RoomInOutDateTable({super.tableRelation})
      : super(tableName: 'room_in_out_date') {
    checkInDate = _i1.ColumnDateTime(
      'checkInDate',
      this,
    );
    checkOutDate = _i1.ColumnDateTime(
      'checkOutDate',
      this,
    );
    guestId = _i1.ColumnInt(
      'guestId',
      this,
    );
    roomNumber = _i1.ColumnEnum(
      'roomNumber',
      this,
      _i1.EnumSerialization.byName,
    );
    dateCreate = _i1.ColumnDateTime(
      'dateCreate',
      this,
    );
  }

  late final _i1.ColumnDateTime checkInDate;

  late final _i1.ColumnDateTime checkOutDate;

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  late final _i1.ColumnEnum<_i2.RoomNumber> roomNumber;

  late final _i1.ColumnDateTime dateCreate;

  _i2.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: RoomInOutDate.t.guestId,
      foreignField: _i2.Guest.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    return _guest!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        checkInDate,
        checkOutDate,
        guestId,
        roomNumber,
        dateCreate,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guest') {
      return guest;
    }
    return null;
  }
}

@Deprecated('Use RoomInOutDateTable.t instead.')
RoomInOutDateTable tRoomInOutDate = RoomInOutDateTable();

class RoomInOutDateInclude extends _i1.IncludeObject {
  RoomInOutDateInclude._({_i2.GuestInclude? guest}) {
    _guest = guest;
  }

  _i2.GuestInclude? _guest;

  @override
  Map<String, _i1.Include?> get includes => {'guest': _guest};

  @override
  _i1.Table get table => RoomInOutDate.t;
}

class RoomInOutDateIncludeList extends _i1.IncludeList {
  RoomInOutDateIncludeList._({
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomInOutDate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RoomInOutDate.t;
}

class RoomInOutDateRepository {
  const RoomInOutDateRepository._();

  final attachRow = const RoomInOutDateAttachRowRepository._();

  Future<List<RoomInOutDate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomInOutDateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomInOutDateTable>? orderByList,
    _i1.Transaction? transaction,
    RoomInOutDateInclude? include,
  }) async {
    return session.dbNext.find<RoomInOutDate>(
      where: where?.call(RoomInOutDate.t),
      orderBy: orderBy?.call(RoomInOutDate.t),
      orderByList: orderByList?.call(RoomInOutDate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoomInOutDate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomInOutDateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomInOutDateTable>? orderByList,
    _i1.Transaction? transaction,
    RoomInOutDateInclude? include,
  }) async {
    return session.dbNext.findFirstRow<RoomInOutDate>(
      where: where?.call(RoomInOutDate.t),
      orderBy: orderBy?.call(RoomInOutDate.t),
      orderByList: orderByList?.call(RoomInOutDate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoomInOutDate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoomInOutDateInclude? include,
  }) async {
    return session.dbNext.findById<RoomInOutDate>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<RoomInOutDate>> insert(
    _i1.Session session,
    List<RoomInOutDate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<RoomInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomInOutDate> insertRow(
    _i1.Session session,
    RoomInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<RoomInOutDate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoomInOutDate>> update(
    _i1.Session session,
    List<RoomInOutDate> rows, {
    _i1.ColumnSelections<RoomInOutDateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<RoomInOutDate>(
      rows,
      columns: columns?.call(RoomInOutDate.t),
      transaction: transaction,
    );
  }

  Future<RoomInOutDate> updateRow(
    _i1.Session session,
    RoomInOutDate row, {
    _i1.ColumnSelections<RoomInOutDateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<RoomInOutDate>(
      row,
      columns: columns?.call(RoomInOutDate.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<RoomInOutDate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<RoomInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    RoomInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<RoomInOutDate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomInOutDateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<RoomInOutDate>(
      where: where(RoomInOutDate.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomInOutDateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<RoomInOutDate>(
      where: where?.call(RoomInOutDate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RoomInOutDateAttachRowRepository {
  const RoomInOutDateAttachRowRepository._();

  Future<void> guest(
    _i1.Session session,
    RoomInOutDate roomInOutDate,
    _i2.Guest guest,
  ) async {
    if (roomInOutDate.id == null) {
      throw ArgumentError.notNull('roomInOutDate.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomInOutDate = roomInOutDate.copyWith(guestId: guest.id);
    await session.dbNext.updateRow<RoomInOutDate>(
      $roomInOutDate,
      columns: [RoomInOutDate.t.guestId],
    );
  }
}
