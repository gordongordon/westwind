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

abstract class Staff extends _i1.TableRow {
  Staff._({
    int? id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    this.timelogout,
    required this.timelogin,
    required this.permissionType,
    required this.dateCreate,
    this.dateUpdate,
  }) : super(id);

  factory Staff({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    DateTime? timelogout,
    required DateTime timelogin,
    required _i2.PermissionType permissionType,
    required DateTime dateCreate,
    DateTime? dateUpdate,
  }) = _StaffImpl;

  factory Staff.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Staff(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      firstName: serializationManager
          .deserialize<String>(jsonSerialization['firstName']),
      lastName: serializationManager
          .deserialize<String>(jsonSerialization['lastName']),
      phone:
          serializationManager.deserialize<String>(jsonSerialization['phone']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      password: serializationManager
          .deserialize<String>(jsonSerialization['password']),
      timelogout: serializationManager
          .deserialize<DateTime?>(jsonSerialization['timelogout']),
      timelogin: serializationManager
          .deserialize<DateTime>(jsonSerialization['timelogin']),
      permissionType: serializationManager
          .deserialize<_i2.PermissionType>(jsonSerialization['permissionType']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
    );
  }

  static final t = StaffTable();

  static const db = StaffRepository._();

  String firstName;

  String lastName;

  String phone;

  String email;

  String password;

  DateTime? timelogout;

  DateTime timelogin;

  _i2.PermissionType permissionType;

  DateTime dateCreate;

  DateTime? dateUpdate;

  @override
  _i1.Table get table => t;

  Staff copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    DateTime? timelogout,
    DateTime? timelogin,
    _i2.PermissionType? permissionType,
    DateTime? dateCreate,
    DateTime? dateUpdate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      if (timelogout != null) 'timelogout': timelogout?.toJson(),
      'timelogin': timelogin.toJson(),
      'permissionType': permissionType.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
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
      'password': password,
      'timelogout': timelogout,
      'timelogin': timelogin,
      'permissionType': permissionType,
      'dateCreate': dateCreate,
      'dateUpdate': dateUpdate,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      if (timelogout != null) 'timelogout': timelogout?.toJson(),
      'timelogin': timelogin.toJson(),
      'permissionType': permissionType.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
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
      case 'password':
        password = value;
        return;
      case 'timelogout':
        timelogout = value;
        return;
      case 'timelogin':
        timelogin = value;
        return;
      case 'permissionType':
        permissionType = value;
        return;
      case 'dateCreate':
        dateCreate = value;
        return;
      case 'dateUpdate':
        dateUpdate = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Staff>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Staff>(
      where: where != null ? where(Staff.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<Staff?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Staff>(
      where: where != null ? where(Staff.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Staff?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Staff>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StaffTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Staff>(
      where: where(Staff.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Staff row, {
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
    Staff row, {
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
    Staff row, {
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
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Staff>(
      where: where != null ? where(Staff.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static StaffInclude include() {
    return StaffInclude._();
  }

  static StaffIncludeList includeList({
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffTable>? orderByList,
    StaffInclude? include,
  }) {
    return StaffIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Staff.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Staff.t),
      include: include,
    );
  }
}

class _Undefined {}

class _StaffImpl extends Staff {
  _StaffImpl({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    DateTime? timelogout,
    required DateTime timelogin,
    required _i2.PermissionType permissionType,
    required DateTime dateCreate,
    DateTime? dateUpdate,
  }) : super._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          password: password,
          timelogout: timelogout,
          timelogin: timelogin,
          permissionType: permissionType,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
        );

  @override
  Staff copyWith({
    Object? id = _Undefined,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    Object? timelogout = _Undefined,
    DateTime? timelogin,
    _i2.PermissionType? permissionType,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
  }) {
    return Staff(
      id: id is int? ? id : this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      timelogout: timelogout is DateTime? ? timelogout : this.timelogout,
      timelogin: timelogin ?? this.timelogin,
      permissionType: permissionType ?? this.permissionType,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
    );
  }
}

class StaffTable extends _i1.Table {
  StaffTable({super.tableRelation}) : super(tableName: 'staff') {
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
    password = _i1.ColumnString(
      'password',
      this,
    );
    timelogout = _i1.ColumnDateTime(
      'timelogout',
      this,
    );
    timelogin = _i1.ColumnDateTime(
      'timelogin',
      this,
    );
    permissionType = _i1.ColumnEnum(
      'permissionType',
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
  }

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnString password;

  late final _i1.ColumnDateTime timelogout;

  late final _i1.ColumnDateTime timelogin;

  late final _i1.ColumnEnum<_i2.PermissionType> permissionType;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateUpdate;

  @override
  List<_i1.Column> get columns => [
        id,
        firstName,
        lastName,
        phone,
        email,
        password,
        timelogout,
        timelogin,
        permissionType,
        dateCreate,
        dateUpdate,
      ];
}

@Deprecated('Use StaffTable.t instead.')
StaffTable tStaff = StaffTable();

class StaffInclude extends _i1.IncludeObject {
  StaffInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Staff.t;
}

class StaffIncludeList extends _i1.IncludeList {
  StaffIncludeList._({
    _i1.WhereExpressionBuilder<StaffTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Staff.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Staff.t;
}

class StaffRepository {
  const StaffRepository._();

  Future<List<Staff>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.find<Staff>(
      where: where?.call(Staff.t),
      orderBy: orderBy?.call(Staff.t),
      orderByList: orderByList?.call(Staff.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Staff?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? offset,
    _i1.OrderByBuilder<StaffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findFirstRow<Staff>(
      where: where?.call(Staff.t),
      orderBy: orderBy?.call(Staff.t),
      orderByList: orderByList?.call(Staff.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Staff?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findById<Staff>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Staff>> insert(
    _i1.Session session,
    List<Staff> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Staff>(
      rows,
      transaction: transaction,
    );
  }

  Future<Staff> insertRow(
    _i1.Session session,
    Staff row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Staff>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Staff>> update(
    _i1.Session session,
    List<Staff> rows, {
    _i1.ColumnSelections<StaffTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Staff>(
      rows,
      columns: columns?.call(Staff.t),
      transaction: transaction,
    );
  }

  Future<Staff> updateRow(
    _i1.Session session,
    Staff row, {
    _i1.ColumnSelections<StaffTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Staff>(
      row,
      columns: columns?.call(Staff.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Staff> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Staff>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Staff row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Staff>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StaffTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Staff>(
      where: where(Staff.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Staff>(
      where: where?.call(Staff.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
