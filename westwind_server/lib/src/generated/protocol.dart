/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/module.dart' as _i3;
import 'company.dart' as _i4;
import 'errorType.dart' as _i5;
import 'example.dart' as _i6;
import 'guest.dart' as _i7;
import 'guestInOutDate.dart' as _i8;
import 'guestTransaction.dart' as _i9;
import 'inOutReason.dart' as _i10;
import 'myexception.dart' as _i11;
import 'payment.dart' as _i12;
import 'paymentType.dart' as _i13;
import 'permissionType.dart' as _i14;
import 'rateReason.dart' as _i15;
import 'rateTable.dart' as _i16;
import 'rateType.dart' as _i17;
import 'reservation.dart' as _i18;
import 'room.dart' as _i19;
import 'roomChargeType.dart' as _i20;
import 'roomGuest.dart' as _i21;
import 'roomInOutDate.dart' as _i22;
import 'roomNumber.dart' as _i23;
import 'roomStatus.dart' as _i24;
import 'roomTransaction.dart' as _i25;
import 'staff.dart' as _i26;
import 'transactionType.dart' as _i27;
import 'protocol.dart' as _i28;
import 'package:westwind_server/src/generated/guest.dart' as _i29;
import 'package:westwind_server/src/generated/rateTable.dart' as _i30;
import 'package:westwind_server/src/generated/reservation.dart' as _i31;
import 'package:westwind_server/src/generated/roomGuest.dart' as _i32;
import 'package:westwind_server/src/generated/roomTransaction.dart' as _i33;
export 'company.dart';
export 'errorType.dart';
export 'example.dart';
export 'guest.dart';
export 'guestInOutDate.dart';
export 'guestTransaction.dart';
export 'inOutReason.dart';
export 'myexception.dart';
export 'payment.dart';
export 'paymentType.dart';
export 'permissionType.dart';
export 'rateReason.dart';
export 'rateTable.dart';
export 'rateType.dart';
export 'reservation.dart';
export 'room.dart';
export 'roomChargeType.dart';
export 'roomGuest.dart';
export 'roomInOutDate.dart';
export 'roomNumber.dart';
export 'roomStatus.dart';
export 'roomTransaction.dart';
export 'staff.dart';
export 'transactionType.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'company',
      dartName: 'Company',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'company_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'contactName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'dateCreate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dateUpdate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'byStaffId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'company_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'company_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'phone',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'guest',
      dartName: 'Guest',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'guest_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'firstName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isInHouse',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'dateCreate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dateUpdate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'rateType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateType',
        ),
        _i2.ColumnDefinition(
          name: 'staffId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rigNumber',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'accountBalance',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'guest_fk_0',
          columns: ['companyId'],
          referenceTable: 'company',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'guest_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'guest_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'phone',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'guest_in_out_date',
      dartName: 'GuestInOutDate',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'guest_in_out_date_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomNumber',
        ),
        _i2.ColumnDefinition(
          name: 'dateCreate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dateUpdate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'inOutReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InOutReason',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'guest_in_out_date_fk_0',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'guest_in_out_date_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'guest_transaction',
      dartName: 'GuestTransaction',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'guest_transaction_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'stateDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'rateType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateType',
        ),
        _i2.ColumnDefinition(
          name: 'rateReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateReason',
        ),
        _i2.ColumnDefinition(
          name: 'rate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'roomStatus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomStatus',
        ),
        _i2.ColumnDefinition(
          name: 'updateDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'roomGuestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'guest_transaction_fk_0',
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'guest_transaction_fk_1',
          columns: ['roomGuestId'],
          referenceTable: 'room_guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'guest_transaction_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'payment',
      dartName: 'Payment',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'payment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'chargeDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dateVoid',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'paymentType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PaymentType',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'payment_fk_0',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'payment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'rate_table',
      dartName: 'RateTable',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'rate_table_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'rateType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateType',
        ),
        _i2.ColumnDefinition(
          name: 'rateReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateReason',
        ),
        _i2.ColumnDefinition(
          name: 'rate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'rate_table_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'rate_table_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'rateType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'rateReason',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reservation',
      dartName: 'Reservation',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reservation_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'checkInDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'checkOutDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'dateCreate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dateUpdate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rateType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateType',
        ),
        _i2.ColumnDefinition(
          name: 'rateReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateReason',
        ),
        _i2.ColumnDefinition(
          name: 'rate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'isCheckedIn',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isCanceled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isNightShift',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: '_roomReservationsRoomId',
          columnType: _i2.ColumnType.integer,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reservation_fk_0',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reservation_fk_1',
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reservation_fk_2',
          columns: ['_roomReservationsRoomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reservation_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'room',
      dartName: 'Room',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomNumber',
        ),
        _i2.ColumnDefinition(
          name: 'roomType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'roomStatus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomStatus',
        ),
        _i2.ColumnDefinition(
          name: 'isAvailable',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isSmoke',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'bedType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isBigTV',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isNewAC',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isNewBed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isBigRefergrator',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'room_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'room_guest',
      dartName: 'RoomGuest',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_guest_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'stayDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rateType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateType',
        ),
        _i2.ColumnDefinition(
          name: 'rateReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RateReason',
        ),
        _i2.ColumnDefinition(
          name: 'rate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'reservationId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roomStatus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomStatus',
        ),
        _i2.ColumnDefinition(
          name: 'checkOutDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updateDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'room_guest_fk_0',
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'room_guest_fk_1',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'room_guest_fk_2',
          columns: ['reservationId'],
          referenceTable: 'reservation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'room_guest_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'room_guest_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'guestId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'room_in_out_date',
      dartName: 'RoomInOutDate',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_in_out_date_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'checkInDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'checkOutDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roomNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomNumber',
        ),
        _i2.ColumnDefinition(
          name: 'dateCreate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'room_in_out_date_fk_0',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'room_in_out_date_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'room_transaction',
      dartName: 'RoomTransaction',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_transaction_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'transactionDay',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'transactionType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionType',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'tax1',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'tax2',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'tax3',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'room_transaction_fk_0',
          columns: ['guestId'],
          referenceTable: 'guest',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'room_transaction_fk_1',
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'room_transaction_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'staff',
      dartName: 'Staff',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'staff_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'firstName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'password',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timelogout',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'timelogin',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'permissionType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PermissionType',
        ),
        _i2.ColumnDefinition(
          name: 'dateCreate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dateUpdate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'staff_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'staff_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i4.Company) {
      return _i4.Company.fromJson(data, this) as T;
    }
    if (t == _i5.ErrorType) {
      return _i5.ErrorType.fromJson(data) as T;
    }
    if (t == _i6.Examplekk) {
      return _i6.Examplekk.fromJson(data, this) as T;
    }
    if (t == _i7.Guest) {
      return _i7.Guest.fromJson(data, this) as T;
    }
    if (t == _i8.GuestInOutDate) {
      return _i8.GuestInOutDate.fromJson(data, this) as T;
    }
    if (t == _i9.GuestTransaction) {
      return _i9.GuestTransaction.fromJson(data, this) as T;
    }
    if (t == _i10.InOutReason) {
      return _i10.InOutReason.fromJson(data) as T;
    }
    if (t == _i11.MyException) {
      return _i11.MyException.fromJson(data, this) as T;
    }
    if (t == _i12.Payment) {
      return _i12.Payment.fromJson(data, this) as T;
    }
    if (t == _i13.PaymentType) {
      return _i13.PaymentType.fromJson(data) as T;
    }
    if (t == _i14.PermissionType) {
      return _i14.PermissionType.fromJson(data) as T;
    }
    if (t == _i15.RateReason) {
      return _i15.RateReason.fromJson(data) as T;
    }
    if (t == _i16.RateTable) {
      return _i16.RateTable.fromJson(data, this) as T;
    }
    if (t == _i17.RateType) {
      return _i17.RateType.fromJson(data) as T;
    }
    if (t == _i18.Reservation) {
      return _i18.Reservation.fromJson(data, this) as T;
    }
    if (t == _i19.Room) {
      return _i19.Room.fromJson(data, this) as T;
    }
    if (t == _i20.RoomChargeType) {
      return _i20.RoomChargeType.fromJson(data) as T;
    }
    if (t == _i21.RoomGuest) {
      return _i21.RoomGuest.fromJson(data, this) as T;
    }
    if (t == _i22.RoomInOutDate) {
      return _i22.RoomInOutDate.fromJson(data, this) as T;
    }
    if (t == _i23.RoomNumber) {
      return _i23.RoomNumber.fromJson(data) as T;
    }
    if (t == _i24.RoomStatus) {
      return _i24.RoomStatus.fromJson(data) as T;
    }
    if (t == _i25.RoomTransaction) {
      return _i25.RoomTransaction.fromJson(data, this) as T;
    }
    if (t == _i26.Staff) {
      return _i26.Staff.fromJson(data, this) as T;
    }
    if (t == _i27.TransactionType) {
      return _i27.TransactionType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.Company?>()) {
      return (data != null ? _i4.Company.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.ErrorType?>()) {
      return (data != null ? _i5.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Examplekk?>()) {
      return (data != null ? _i6.Examplekk.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.Guest?>()) {
      return (data != null ? _i7.Guest.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.GuestInOutDate?>()) {
      return (data != null ? _i8.GuestInOutDate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i9.GuestTransaction?>()) {
      return (data != null ? _i9.GuestTransaction.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i10.InOutReason?>()) {
      return (data != null ? _i10.InOutReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.MyException?>()) {
      return (data != null ? _i11.MyException.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i12.Payment?>()) {
      return (data != null ? _i12.Payment.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i13.PaymentType?>()) {
      return (data != null ? _i13.PaymentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PermissionType?>()) {
      return (data != null ? _i14.PermissionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.RateReason?>()) {
      return (data != null ? _i15.RateReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.RateTable?>()) {
      return (data != null ? _i16.RateTable.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i17.RateType?>()) {
      return (data != null ? _i17.RateType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Reservation?>()) {
      return (data != null ? _i18.Reservation.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i19.Room?>()) {
      return (data != null ? _i19.Room.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i20.RoomChargeType?>()) {
      return (data != null ? _i20.RoomChargeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.RoomGuest?>()) {
      return (data != null ? _i21.RoomGuest.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i22.RoomInOutDate?>()) {
      return (data != null ? _i22.RoomInOutDate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i23.RoomNumber?>()) {
      return (data != null ? _i23.RoomNumber.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RoomStatus?>()) {
      return (data != null ? _i24.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.RoomTransaction?>()) {
      return (data != null ? _i25.RoomTransaction.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i26.Staff?>()) {
      return (data != null ? _i26.Staff.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i27.TransactionType?>()) {
      return (data != null ? _i27.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i28.Reservation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i28.Reservation>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i29.Guest>) {
      return (data as List).map((e) => deserialize<_i29.Guest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i30.RateTable>) {
      return (data as List).map((e) => deserialize<_i30.RateTable>(e)).toList()
          as dynamic;
    }
    if (t == List<_i31.Reservation>) {
      return (data as List)
          .map((e) => deserialize<_i31.Reservation>(e))
          .toList() as dynamic;
    }
    if (t == List<_i32.RoomGuest>) {
      return (data as List).map((e) => deserialize<_i32.RoomGuest>(e)).toList()
          as dynamic;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == List<_i33.RoomTransaction>) {
      return (data as List)
          .map((e) => deserialize<_i33.RoomTransaction>(e))
          .toList() as dynamic;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i4.Company) {
      return 'Company';
    }
    if (data is _i5.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i6.Examplekk) {
      return 'Examplekk';
    }
    if (data is _i7.Guest) {
      return 'Guest';
    }
    if (data is _i8.GuestInOutDate) {
      return 'GuestInOutDate';
    }
    if (data is _i9.GuestTransaction) {
      return 'GuestTransaction';
    }
    if (data is _i10.InOutReason) {
      return 'InOutReason';
    }
    if (data is _i11.MyException) {
      return 'MyException';
    }
    if (data is _i12.Payment) {
      return 'Payment';
    }
    if (data is _i13.PaymentType) {
      return 'PaymentType';
    }
    if (data is _i14.PermissionType) {
      return 'PermissionType';
    }
    if (data is _i15.RateReason) {
      return 'RateReason';
    }
    if (data is _i16.RateTable) {
      return 'RateTable';
    }
    if (data is _i17.RateType) {
      return 'RateType';
    }
    if (data is _i18.Reservation) {
      return 'Reservation';
    }
    if (data is _i19.Room) {
      return 'Room';
    }
    if (data is _i20.RoomChargeType) {
      return 'RoomChargeType';
    }
    if (data is _i21.RoomGuest) {
      return 'RoomGuest';
    }
    if (data is _i22.RoomInOutDate) {
      return 'RoomInOutDate';
    }
    if (data is _i23.RoomNumber) {
      return 'RoomNumber';
    }
    if (data is _i24.RoomStatus) {
      return 'RoomStatus';
    }
    if (data is _i25.RoomTransaction) {
      return 'RoomTransaction';
    }
    if (data is _i26.Staff) {
      return 'Staff';
    }
    if (data is _i27.TransactionType) {
      return 'TransactionType';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Company') {
      return deserialize<_i4.Company>(data['data']);
    }
    if (data['className'] == 'ErrorType') {
      return deserialize<_i5.ErrorType>(data['data']);
    }
    if (data['className'] == 'Examplekk') {
      return deserialize<_i6.Examplekk>(data['data']);
    }
    if (data['className'] == 'Guest') {
      return deserialize<_i7.Guest>(data['data']);
    }
    if (data['className'] == 'GuestInOutDate') {
      return deserialize<_i8.GuestInOutDate>(data['data']);
    }
    if (data['className'] == 'GuestTransaction') {
      return deserialize<_i9.GuestTransaction>(data['data']);
    }
    if (data['className'] == 'InOutReason') {
      return deserialize<_i10.InOutReason>(data['data']);
    }
    if (data['className'] == 'MyException') {
      return deserialize<_i11.MyException>(data['data']);
    }
    if (data['className'] == 'Payment') {
      return deserialize<_i12.Payment>(data['data']);
    }
    if (data['className'] == 'PaymentType') {
      return deserialize<_i13.PaymentType>(data['data']);
    }
    if (data['className'] == 'PermissionType') {
      return deserialize<_i14.PermissionType>(data['data']);
    }
    if (data['className'] == 'RateReason') {
      return deserialize<_i15.RateReason>(data['data']);
    }
    if (data['className'] == 'RateTable') {
      return deserialize<_i16.RateTable>(data['data']);
    }
    if (data['className'] == 'RateType') {
      return deserialize<_i17.RateType>(data['data']);
    }
    if (data['className'] == 'Reservation') {
      return deserialize<_i18.Reservation>(data['data']);
    }
    if (data['className'] == 'Room') {
      return deserialize<_i19.Room>(data['data']);
    }
    if (data['className'] == 'RoomChargeType') {
      return deserialize<_i20.RoomChargeType>(data['data']);
    }
    if (data['className'] == 'RoomGuest') {
      return deserialize<_i21.RoomGuest>(data['data']);
    }
    if (data['className'] == 'RoomInOutDate') {
      return deserialize<_i22.RoomInOutDate>(data['data']);
    }
    if (data['className'] == 'RoomNumber') {
      return deserialize<_i23.RoomNumber>(data['data']);
    }
    if (data['className'] == 'RoomStatus') {
      return deserialize<_i24.RoomStatus>(data['data']);
    }
    if (data['className'] == 'RoomTransaction') {
      return deserialize<_i25.RoomTransaction>(data['data']);
    }
    if (data['className'] == 'Staff') {
      return deserialize<_i26.Staff>(data['data']);
    }
    if (data['className'] == 'TransactionType') {
      return deserialize<_i27.TransactionType>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.Company:
        return _i4.Company.t;
      case _i7.Guest:
        return _i7.Guest.t;
      case _i8.GuestInOutDate:
        return _i8.GuestInOutDate.t;
      case _i9.GuestTransaction:
        return _i9.GuestTransaction.t;
      case _i12.Payment:
        return _i12.Payment.t;
      case _i16.RateTable:
        return _i16.RateTable.t;
      case _i18.Reservation:
        return _i18.Reservation.t;
      case _i19.Room:
        return _i19.Room.t;
      case _i21.RoomGuest:
        return _i21.RoomGuest.t;
      case _i22.RoomInOutDate:
        return _i22.RoomInOutDate.t;
      case _i25.RoomTransaction:
        return _i25.RoomTransaction.t;
      case _i26.Staff:
        return _i26.Staff.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'westwind';
}
