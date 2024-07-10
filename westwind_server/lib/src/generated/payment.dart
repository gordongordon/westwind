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

abstract class Payment extends _i1.TableRow
    implements _i1.ProtocolSerialization {
  Payment._({
    int? id,
    required this.guestId,
    this.guest,
    required this.chargeDate,
    required this.dateVoid,
    required this.amount,
    required this.description,
    required this.paymentType,
    required this.userId,
  }) : super(id);

  factory Payment({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime chargeDate,
    required DateTime dateVoid,
    required double amount,
    required String description,
    required _i2.PaymentType paymentType,
    required int userId,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      chargeDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['chargeDate']),
      dateVoid:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateVoid']),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      description: jsonSerialization['description'] as String,
      paymentType: _i2.PaymentType.fromJson(
          (jsonSerialization['paymentType'] as String)),
      userId: jsonSerialization['userId'] as int,
    );
  }

  static final t = PaymentTable();

  static const db = PaymentRepository._();

  int guestId;

  _i2.Guest? guest;

  DateTime chargeDate;

  DateTime dateVoid;

  double amount;

  String description;

  _i2.PaymentType paymentType;

  int userId;

  @override
  _i1.Table get table => t;

  Payment copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    DateTime? chargeDate,
    DateTime? dateVoid,
    double? amount,
    String? description,
    _i2.PaymentType? paymentType,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'chargeDate': chargeDate.toJson(),
      'dateVoid': dateVoid.toJson(),
      'amount': amount,
      'description': description,
      'paymentType': paymentType.toJson(),
      'userId': userId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
      'chargeDate': chargeDate.toJson(),
      'dateVoid': dateVoid.toJson(),
      'amount': amount,
      'description': description,
      'paymentType': paymentType.toJson(),
      'userId': userId,
    };
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime chargeDate,
    required DateTime dateVoid,
    required double amount,
    required String description,
    required _i2.PaymentType paymentType,
    required int userId,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          chargeDate: chargeDate,
          dateVoid: dateVoid,
          amount: amount,
          description: description,
          paymentType: paymentType,
          userId: userId,
        );

  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    DateTime? chargeDate,
    DateTime? dateVoid,
    double? amount,
    String? description,
    _i2.PaymentType? paymentType,
    int? userId,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      chargeDate: chargeDate ?? this.chargeDate,
      dateVoid: dateVoid ?? this.dateVoid,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      paymentType: paymentType ?? this.paymentType,
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
    chargeDate = _i1.ColumnDateTime(
      'chargeDate',
      this,
    );
    dateVoid = _i1.ColumnDateTime(
      'dateVoid',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    paymentType = _i1.ColumnEnum(
      'paymentType',
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

  late final _i1.ColumnDateTime chargeDate;

  late final _i1.ColumnDateTime dateVoid;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString description;

  late final _i1.ColumnEnum<_i2.PaymentType> paymentType;

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
        chargeDate,
        dateVoid,
        amount,
        description,
        paymentType,
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
    return session.db.find<Payment>(
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
    return session.db.findFirstRow<Payment>(
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
    return session.db.findById<Payment>(
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
    return session.db.insert<Payment>(
      rows,
      transaction: transaction,
    );
  }

  Future<Payment> insertRow(
    _i1.Session session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Payment>(
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
    return session.db.update<Payment>(
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
    return session.db.updateRow<Payment>(
      row,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  Future<List<Payment>> delete(
    _i1.Session session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Payment>(
      rows,
      transaction: transaction,
    );
  }

  Future<Payment> deleteRow(
    _i1.Session session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Payment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Payment>(
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
    return session.db.count<Payment>(
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
    await session.db.updateRow<Payment>(
      $payment,
      columns: [Payment.t.guestId],
    );
  }
}
