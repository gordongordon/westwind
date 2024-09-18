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

abstract class RoomInOutDate extends _i1.TableRow
    implements _i1.ProtocolSerialization {
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

  factory RoomInOutDate.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomInOutDate(
      id: jsonSerialization['id'] as int?,
      checkInDate: jsonSerialization['checkInDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['checkInDate']),
      checkOutDate: jsonSerialization['checkOutDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['checkOutDate']),
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      roomNumber:
          _i2.RoomNumber.fromJson((jsonSerialization['roomNumber'] as String)),
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (checkInDate != null) 'checkInDate': checkInDate?.toJson(),
      if (checkOutDate != null) 'checkOutDate': checkOutDate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
    };
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    return session.db.find<RoomInOutDate>(
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
    return session.db.findFirstRow<RoomInOutDate>(
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
    return session.db.findById<RoomInOutDate>(
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
    return session.db.insert<RoomInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomInOutDate> insertRow(
    _i1.Session session,
    RoomInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomInOutDate>(
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
    return session.db.update<RoomInOutDate>(
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
    return session.db.updateRow<RoomInOutDate>(
      row,
      columns: columns?.call(RoomInOutDate.t),
      transaction: transaction,
    );
  }

  Future<List<RoomInOutDate>> delete(
    _i1.Session session,
    List<RoomInOutDate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomInOutDate>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoomInOutDate> deleteRow(
    _i1.Session session,
    RoomInOutDate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomInOutDate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoomInOutDate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomInOutDateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomInOutDate>(
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
    return session.db.count<RoomInOutDate>(
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
    _i2.Guest guest, {
    _i1.Transaction? transaction,
  }) async {
    if (roomInOutDate.id == null) {
      throw ArgumentError.notNull('roomInOutDate.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomInOutDate = roomInOutDate.copyWith(guestId: guest.id);
    await session.db.updateRow<RoomInOutDate>(
      $roomInOutDate,
      columns: [RoomInOutDate.t.guestId],
      transaction: transaction,
    );
  }
}
