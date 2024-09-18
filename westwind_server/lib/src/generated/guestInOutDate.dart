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
import 'protocol.dart' as _i2;

abstract class GuestInOutDate extends _i1.TableRow
    implements _i1.ProtocolSerialization {
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

  factory GuestInOutDate.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuestInOutDate(
      id: jsonSerialization['id'] as int?,
      roomNumber:
          _i2.RoomNumber.fromJson((jsonSerialization['roomNumber'] as String)),
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
      inOutReason: _i2.InOutReason.fromJson(
          (jsonSerialization['inOutReason'] as String)),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      'inOutReason': inOutReason.toJson(),
    };
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    return session.db.find<GuestInOutDate>(
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
    return session.db.findFirstRow<GuestInOutDate>(
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
    return session.db.findById<GuestInOutDate>(
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
    return session.db.insert<GuestInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<GuestInOutDate> insertRow(
    _i1.Session session,
    GuestInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GuestInOutDate>(
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
    return session.db.update<GuestInOutDate>(
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
    return session.db.updateRow<GuestInOutDate>(
      row,
      columns: columns?.call(GuestInOutDate.t),
      transaction: transaction,
    );
  }

  Future<List<GuestInOutDate>> delete(
    _i1.Session session,
    List<GuestInOutDate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GuestInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<GuestInOutDate> deleteRow(
    _i1.Session session,
    GuestInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GuestInOutDate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<GuestInOutDate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestInOutDateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GuestInOutDate>(
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
    return session.db.count<GuestInOutDate>(
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
    _i2.Guest guest, {
    _i1.Transaction? transaction,
  }) async {
    if (guestInOutDate.id == null) {
      throw ArgumentError.notNull('guestInOutDate.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guestInOutDate = guestInOutDate.copyWith(guestId: guest.id);
    await session.db.updateRow<GuestInOutDate>(
      $guestInOutDate,
      columns: [GuestInOutDate.t.guestId],
      transaction: transaction,
    );
  }
}
