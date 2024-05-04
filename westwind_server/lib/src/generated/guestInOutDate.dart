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

abstract class GuestInOutDate extends _i1.TableRow {
  GuestInOutDate._({
    int? id,
    required this.roomNumber,
    required this.dateCreate,
    this.dateUpdate,
    required this.guestId,
    this.guest,
    required this.inOutReason,
  }) : super(id);

  factory GuestInOutDate({
    int? id,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.InOutReason inOutReason,
  }) = _GuestInOutDateImpl;

  factory GuestInOutDate.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return GuestInOutDate(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      inOutReason: serializationManager
          .deserialize<_i2.InOutReason>(jsonSerialization['inOutReason']),
    );
  }

  static final t = GuestInOutDateTable();

  static const db = GuestInOutDateRepository._();

  _i2.RoomNumber roomNumber;

  DateTime dateCreate;

  DateTime? dateUpdate;

  int guestId;

  _i2.Guest? guest;

  _i2.InOutReason inOutReason;

  @override
  _i1.Table get table => t;

  GuestInOutDate copyWith({
    int? id,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? guestId,
    _i2.Guest? guest,
    _i2.InOutReason? inOutReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'inOutReason': inOutReason.toJson(),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'dateCreate': dateCreate,
      'dateUpdate': dateUpdate,
      'guestId': guestId,
      'inOutReason': inOutReason,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.allToJson(),
      'inOutReason': inOutReason.toJson(),
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
      case 'dateCreate':
        dateCreate = value;
        return;
      case 'dateUpdate':
        dateUpdate = value;
        return;
      case 'guestId':
        guestId = value;
        return;
      case 'inOutReason':
        inOutReason = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<GuestInOutDate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    GuestInOutDateInclude? include,
  }) async {
    return session.db.find<GuestInOutDate>(
      where: where != null ? where(GuestInOutDate.t) : null,
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
  static Future<GuestInOutDate?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    GuestInOutDateInclude? include,
  }) async {
    return session.db.findSingleRow<GuestInOutDate>(
      where: where != null ? where(GuestInOutDate.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<GuestInOutDate?> findById(
    _i1.Session session,
    int id, {
    GuestInOutDateInclude? include,
  }) async {
    return session.db.findById<GuestInOutDate>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestInOutDateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GuestInOutDate>(
      where: where(GuestInOutDate.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    GuestInOutDate row, {
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
    GuestInOutDate row, {
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
    GuestInOutDate row, {
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
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GuestInOutDate>(
      where: where != null ? where(GuestInOutDate.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static GuestInOutDateInclude include({_i2.GuestInclude? guest}) {
    return GuestInOutDateInclude._(guest: guest);
  }

  static GuestInOutDateIncludeList includeList({
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuestInOutDateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestInOutDateTable>? orderByList,
    GuestInOutDateInclude? include,
  }) {
    return GuestInOutDateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GuestInOutDate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GuestInOutDate.t),
      include: include,
    );
  }
}

class _Undefined {}

class _GuestInOutDateImpl extends GuestInOutDate {
  _GuestInOutDateImpl({
    int? id,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.InOutReason inOutReason,
  }) : super._(
          id: id,
          roomNumber: roomNumber,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          guestId: guestId,
          guest: guest,
          inOutReason: inOutReason,
        );

  @override
  GuestInOutDate copyWith({
    Object? id = _Undefined,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    _i2.InOutReason? inOutReason,
  }) {
    return GuestInOutDate(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      inOutReason: inOutReason ?? this.inOutReason,
    );
  }
}

class GuestInOutDateTable extends _i1.Table {
  GuestInOutDateTable({super.tableRelation})
      : super(tableName: 'guest_in_out_date') {
    roomNumber = _i1.ColumnEnum(
      'roomNumber',
      this,
      _i1.EnumSerialization.byName,
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
    inOutReason = _i1.ColumnEnum(
      'inOutReason',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final _i1.ColumnEnum<_i2.RoomNumber> roomNumber;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateUpdate;

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  late final _i1.ColumnEnum<_i2.InOutReason> inOutReason;

  _i2.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: GuestInOutDate.t.guestId,
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
        roomNumber,
        dateCreate,
        dateUpdate,
        guestId,
        inOutReason,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guest') {
      return guest;
    }
    return null;
  }
}

@Deprecated('Use GuestInOutDateTable.t instead.')
GuestInOutDateTable tGuestInOutDate = GuestInOutDateTable();

class GuestInOutDateInclude extends _i1.IncludeObject {
  GuestInOutDateInclude._({_i2.GuestInclude? guest}) {
    _guest = guest;
  }

  _i2.GuestInclude? _guest;

  @override
  Map<String, _i1.Include?> get includes => {'guest': _guest};

  @override
  _i1.Table get table => GuestInOutDate.t;
}

class GuestInOutDateIncludeList extends _i1.IncludeList {
  GuestInOutDateIncludeList._({
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GuestInOutDate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => GuestInOutDate.t;
}

class GuestInOutDateRepository {
  const GuestInOutDateRepository._();

  final attachRow = const GuestInOutDateAttachRowRepository._();

  Future<List<GuestInOutDate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuestInOutDateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestInOutDateTable>? orderByList,
    _i1.Transaction? transaction,
    GuestInOutDateInclude? include,
  }) async {
    return session.dbNext.find<GuestInOutDate>(
      where: where?.call(GuestInOutDate.t),
      orderBy: orderBy?.call(GuestInOutDate.t),
      orderByList: orderByList?.call(GuestInOutDate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<GuestInOutDate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? offset,
    _i1.OrderByBuilder<GuestInOutDateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestInOutDateTable>? orderByList,
    _i1.Transaction? transaction,
    GuestInOutDateInclude? include,
  }) async {
    return session.dbNext.findFirstRow<GuestInOutDate>(
      where: where?.call(GuestInOutDate.t),
      orderBy: orderBy?.call(GuestInOutDate.t),
      orderByList: orderByList?.call(GuestInOutDate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<GuestInOutDate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    GuestInOutDateInclude? include,
  }) async {
    return session.dbNext.findById<GuestInOutDate>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<GuestInOutDate>> insert(
    _i1.Session session,
    List<GuestInOutDate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<GuestInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<GuestInOutDate> insertRow(
    _i1.Session session,
    GuestInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<GuestInOutDate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<GuestInOutDate>> update(
    _i1.Session session,
    List<GuestInOutDate> rows, {
    _i1.ColumnSelections<GuestInOutDateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<GuestInOutDate>(
      rows,
      columns: columns?.call(GuestInOutDate.t),
      transaction: transaction,
    );
  }

  Future<GuestInOutDate> updateRow(
    _i1.Session session,
    GuestInOutDate row, {
    _i1.ColumnSelections<GuestInOutDateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<GuestInOutDate>(
      row,
      columns: columns?.call(GuestInOutDate.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<GuestInOutDate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<GuestInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    GuestInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<GuestInOutDate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestInOutDateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<GuestInOutDate>(
      where: where(GuestInOutDate.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestInOutDateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<GuestInOutDate>(
      where: where?.call(GuestInOutDate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class GuestInOutDateAttachRowRepository {
  const GuestInOutDateAttachRowRepository._();

  Future<void> guest(
    _i1.Session session,
    GuestInOutDate guestInOutDate,
    _i2.Guest guest,
  ) async {
    if (guestInOutDate.id == null) {
      throw ArgumentError.notNull('guestInOutDate.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guestInOutDate = guestInOutDate.copyWith(guestId: guest.id);
    await session.dbNext.updateRow<GuestInOutDate>(
      $guestInOutDate,
      columns: [GuestInOutDate.t.guestId],
    );
  }
}
