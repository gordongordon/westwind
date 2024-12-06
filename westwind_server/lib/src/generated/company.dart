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
import 'guest.dart' as _i2;

abstract class Company implements _i1.TableRow, _i1.ProtocolSerialization {
  Company._({
    this.id,
    required this.name,
    required this.contactName,
    required this.phone,
    required this.email,
    required this.dateCreate,
    this.dateUpdate,
    required this.byStaffId,
    this.guests,
  });

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

  factory Company.fromJson(Map<String, dynamic> jsonSerialization) {
    return Company(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      contactName: jsonSerialization['contactName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
      byStaffId: jsonSerialization['byStaffId'] as int,
      guests: (jsonSerialization['guests'] as List?)
          ?.map((e) => _i2.Guest.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CompanyTable();

  static const db = CompanyRepository._();

  @override
  int? id;

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
  Map<String, dynamic> toJsonForProtocol() {
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
        'guests': guests?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
      guests: guests is List<_i2.Guest>?
          ? guests
          : this.guests?.map((e0) => e0.copyWith()).toList(),
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
    return session.db.find<Company>(
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
    return session.db.findFirstRow<Company>(
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
    return session.db.findById<Company>(
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
    return session.db.insert<Company>(
      rows,
      transaction: transaction,
    );
  }

  Future<Company> insertRow(
    _i1.Session session,
    Company row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Company>(
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
    return session.db.update<Company>(
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
    return session.db.updateRow<Company>(
      row,
      columns: columns?.call(Company.t),
      transaction: transaction,
    );
  }

  Future<List<Company>> delete(
    _i1.Session session,
    List<Company> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Company>(
      rows,
      transaction: transaction,
    );
  }

  Future<Company> deleteRow(
    _i1.Session session,
    Company row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Company>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Company>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompanyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Company>(
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
    return session.db.count<Company>(
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
    List<_i2.Guest> guest, {
    _i1.Transaction? transaction,
  }) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }
    if (company.id == null) {
      throw ArgumentError.notNull('company.id');
    }

    var $guest = guest.map((e) => e.copyWith(companyId: company.id)).toList();
    await session.db.update<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
      transaction: transaction,
    );
  }
}

class CompanyAttachRowRepository {
  const CompanyAttachRowRepository._();

  Future<void> guests(
    _i1.Session session,
    Company company,
    _i2.Guest guest, {
    _i1.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }
    if (company.id == null) {
      throw ArgumentError.notNull('company.id');
    }

    var $guest = guest.copyWith(companyId: company.id);
    await session.db.updateRow<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
      transaction: transaction,
    );
  }
}

class CompanyDetachRepository {
  const CompanyDetachRepository._();

  Future<void> guests(
    _i1.Session session,
    List<_i2.Guest> guest, {
    _i1.Transaction? transaction,
  }) async {
    if (guest.any((e) => e.id == null)) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest.map((e) => e.copyWith(companyId: null)).toList();
    await session.db.update<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
      transaction: transaction,
    );
  }
}

class CompanyDetachRowRepository {
  const CompanyDetachRowRepository._();

  Future<void> guests(
    _i1.Session session,
    _i2.Guest guest, {
    _i1.Transaction? transaction,
  }) async {
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $guest = guest.copyWith(companyId: null);
    await session.db.updateRow<_i2.Guest>(
      $guest,
      columns: [_i2.Guest.t.companyId],
      transaction: transaction,
    );
  }
}
