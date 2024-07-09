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

abstract class Guest extends _i1.TableRow {
  Guest._({
    int? id,
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
  }) : super(id);

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
    _i2.Company? company,
    int? rigNumber,
    required double accountBalance,
    List<_i2.RoomGuest>? roomGuets,
  }) = _GuestImpl;

  factory Guest.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Guest(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      firstName: serializationManager
          .deserialize<String>(jsonSerialization['firstName']),
      lastName: serializationManager
          .deserialize<String>(jsonSerialization['lastName']),
      phone:
          serializationManager.deserialize<String>(jsonSerialization['phone']),
      email:
          serializationManager.deserialize<String?>(jsonSerialization['email']),
      isInHouse: serializationManager
          .deserialize<bool>(jsonSerialization['isInHouse']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      staffId:
          serializationManager.deserialize<int>(jsonSerialization['staffId']),
      companyId:
          serializationManager.deserialize<int>(jsonSerialization['companyId']),
      company: serializationManager
          .deserialize<_i2.Company?>(jsonSerialization['company']),
      rigNumber: serializationManager
          .deserialize<int?>(jsonSerialization['rigNumber']),
      accountBalance: serializationManager
          .deserialize<double>(jsonSerialization['accountBalance']),
      roomGuets: serializationManager
          .deserialize<List<_i2.RoomGuest>?>(jsonSerialization['roomGuets']),
    );
  }

  static final t = GuestTable();

  static const db = GuestRepository._();

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

  _i2.Company? company;

  int? rigNumber;

  double accountBalance;

  List<_i2.RoomGuest>? roomGuets;

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
    _i2.Company? company,
    int? rigNumber,
    double? accountBalance,
    List<_i2.RoomGuest>? roomGuets,
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
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'isInHouse': isInHouse,
      'dateCreate': dateCreate,
      'dateUpdate': dateUpdate,
      'rateType': rateType,
      'staffId': staffId,
      'companyId': companyId,
      'rigNumber': rigNumber,
      'accountBalance': accountBalance,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
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
      if (company != null) 'company': company?.allToJson(),
      if (rigNumber != null) 'rigNumber': rigNumber,
      'accountBalance': accountBalance,
      if (roomGuets != null)
        'roomGuets': roomGuets?.toJson(valueToJson: (v) => v.allToJson()),
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
      case 'firstName':
        firstName = value;
        return;
      case 'lastName':
        lastName = value;
        return;
      case 'phone':
        phone = value;
        return;
      case 'email':
        email = value;
        return;
      case 'isInHouse':
        isInHouse = value;
        return;
      case 'dateCreate':
        dateCreate = value;
        return;
      case 'dateUpdate':
        dateUpdate = value;
        return;
      case 'rateType':
        rateType = value;
        return;
      case 'staffId':
        staffId = value;
        return;
      case 'companyId':
        companyId = value;
        return;
      case 'rigNumber':
        rigNumber = value;
        return;
      case 'accountBalance':
        accountBalance = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Guest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    GuestInclude? include,
  }) async {
    return session.db.find<Guest>(
      where: where != null ? where(Guest.t) : null,
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
  static Future<Guest?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    GuestInclude? include,
  }) async {
    return session.db.findSingleRow<Guest>(
      where: where != null ? where(Guest.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Guest?> findById(
    _i1.Session session,
    int id, {
    GuestInclude? include,
  }) async {
    return session.db.findById<Guest>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Guest>(
      where: where(Guest.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Guest row, {
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
    Guest row, {
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
    Guest row, {
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
    _i1.WhereExpressionBuilder<GuestTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Guest>(
      where: where != null ? where(Guest.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static GuestInclude include({
    _i2.CompanyInclude? company,
    _i2.RoomGuestIncludeList? roomGuets,
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
    _i2.Company? company,
    int? rigNumber,
    required double accountBalance,
    List<_i2.RoomGuest>? roomGuets,
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
      company: company is _i2.Company? ? company : this.company?.copyWith(),
      rigNumber: rigNumber is int? ? rigNumber : this.rigNumber,
      accountBalance: accountBalance ?? this.accountBalance,
      roomGuets: roomGuets is List<_i2.RoomGuest>?
          ? roomGuets
          : this.roomGuets?.clone(),
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

  _i2.CompanyTable? _company;

  late final _i1.ColumnInt rigNumber;

  late final _i1.ColumnDouble accountBalance;

  _i2.RoomGuestTable? ___roomGuets;

  _i1.ManyRelation<_i2.RoomGuestTable>? _roomGuets;

  _i2.CompanyTable get company {
    if (_company != null) return _company!;
    _company = _i1.createRelationTable(
      relationFieldName: 'company',
      field: Guest.t.companyId,
      foreignField: _i2.Company.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompanyTable(tableRelation: foreignTableRelation),
    );
    return _company!;
  }

  _i2.RoomGuestTable get __roomGuets {
    if (___roomGuets != null) return ___roomGuets!;
    ___roomGuets = _i1.createRelationTable(
      relationFieldName: '__roomGuets',
      field: Guest.t.id,
      foreignField: _i2.RoomGuest.t.guestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomGuestTable(tableRelation: foreignTableRelation),
    );
    return ___roomGuets!;
  }

  _i1.ManyRelation<_i2.RoomGuestTable> get roomGuets {
    if (_roomGuets != null) return _roomGuets!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'roomGuets',
      field: Guest.t.id,
      foreignField: _i2.RoomGuest.t.guestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoomGuestTable(tableRelation: foreignTableRelation),
    );
    _roomGuets = _i1.ManyRelation<_i2.RoomGuestTable>(
      tableWithRelations: relationTable,
      table: _i2.RoomGuestTable(
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

@Deprecated('Use GuestTable.t instead.')
GuestTable tGuest = GuestTable();

class GuestInclude extends _i1.IncludeObject {
  GuestInclude._({
    _i2.CompanyInclude? company,
    _i2.RoomGuestIncludeList? roomGuets,
  }) {
    _company = company;
    _roomGuets = roomGuets;
  }

  _i2.CompanyInclude? _company;

  _i2.RoomGuestIncludeList? _roomGuets;

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
    return session.dbNext.find<Guest>(
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
    return session.dbNext.findFirstRow<Guest>(
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
    return session.dbNext.findById<Guest>(
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
    return session.dbNext.insert<Guest>(
      rows,
      transaction: transaction,
    );
  }

  Future<Guest> insertRow(
    _i1.Session session,
    Guest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Guest>(
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
    return session.dbNext.update<Guest>(
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
    return session.dbNext.updateRow<Guest>(
      row,
      columns: columns?.call(Guest.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Guest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Guest>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Guest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Guest>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GuestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Guest>(
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
    return session.dbNext.count<Guest>(
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
    List<_i2.RoomGuest> roomGuest,
  ) async {
    if (roomGuest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomGuest =
        roomGuest.map((e) => e.copyWith(guestId: guest.id)).toList();
    await session.dbNext.update<_i2.RoomGuest>(
      $roomGuest,
      columns: [_i2.RoomGuest.t.guestId],
    );
  }
}

class GuestAttachRowRepository {
  const GuestAttachRowRepository._();

  Future<void> company(
    _i1.Session session,
    Guest guest,
    _i2.Company company,
  ) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (company.id == null) {
      throw ArgumentError.notNull('company.id');
    }

    var $guest = guest.copyWith(companyId: company.id);
    await session.dbNext.updateRow<Guest>(
      $guest,
      columns: [Guest.t.companyId],
    );
  }

  Future<void> roomGuets(
    _i1.Session session,
    Guest guest,
    _i2.RoomGuest roomGuest,
  ) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $roomGuest = roomGuest.copyWith(guestId: guest.id);
    await session.dbNext.updateRow<_i2.RoomGuest>(
      $roomGuest,
      columns: [_i2.RoomGuest.t.guestId],
    );
  }
}

class GuestDetachRepository {
  const GuestDetachRepository._();

  Future<void> roomGuets(
    _i1.Session session,
    List<_i2.RoomGuest> roomGuest,
  ) async {
    if (roomGuest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomGuest = roomGuest.map((e) => e.copyWith(guestId: null)).toList();
    await session.dbNext.update<_i2.RoomGuest>(
      $roomGuest,
      columns: [_i2.RoomGuest.t.guestId],
    );
  }
}

class GuestDetachRowRepository {
  const GuestDetachRowRepository._();

  Future<void> roomGuets(
    _i1.Session session,
    _i2.RoomGuest roomGuest,
  ) async {
    if (roomGuest.id == null) {
      throw ArgumentError.notNull('roomGuest.id');
    }

    var $roomGuest = roomGuest.copyWith(guestId: null);
    await session.dbNext.updateRow<_i2.RoomGuest>(
      $roomGuest,
      columns: [_i2.RoomGuest.t.guestId],
    );
  }
}
