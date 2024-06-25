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

abstract class Company extends _i1.TableRow {
  Company._({
    int? id,
    required this.name,
    required this.contactName,
    required this.phone,
    required this.email,
    required this.dateCreate,
    this.dateUpdate,
    required this.byStaffId,
    this.guests,
  }) : super(id);

  factory Company({
    int? id,
    required String name,
    required String contactName,
    required String phone,
    required String email,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int byStaffId,
    List<_i2.Guest>? guests,
  }) = _CompanyImpl;

  factory Company.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Company(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      contactName: serializationManager
          .deserialize<String>(jsonSerialization['contactName']),
      phone:
          serializationManager.deserialize<String>(jsonSerialization['phone']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      byStaffId:
          serializationManager.deserialize<int>(jsonSerialization['byStaffId']),
      guests: serializationManager
          .deserialize<List<_i2.Guest>?>(jsonSerialization['guests']),
    );
  }

  static final t = CompanyTable();

  static const db = CompanyRepository._();

  String name;

  String contactName;

  String phone;

  String email;

  DateTime dateCreate;

  DateTime? dateUpdate;

  int byStaffId;

  List<_i2.Guest>? guests;

  @override
  _i1.Table get table => t;

  Company copyWith({
    int? id,
    String? name,
    String? contactName,
    String? phone,
    String? email,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? byStaffId,
    List<_i2.Guest>? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'contactName': contactName,
      'phone': phone,
      'email': email,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'byStaffId': byStaffId,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'name': name,
      'contactName': contactName,
      'phone': phone,
      'email': email,
      'dateCreate': dateCreate,
      'dateUpdate': dateUpdate,
      'byStaffId': byStaffId,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'contactName': contactName,
      'phone': phone,
      'email': email,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'byStaffId': byStaffId,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.allToJson()),
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
      case 'name':
        name = value;
        return;
      case 'contactName':
        contactName = value;
        return;
      case 'phone':
        phone = value;
        return;
      case 'email':
        email = value;
        return;
      case 'dateCreate':
        dateCreate = value;
        return;
      case 'dateUpdate':
        dateUpdate = value;
        return;
      case 'byStaffId':
        byStaffId = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Company>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    CompanyInclude? include,
  }) async {
    return session.db.find<Company>(
      where: where != null ? where(Company.t) : null,
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
  static Future<Company?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    CompanyInclude? include,
  }) async {
    return session.db.findSingleRow<Company>(
      where: where != null ? where(Company.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Company?> findById(
    _i1.Session session,
    int id, {
    CompanyInclude? include,
  }) async {
    return session.db.findById<Company>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompanyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Company>(
      where: where(Company.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Company row, {
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
    Company row, {
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
    Company row, {
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
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Company>(
      where: where != null ? where(Company.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static CompanyInclude include({_i2.GuestIncludeList? guests}) {
    return CompanyInclude._(guests: guests);
  }

  static CompanyIncludeList includeList({
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompanyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompanyTable>? orderByList,
    CompanyInclude? include,
  }) {
    return CompanyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Company.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Company.t),
      include: include,
    );
  }
}

class _Undefined {}

class _CompanyImpl extends Company {
  _CompanyImpl({
    int? id,
    required String name,
    required String contactName,
    required String phone,
    required String email,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int byStaffId,
    List<_i2.Guest>? guests,
  }) : super._(
          id: id,
          name: name,
          contactName: contactName,
          phone: phone,
          email: email,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          byStaffId: byStaffId,
          guests: guests,
        );

  @override
  Company copyWith({
    Object? id = _Undefined,
    String? name,
    String? contactName,
    String? phone,
    String? email,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    int? byStaffId,
    Object? guests = _Undefined,
  }) {
    return Company(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      byStaffId: byStaffId ?? this.byStaffId,
      guests: guests is List<_i2.Guest>? ? guests : this.guests?.clone(),
    );
  }
}

class CompanyTable extends _i1.Table {
  CompanyTable({super.tableRelation}) : super(tableName: 'company') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    contactName = _i1.ColumnString(
      'contactName',
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
    dateCreate = _i1.ColumnDateTime(
      'dateCreate',
      this,
    );
    dateUpdate = _i1.ColumnDateTime(
      'dateUpdate',
      this,
    );
    byStaffId = _i1.ColumnInt(
      'byStaffId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString contactName;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateUpdate;

  late final _i1.ColumnInt byStaffId;

  _i2.GuestTable? ___guests;

  _i1.ManyRelation<_i2.GuestTable>? _guests;

  _i2.GuestTable get __guests {
    if (___guests != null) return ___guests!;
    ___guests = _i1.createRelationTable(
      relationFieldName: '__guests',
      field: Company.t.id,
      foreignField: _i2.Guest.t.companyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    return ___guests!;
  }

  _i1.ManyRelation<_i2.GuestTable> get guests {
    if (_guests != null) return _guests!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'guests',
      field: Company.t.id,
      foreignField: _i2.Guest.t.companyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.GuestTable(tableRelation: foreignTableRelation),
    );
    _guests = _i1.ManyRelation<_i2.GuestTable>(
      tableWithRelations: relationTable,
      table: _i2.GuestTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _guests!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        contactName,
        phone,
        email,
        dateCreate,
        dateUpdate,
        byStaffId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guests') {
      return __guests;
    }
    return null;
  }
}

@Deprecated('Use CompanyTable.t instead.')
CompanyTable tCompany = CompanyTable();

class CompanyInclude extends _i1.IncludeObject {
  CompanyInclude._({_i2.GuestIncludeList? guests}) {
    _guests = guests;
  }

  _i2.GuestIncludeList? _guests;

  @override
  Map<String, _i1.Include?> get includes => {'guests': _guests};

  @override
  _i1.Table get table => Company.t;
}

class CompanyIncludeList extends _i1.IncludeList {
  CompanyIncludeList._({
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Company.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Company.t;
}

class CompanyRepository {
  const CompanyRepository._();

  final attach = const CompanyAttachRepository._();

  final attachRow = const CompanyAttachRowRepository._();

  final detach = const CompanyDetachRepository._();

  final detachRow = const CompanyDetachRowRepository._();

  Future<List<Company>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompanyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompanyTable>? orderByList,
    _i1.Transaction? transaction,
    CompanyInclude? include,
  }) async {
    return session.dbNext.find<Company>(
      where: where?.call(Company.t),
      orderBy: orderBy?.call(Company.t),
      orderByList: orderByList?.call(Company.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Company?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompanyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompanyTable>? orderByList,
    _i1.Transaction? transaction,
    CompanyInclude? include,
  }) async {
    return session.dbNext.findFirstRow<Company>(
      where: where?.call(Company.t),
      orderBy: orderBy?.call(Company.t),
      orderByList: orderByList?.call(Company.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Company?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompanyInclude? include,
  }) async {
    return session.dbNext.findById<Company>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Company>> insert(
    _i1.Session session,
    List<Company> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Company>(
      rows,
      transaction: transaction,
    );
  }

  Future<Company> insertRow(
    _i1.Session session,
    Company row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Company>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Company>> update(
    _i1.Session session,
    List<Company> rows, {
    _i1.ColumnSelections<CompanyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Company>(
      rows,
      columns: columns?.call(Company.t),
      transaction: transaction,
    );
  }

  Future<Company> updateRow(
    _i1.Session session,
    Company row, {
    _i1.ColumnSelections<CompanyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Company>(
      row,
      columns: columns?.call(Company.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Company> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Company>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Company row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Company>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompanyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Company>(
      where: where(Company.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompanyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Company>(
      where: where?.call(Company.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompanyAttachRepository {
  const CompanyAttachRepository._();

  Future<void> guests(
    _i1.Session session,
    Company company,
    List<_i2.Guest> guest,
  ) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }
    if (company.id == null) {
      throw ArgumentError.notNull('company.id');
    }

    var $guest = guest.map((e) => e.copyWith(companyId: company.id)).toList();
    await session.dbNext.update<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
    );
  }
}

class CompanyAttachRowRepository {
  const CompanyAttachRowRepository._();

  Future<void> guests(
    _i1.Session session,
    Company company,
    _i2.Guest guest,
  ) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (company.id == null) {
      throw ArgumentError.notNull('company.id');
    }

    var $guest = guest.copyWith(companyId: company.id);
    await session.dbNext.updateRow<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
    );
  }
}

class CompanyDetachRepository {
  const CompanyDetachRepository._();

  Future<void> guests(
    _i1.Session session,
    List<_i2.Guest> guest,
  ) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest.map((e) => e.copyWith(companyId: null)).toList();
    await session.dbNext.update<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
    );
  }
}

class CompanyDetachRowRepository {
  const CompanyDetachRowRepository._();

  Future<void> guests(
    _i1.Session session,
    _i2.Guest guest,
  ) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest.copyWith(companyId: null);
    await session.dbNext.updateRow<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
    );
  }
}
