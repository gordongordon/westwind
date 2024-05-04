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

abstract class Payment extends _i1.TableRow {
  Payment._({
    int? id,
    required this.guestId,
    this.guest,
    required this.dateCreate,
    required this.dateVoid,
    required this.paymentAmount,
    required this.paymentType,
    required this.roomChargeType,
    required this.userId,
  }) : super(id);

  factory Payment({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime dateCreate,
    required DateTime dateVoid,
    required double paymentAmount,
    required _i2.PaymentType paymentType,
    required _i2.RoomChargeType roomChargeType,
    required int userId,
  }) = _PaymentImpl;

  factory Payment.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Payment(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateVoid: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateVoid']),
      paymentAmount: serializationManager
          .deserialize<double>(jsonSerialization['paymentAmount']),
      paymentType: serializationManager
          .deserialize<_i2.PaymentType>(jsonSerialization['paymentType']),
      roomChargeType: serializationManager
          .deserialize<_i2.RoomChargeType>(jsonSerialization['roomChargeType']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
    );
  }

  static final t = PaymentTable();

  static const db = PaymentRepository._();

  int guestId;

  _i2.Guest? guest;

  DateTime dateCreate;

  DateTime dateVoid;

  double paymentAmount;

  _i2.PaymentType paymentType;

  _i2.RoomChargeType roomChargeType;

  int userId;

  @override
  _i1.Table get table => t;

  Payment copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    DateTime? dateCreate,
    DateTime? dateVoid,
    double? paymentAmount,
    _i2.PaymentType? paymentType,
    _i2.RoomChargeType? roomChargeType,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'dateCreate': dateCreate.toJson(),
      'dateVoid': dateVoid.toJson(),
      'paymentAmount': paymentAmount,
      'paymentType': paymentType.toJson(),
      'roomChargeType': roomChargeType.toJson(),
      'userId': userId,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'guestId': guestId,
      'dateCreate': dateCreate,
      'dateVoid': dateVoid,
      'paymentAmount': paymentAmount,
      'paymentType': paymentType,
      'roomChargeType': roomChargeType,
      'userId': userId,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.allToJson(),
      'dateCreate': dateCreate.toJson(),
      'dateVoid': dateVoid.toJson(),
      'paymentAmount': paymentAmount,
      'paymentType': paymentType.toJson(),
      'roomChargeType': roomChargeType.toJson(),
      'userId': userId,
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
      case 'guestId':
        guestId = value;
        return;
      case 'dateCreate':
        dateCreate = value;
        return;
      case 'dateVoid':
        dateVoid = value;
        return;
      case 'paymentAmount':
        paymentAmount = value;
        return;
      case 'paymentType':
        paymentType = value;
        return;
      case 'roomChargeType':
        roomChargeType = value;
        return;
      case 'userId':
        userId = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Payment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    PaymentInclude? include,
  }) async {
    return session.db.find<Payment>(
      where: where != null ? where(Payment.t) : null,
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
  static Future<Payment?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    PaymentInclude? include,
  }) async {
    return session.db.findSingleRow<Payment>(
      where: where != null ? where(Payment.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Payment?> findById(
    _i1.Session session,
    int id, {
    PaymentInclude? include,
  }) async {
    return session.db.findById<Payment>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Payment>(
      where: where(Payment.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Payment row, {
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
    Payment row, {
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
    Payment row, {
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
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Payment>(
      where: where != null ? where(Payment.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static PaymentInclude include({_i2.GuestInclude? guest}) {
    return PaymentInclude._(guest: guest);
  }

  static PaymentIncludeList includeList({
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    PaymentInclude? include,
  }) {
    return PaymentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Payment.t),
      include: include,
    );
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime dateCreate,
    required DateTime dateVoid,
    required double paymentAmount,
    required _i2.PaymentType paymentType,
    required _i2.RoomChargeType roomChargeType,
    required int userId,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          dateCreate: dateCreate,
          dateVoid: dateVoid,
          paymentAmount: paymentAmount,
          paymentType: paymentType,
          roomChargeType: roomChargeType,
          userId: userId,
        );

  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    DateTime? dateCreate,
    DateTime? dateVoid,
    double? paymentAmount,
    _i2.PaymentType? paymentType,
    _i2.RoomChargeType? roomChargeType,
    int? userId,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      dateCreate: dateCreate ?? this.dateCreate,
      dateVoid: dateVoid ?? this.dateVoid,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentType: paymentType ?? this.paymentType,
      roomChargeType: roomChargeType ?? this.roomChargeType,
      userId: userId ?? this.userId,
    );
  }
}

class PaymentTable extends _i1.Table {
  PaymentTable({super.tableRelation}) : super(tableName: 'payment') {
    guestId = _i1.ColumnInt(
      'guestId',
      this,
    );
    dateCreate = _i1.ColumnDateTime(
      'dateCreate',
      this,
    );
    dateVoid = _i1.ColumnDateTime(
      'dateVoid',
      this,
    );
    paymentAmount = _i1.ColumnDouble(
      'paymentAmount',
      this,
    );
    paymentType = _i1.ColumnEnum(
      'paymentType',
      this,
      _i1.EnumSerialization.byName,
    );
    roomChargeType = _i1.ColumnEnum(
      'roomChargeType',
      this,
      _i1.EnumSerialization.byName,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
  }

  late final _i1.ColumnInt guestId;

  _i2.GuestTable? _guest;

  late final _i1.ColumnDateTime dateCreate;

  late final _i1.ColumnDateTime dateVoid;

  late final _i1.ColumnDouble paymentAmount;

  late final _i1.ColumnEnum<_i2.PaymentType> paymentType;

  late final _i1.ColumnEnum<_i2.RoomChargeType> roomChargeType;

  late final _i1.ColumnInt userId;

  _i2.GuestTable get guest {
    if (_guest != null) return _guest!;
    _guest = _i1.createRelationTable(
      relationFieldName: 'guest',
      field: Payment.t.guestId,
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
        guestId,
        dateCreate,
        dateVoid,
        paymentAmount,
        paymentType,
        roomChargeType,
        userId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'guest') {
      return guest;
    }
    return null;
  }
}

@Deprecated('Use PaymentTable.t instead.')
PaymentTable tPayment = PaymentTable();

class PaymentInclude extends _i1.IncludeObject {
  PaymentInclude._({_i2.GuestInclude? guest}) {
    _guest = guest;
  }

  _i2.GuestInclude? _guest;

  @override
  Map<String, _i1.Include?> get includes => {'guest': _guest};

  @override
  _i1.Table get table => Payment.t;
}

class PaymentIncludeList extends _i1.IncludeList {
  PaymentIncludeList._({
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Payment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Payment.t;
}

class PaymentRepository {
  const PaymentRepository._();

  final attachRow = const PaymentAttachRowRepository._();

  Future<List<Payment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    _i1.Transaction? transaction,
    PaymentInclude? include,
  }) async {
    return session.dbNext.find<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Payment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    _i1.Transaction? transaction,
    PaymentInclude? include,
  }) async {
    return session.dbNext.findFirstRow<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Payment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PaymentInclude? include,
  }) async {
    return session.dbNext.findById<Payment>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Payment>> insert(
    _i1.Session session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Payment>(
      rows,
      transaction: transaction,
    );
  }

  Future<Payment> insertRow(
    _i1.Session session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Payment>> update(
    _i1.Session session,
    List<Payment> rows, {
    _i1.ColumnSelections<PaymentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Payment>(
      rows,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  Future<Payment> updateRow(
    _i1.Session session,
    Payment row, {
    _i1.ColumnSelections<PaymentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Payment>(
      row,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Payment>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Payment>(
      where: where(Payment.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Payment>(
      where: where?.call(Payment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PaymentAttachRowRepository {
  const PaymentAttachRowRepository._();

  Future<void> guest(
    _i1.Session session,
    Payment payment,
    _i2.Guest guest,
  ) async {
    if (payment.id == null) {
      throw ArgumentError.notNull('payment.id');
    }
    if (guest.id == null) {
      throw ArgumentError.notNull('guest.id');
    }

    var $payment = payment.copyWith(guestId: guest.id);
    await session.dbNext.updateRow<Payment>(
      $payment,
      columns: [Payment.t.guestId],
    );
  }
}
