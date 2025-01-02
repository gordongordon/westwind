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
import 'rateType.dart' as _i2;
import 'company.dart' as _i3;
import 'roomGuest.dart' as _i4;

abstract class Guest implements _i1.TableRow, _i1.ProtocolSerialization {
  Guest._({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    required this.isInHouse,
    required this.dateCreate,
    this.dateUpdate,
    required this.rateType,
    required this.staffId,
    required this.companyId,
    this.company,
    this.rigNumber,
    required this.accountBalance,
    this.roomGuets,
    required this.note,
  });

  factory Guest({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required bool isInHouse,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required _i2.RateType rateType,
    required int staffId,
    required int companyId,
    _i3.Company? company,
    int? rigNumber,
    required double accountBalance,
    List<_i4.RoomGuest>? roomGuets,
    required String note,
  }) = _GuestImpl;

  factory Guest.fromJson(Map<String, dynamic> jsonSerialization) {
    return Guest(
      id: jsonSerialization['id'] as int?,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      isInHouse: jsonSerialization['isInHouse'] as bool,
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
      rateType:
          _i2.RateType.fromJson((jsonSerialization['rateType'] as String)),
      staffId: jsonSerialization['staffId'] as int,
      companyId: jsonSerialization['companyId'] as int,
      company: jsonSerialization['company'] == null
          ? null
          : _i3.Company.fromJson(
              (jsonSerialization['company'] as Map<String, dynamic>)),
      rigNumber: jsonSerialization['rigNumber'] as int?,
      accountBalance: (jsonSerialization['accountBalance'] as num).toDouble(),
      roomGuets: (jsonSerialization['roomGuets'] as List?)
          ?.map((e) => _i4.RoomGuest.fromJson((e as Map<String, dynamic>)))
          .toList(),
      note: jsonSerialization['note'] as String,
    );
  }

  static final t = GuestTable();

  static const db = GuestRepository._();

  @override
  int? id;

  String firstName;

  String lastName;

  String phone;

  String? email;

  bool isInHouse;

  DateTime dateCreate;

  DateTime? dateUpdate;

  _i2.RateType rateType;

  int staffId;

  int companyId;

  _i3.Company? company;

  int? rigNumber;

  double accountBalance;

  List<_i4.RoomGuest>? roomGuets;

  String note;

  @override
  _i1.Table get table => t;

  Guest copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    bool? isInHouse,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    _i2.RateType? rateType,
    int? staffId,
    int? companyId,
    _i3.Company? company,
    int? rigNumber,
    double? accountBalance,
    List<_i4.RoomGuest>? roomGuets,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      if (email != null) 'email': email,
      'isInHouse': isInHouse,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'rateType': rateType.toJson(),
      'staffId': staffId,
      'companyId': companyId,
      if (company != null) 'company': company?.toJson(),
      if (rigNumber != null) 'rigNumber': rigNumber,
      'accountBalance': accountBalance,
      if (roomGuets != null)
        'roomGuets': roomGuets?.toJson(valueToJson: (v) => v.toJson()),
      'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      if (email != null) 'email': email,
      'isInHouse': isInHouse,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'rateType': rateType.toJson(),
      'staffId': staffId,
      'companyId': companyId,
      if (company != null) 'company': company?.toJsonForProtocol(),
      if (rigNumber != null) 'rigNumber': rigNumber,
      'accountBalance': accountBalance,
      if (roomGuets != null)
        'roomGuets':
            roomGuets?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'note': note,
    };
  }

  static GuestInclude include({
    _i3.CompanyInclude? company,
    _i4.RoomGuestIncludeList? roomGuets,
  }) {
    return GuestInclude._(
      company: company,
      roomGuets: roomGuets,
    );
  }

  static GuestIncludeList includeList({
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestTable>? orderByList,
    GuestInclude? include,
  }) {
    return GuestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Guest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Guest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required bool isInHouse,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required _i2.RateType rateType,
    required int staffId,
    required int companyId,
    _i3.Company? company,
    int? rigNumber,
    required double accountBalance,
    List<_i4.RoomGuest>? roomGuets,
    required String note,
  }) : super._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          isInHouse: isInHouse,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          rateType: rateType,
          staffId: staffId,
          companyId: companyId,
          company: company,
          rigNumber: rigNumber,
          accountBalance: accountBalance,
          roomGuets: roomGuets,
          note: note,
        );

  @override
  Guest copyWith({
    Object? id = _Undefined,
    String? firstName,
    String? lastName,
    String? phone,
    Object? email = _Undefined,
    bool? isInHouse,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    _i2.RateType? rateType,
    int? staffId,
    int? companyId,
    Object? company = _Undefined,
    Object? rigNumber = _Undefined,
    double? accountBalance,
    Object? roomGuets = _Undefined,
    String? note,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      isInHouse: isInHouse ?? this.isInHouse,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      rateType: rateType ?? this.rateType,
      staffId: staffId ?? this.staffId,
      companyId: companyId ?? this.companyId,
      company: company is _i3.Company? ? company : this.company?.copyWith(),
      rigNumber: rigNumber is int? ? rigNumber : this.rigNumber,
      accountBalance: accountBalance ?? this.accountBalance,
      roomGuets: roomGuets is List<_i4.RoomGuest>?
          ? roomGuets
          : this.roomGuets?.map((e0) => e0.copyWith()).toList(),
      note: note ?? this.note,
    );
  }
}

class GuestTable extends _i1.Table {
  GuestTable({super.tableRelation}) : super(tableName: 'guest') {
    firstName = _i1.ColumnString(
      'firstName',
      this,
    );
    lastName = _i1.ColumnString(
      'lastName',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    isInHouse = _i1.ColumnBool(
      'isInHouse',
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
    rateType = _i1.ColumnEnum(
      'rateType',
      this,
      _i1.EnumSerialization.byName,
    );
    staffId = _i1.ColumnInt(
      'staffId',
      this,
    );
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    rigNumber = _i1.ColumnInt(
      'rigNumber',
      this,
    );
    accountBalance = _i1.ColumnDouble(
      'accountBalance',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
  }

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnBool isInHouse;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateUpdate;

  late final _i1.ColumnEnum<_i2.RateType> rateType;

  late final _i1.ColumnInt staffId;

  late final _i1.ColumnInt companyId;

  _i3.CompanyTable? _company;

  late final _i1.ColumnInt rigNumber;

  late final _i1.ColumnDouble accountBalance;

  _i4.RoomGuestTable? ___roomGuets;

  _i1.ManyRelation<_i4.RoomGuestTable>? _roomGuets;

  late final _i1.ColumnString note;

  _i3.CompanyTable get company {
    if (_company != null) return _company!;
    _company = _i1.createRelationTable(
      relationFieldName: 'company',
      field: Guest.t.companyId,
      foreignField: _i3.Company.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompanyTable(tableRelation: foreignTableRelation),
    );
    return _company!;
  }

  _i4.RoomGuestTable get __roomGuets {
    if (___roomGuets != null) return ___roomGuets!;
    ___roomGuets = _i1.createRelationTable(
      relationFieldName: '__roomGuets',
      field: Guest.t.id,
      foreignField: _i4.RoomGuest.t.guestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RoomGuestTable(tableRelation: foreignTableRelation),
    );
    return ___roomGuets!;
  }

  _i1.ManyRelation<_i4.RoomGuestTable> get roomGuets {
    if (_roomGuets != null) return _roomGuets!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'roomGuets',
      field: Guest.t.id,
      foreignField: _i4.RoomGuest.t.guestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RoomGuestTable(tableRelation: foreignTableRelation),
    );
    _roomGuets = _i1.ManyRelation<_i4.RoomGuestTable>(
      tableWithRelations: relationTable,
      table: _i4.RoomGuestTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _roomGuets!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        firstName,
        lastName,
        phone,
        email,
        isInHouse,
        dateCreate,
        dateUpdate,
        rateType,
        staffId,
        companyId,
        rigNumber,
        accountBalance,
        note,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'company') {
      return company;
    }
    if (relationField == 'roomGuets') {
      return __roomGuets;
    }
    return null;
  }
}

class GuestInclude extends _i1.IncludeObject {
  GuestInclude._({
    _i3.CompanyInclude? company,
    _i4.RoomGuestIncludeList? roomGuets,
  }) {
    _company = company;
    _roomGuets = roomGuets;
  }

  _i3.CompanyInclude? _company;

  _i4.RoomGuestIncludeList? _roomGuets;

  @override
  Map<String, _i1.Include?> get includes => {
        'company': _company,
        'roomGuets': _roomGuets,
      };

  @override
  _i1.Table get table => Guest.t;
}

class GuestIncludeList extends _i1.IncludeList {
  GuestIncludeList._({
    _i1.WhereExpressionBuilder<GuestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Guest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Guest.t;
}

class GuestRepository {
  const GuestRepository._();

  final attach = const GuestAttachRepository._();

  final attachRow = const GuestAttachRowRepository._();

  final detach = const GuestDetachRepository._();

  final detachRow = const GuestDetachRowRepository._();

  Future<List<Guest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestTable>? orderByList,
    _i1.Transaction? transaction,
    GuestInclude? include,
  }) async {
    return session.db.find<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Guest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? offset,
    _i1.OrderByBuilder<GuestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GuestTable>? orderByList,
    _i1.Transaction? transaction,
    GuestInclude? include,
  }) async {
    return session.db.findFirstRow<Guest>(
      where: where?.call(Guest.t),
      orderBy: orderBy?.call(Guest.t),
      orderByList: orderByList?.call(Guest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Guest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    GuestInclude? include,
  }) async {
    return session.db.findById<Guest>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Guest>> insert(
    _i1.Session session,
    List<Guest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Guest>(
      rows,
      transaction: transaction,
    );
  }

  Future<Guest> insertRow(
    _i1.Session session,
    Guest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Guest>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Guest>> update(
    _i1.Session session,
    List<Guest> rows, {
    _i1.ColumnSelections<GuestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Guest>(
      rows,
      columns: columns?.call(Guest.t),
      transaction: transaction,
    );
  }

  Future<Guest> updateRow(
    _i1.Session session,
    Guest row, {
    _i1.ColumnSelections<GuestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Guest>(
      row,
      columns: columns?.call(Guest.t),
      transaction: transaction,
    );
  }

  Future<List<Guest>> delete(
    _i1.Session session,
    List<Guest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Guest>(
      rows,
      transaction: transaction,
    );
  }

  Future<Guest> deleteRow(
    _i1.Session session,
    Guest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Guest>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Guest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Guest>(
      where: where(Guest.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Guest>(
      where: where?.call(Guest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class GuestAttachRepository {
  const GuestAttachRepository._();

  Future<void> roomGuets(
    _i1.Session session,
    Guest guest,
    List<_i4.RoomGuest> roomGuest, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomGuest =
        roomGuest.map((e) => e.copyWith(guestId: guest.id)).toList();
    await session.db.update<_i4.RoomGuest>(
      $roomGuest,
      columns: [_i4.RoomGuest.t.guestId],
      transaction: transaction,
    );
  }
}

class GuestAttachRowRepository {
  const GuestAttachRowRepository._();

  Future<void> company(
    _i1.Session session,
    Guest guest,
    _i3.Company company, {
    _i1.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (company.id == null) {
      throw ArgumentError.notNull('company.id');
    }

    var $guest = guest.copyWith(companyId: company.id);
    await session.db.updateRow<Guest>(
      $guest,
      columns: [Guest.t.companyId],
      transaction: transaction,
    );
  }

  Future<void> roomGuets(
    _i1.Session session,
    Guest guest,
    _i4.RoomGuest roomGuest, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomGuest = roomGuest.copyWith(guestId: guest.id);
    await session.db.updateRow<_i4.RoomGuest>(
      $roomGuest,
      columns: [_i4.RoomGuest.t.guestId],
      transaction: transaction,
    );
  }
}

class GuestDetachRepository {
  const GuestDetachRepository._();

  Future<void> roomGuets(
    _i1.Session session,
    List<_i4.RoomGuest> roomGuest, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomGuest = roomGuest.map((e) => e.copyWith(guestId: null)).toList();
    await session.db.update<_i4.RoomGuest>(
      $roomGuest,
      columns: [_i4.RoomGuest.t.guestId],
      transaction: transaction,
    );
  }
}

class GuestDetachRowRepository {
  const GuestDetachRowRepository._();

  Future<void> roomGuets(
    _i1.Session session,
    _i4.RoomGuest roomGuest, {
    _i1.Transaction? transaction,
  }) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomGuest = roomGuest.copyWith(guestId: null);
    await session.db.updateRow<_i4.RoomGuest>(
      $roomGuest,
      columns: [_i4.RoomGuest.t.guestId],
      transaction: transaction,
    );
  }
}
