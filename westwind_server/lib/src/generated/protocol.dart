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
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'bedType.dart' as _i4;
import 'company.dart' as _i5;
import 'errorType.dart' as _i6;
import 'example.dart' as _i7;
import 'guest.dart' as _i8;
import 'guestInOutDate.dart' as _i9;
import 'guestTransaction.dart' as _i10;
import 'inOutReason.dart' as _i11;
import 'itemType.dart' as _i12;
import 'myexception.dart' as _i13;
import 'payment.dart' as _i14;
import 'paymentType.dart' as _i15;
import 'permissionType.dart' as _i16;
import 'rateReason.dart' as _i17;
import 'rateTable.dart' as _i18;
import 'rateType.dart' as _i19;
import 'reservation.dart' as _i20;
import 'room.dart' as _i21;
import 'roomChargeType.dart' as _i22;
import 'roomGuest.dart' as _i23;
import 'roomInOutDate.dart' as _i24;
import 'roomNumber.dart' as _i25;
import 'roomStatus.dart' as _i26;
import 'roomTransaction.dart' as _i27;
import 'staff.dart' as _i28;
import 'transactionType.dart' as _i29;
import 'protocol.dart' as _i30;
import 'package:westwind_server/src/generated/guest.dart' as _i31;
import 'package:westwind_server/src/generated/rateTable.dart' as _i32;
import 'package:westwind_server/src/generated/reservation.dart' as _i33;
import 'package:westwind_server/src/generated/roomGuest.dart' as _i34;
import 'package:westwind_server/src/generated/roomTransaction.dart' as _i35;
export 'bedType.dart';
export 'company.dart';
export 'errorType.dart';
export 'example.dart';
export 'guest.dart';
export 'guestInOutDate.dart';
export 'guestTransaction.dart';
export 'inOutReason.dart';
export 'itemType.dart';
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          isNullable: true,
          dartType: 'String?',
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rigNumber',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
      name: 'guest_in_out_date',
      dartName: 'GuestInOutDate',
      schema: 'public',
      module: 'westwind',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'guest_transaction_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'payment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          name: 'stayDay',
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: '_roomReservationsRoomId',
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          dartType: 'protocol:BedType',
        ),
        _i2.ColumnDefinition(
          name: 'numOfBeds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
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
          name: 'numOfMicrowave',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isNewRefergrator',
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
          name: 'isBigTV',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isNewTV',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'numOfTableLamp',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isNewTableLamp',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'numOfStandLamp',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isNewStandLamp',
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_guest_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'stayDay',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          name: 'updateDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'isCheckOut',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
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
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'room_transaction_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'guestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roomGuestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'stayDay',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
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
          name: 'updateDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
          name: 'total',
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
          name: 'itemType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ItemType',
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
        _i2.ForeignKeyDefinition(
          constraintName: 'room_transaction_fk_2',
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
        ),
        _i2.IndexDefinition(
          indexName: 'room_transaction_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'guestId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'transactionDay',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
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
          columnType: _i2.ColumnType.bigint,
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
    if (t == _i4.BedType) {
      return _i4.BedType.fromJson(data) as T;
    }
    if (t == _i5.Company) {
      return _i5.Company.fromJson(data) as T;
    }
    if (t == _i6.ErrorType) {
      return _i6.ErrorType.fromJson(data) as T;
    }
    if (t == _i7.Examplekk) {
      return _i7.Examplekk.fromJson(data) as T;
    }
    if (t == _i8.Guest) {
      return _i8.Guest.fromJson(data) as T;
    }
    if (t == _i9.GuestInOutDate) {
      return _i9.GuestInOutDate.fromJson(data) as T;
    }
    if (t == _i10.GuestTransaction) {
      return _i10.GuestTransaction.fromJson(data) as T;
    }
    if (t == _i11.InOutReason) {
      return _i11.InOutReason.fromJson(data) as T;
    }
    if (t == _i12.ItemType) {
      return _i12.ItemType.fromJson(data) as T;
    }
    if (t == _i13.MyException) {
      return _i13.MyException.fromJson(data) as T;
    }
    if (t == _i14.Payment) {
      return _i14.Payment.fromJson(data) as T;
    }
    if (t == _i15.PaymentType) {
      return _i15.PaymentType.fromJson(data) as T;
    }
    if (t == _i16.PermissionType) {
      return _i16.PermissionType.fromJson(data) as T;
    }
    if (t == _i17.RateReason) {
      return _i17.RateReason.fromJson(data) as T;
    }
    if (t == _i18.RateTable) {
      return _i18.RateTable.fromJson(data) as T;
    }
    if (t == _i19.RateType) {
      return _i19.RateType.fromJson(data) as T;
    }
    if (t == _i20.Reservation) {
      return _i20.Reservation.fromJson(data) as T;
    }
    if (t == _i21.Room) {
      return _i21.Room.fromJson(data) as T;
    }
    if (t == _i22.RoomChargeType) {
      return _i22.RoomChargeType.fromJson(data) as T;
    }
    if (t == _i23.RoomGuest) {
      return _i23.RoomGuest.fromJson(data) as T;
    }
    if (t == _i24.RoomInOutDate) {
      return _i24.RoomInOutDate.fromJson(data) as T;
    }
    if (t == _i25.RoomNumber) {
      return _i25.RoomNumber.fromJson(data) as T;
    }
    if (t == _i26.RoomStatus) {
      return _i26.RoomStatus.fromJson(data) as T;
    }
    if (t == _i27.RoomTransaction) {
      return _i27.RoomTransaction.fromJson(data) as T;
    }
    if (t == _i28.Staff) {
      return _i28.Staff.fromJson(data) as T;
    }
    if (t == _i29.TransactionType) {
      return _i29.TransactionType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.BedType?>()) {
      return (data != null ? _i4.BedType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Company?>()) {
      return (data != null ? _i5.Company.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ErrorType?>()) {
      return (data != null ? _i6.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Examplekk?>()) {
      return (data != null ? _i7.Examplekk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Guest?>()) {
      return (data != null ? _i8.Guest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.GuestInOutDate?>()) {
      return (data != null ? _i9.GuestInOutDate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.GuestTransaction?>()) {
      return (data != null ? _i10.GuestTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.InOutReason?>()) {
      return (data != null ? _i11.InOutReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ItemType?>()) {
      return (data != null ? _i12.ItemType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.MyException?>()) {
      return (data != null ? _i13.MyException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Payment?>()) {
      return (data != null ? _i14.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.PaymentType?>()) {
      return (data != null ? _i15.PaymentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.PermissionType?>()) {
      return (data != null ? _i16.PermissionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RateReason?>()) {
      return (data != null ? _i17.RateReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.RateTable?>()) {
      return (data != null ? _i18.RateTable.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.RateType?>()) {
      return (data != null ? _i19.RateType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Reservation?>()) {
      return (data != null ? _i20.Reservation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Room?>()) {
      return (data != null ? _i21.Room.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RoomChargeType?>()) {
      return (data != null ? _i22.RoomChargeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.RoomGuest?>()) {
      return (data != null ? _i23.RoomGuest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RoomInOutDate?>()) {
      return (data != null ? _i24.RoomInOutDate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.RoomNumber?>()) {
      return (data != null ? _i25.RoomNumber.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.RoomStatus?>()) {
      return (data != null ? _i26.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.RoomTransaction?>()) {
      return (data != null ? _i27.RoomTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Staff?>()) {
      return (data != null ? _i28.Staff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.TransactionType?>()) {
      return (data != null ? _i29.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i30.Guest>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.Guest>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i30.RoomGuest>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.RoomGuest>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i30.Reservation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.Reservation>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i30.RoomTransaction>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.RoomTransaction>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i31.Guest>) {
      return (data as List).map((e) => deserialize<_i31.Guest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i32.RateTable>) {
      return (data as List).map((e) => deserialize<_i32.RateTable>(e)).toList()
          as dynamic;
    }
    if (t == List<_i33.Reservation>) {
      return (data as List)
          .map((e) => deserialize<_i33.Reservation>(e))
          .toList() as dynamic;
    }
    if (t == List<_i34.RoomGuest>) {
      return (data as List).map((e) => deserialize<_i34.RoomGuest>(e)).toList()
          as dynamic;
    }
    if (t == List<_i35.RoomTransaction>) {
      return (data as List)
          .map((e) => deserialize<_i35.RoomTransaction>(e))
          .toList() as dynamic;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i4.BedType) {
      return 'BedType';
    }
    if (data is _i5.Company) {
      return 'Company';
    }
    if (data is _i6.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i7.Examplekk) {
      return 'Examplekk';
    }
    if (data is _i8.Guest) {
      return 'Guest';
    }
    if (data is _i9.GuestInOutDate) {
      return 'GuestInOutDate';
    }
    if (data is _i10.GuestTransaction) {
      return 'GuestTransaction';
    }
    if (data is _i11.InOutReason) {
      return 'InOutReason';
    }
    if (data is _i12.ItemType) {
      return 'ItemType';
    }
    if (data is _i13.MyException) {
      return 'MyException';
    }
    if (data is _i14.Payment) {
      return 'Payment';
    }
    if (data is _i15.PaymentType) {
      return 'PaymentType';
    }
    if (data is _i16.PermissionType) {
      return 'PermissionType';
    }
    if (data is _i17.RateReason) {
      return 'RateReason';
    }
    if (data is _i18.RateTable) {
      return 'RateTable';
    }
    if (data is _i19.RateType) {
      return 'RateType';
    }
    if (data is _i20.Reservation) {
      return 'Reservation';
    }
    if (data is _i21.Room) {
      return 'Room';
    }
    if (data is _i22.RoomChargeType) {
      return 'RoomChargeType';
    }
    if (data is _i23.RoomGuest) {
      return 'RoomGuest';
    }
    if (data is _i24.RoomInOutDate) {
      return 'RoomInOutDate';
    }
    if (data is _i25.RoomNumber) {
      return 'RoomNumber';
    }
    if (data is _i26.RoomStatus) {
      return 'RoomStatus';
    }
    if (data is _i27.RoomTransaction) {
      return 'RoomTransaction';
    }
    if (data is _i28.Staff) {
      return 'Staff';
    }
    if (data is _i29.TransactionType) {
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
    if (data['className'] == 'BedType') {
      return deserialize<_i4.BedType>(data['data']);
    }
    if (data['className'] == 'Company') {
      return deserialize<_i5.Company>(data['data']);
    }
    if (data['className'] == 'ErrorType') {
      return deserialize<_i6.ErrorType>(data['data']);
    }
    if (data['className'] == 'Examplekk') {
      return deserialize<_i7.Examplekk>(data['data']);
    }
    if (data['className'] == 'Guest') {
      return deserialize<_i8.Guest>(data['data']);
    }
    if (data['className'] == 'GuestInOutDate') {
      return deserialize<_i9.GuestInOutDate>(data['data']);
    }
    if (data['className'] == 'GuestTransaction') {
      return deserialize<_i10.GuestTransaction>(data['data']);
    }
    if (data['className'] == 'InOutReason') {
      return deserialize<_i11.InOutReason>(data['data']);
    }
    if (data['className'] == 'ItemType') {
      return deserialize<_i12.ItemType>(data['data']);
    }
    if (data['className'] == 'MyException') {
      return deserialize<_i13.MyException>(data['data']);
    }
    if (data['className'] == 'Payment') {
      return deserialize<_i14.Payment>(data['data']);
    }
    if (data['className'] == 'PaymentType') {
      return deserialize<_i15.PaymentType>(data['data']);
    }
    if (data['className'] == 'PermissionType') {
      return deserialize<_i16.PermissionType>(data['data']);
    }
    if (data['className'] == 'RateReason') {
      return deserialize<_i17.RateReason>(data['data']);
    }
    if (data['className'] == 'RateTable') {
      return deserialize<_i18.RateTable>(data['data']);
    }
    if (data['className'] == 'RateType') {
      return deserialize<_i19.RateType>(data['data']);
    }
    if (data['className'] == 'Reservation') {
      return deserialize<_i20.Reservation>(data['data']);
    }
    if (data['className'] == 'Room') {
      return deserialize<_i21.Room>(data['data']);
    }
    if (data['className'] == 'RoomChargeType') {
      return deserialize<_i22.RoomChargeType>(data['data']);
    }
    if (data['className'] == 'RoomGuest') {
      return deserialize<_i23.RoomGuest>(data['data']);
    }
    if (data['className'] == 'RoomInOutDate') {
      return deserialize<_i24.RoomInOutDate>(data['data']);
    }
    if (data['className'] == 'RoomNumber') {
      return deserialize<_i25.RoomNumber>(data['data']);
    }
    if (data['className'] == 'RoomStatus') {
      return deserialize<_i26.RoomStatus>(data['data']);
    }
    if (data['className'] == 'RoomTransaction') {
      return deserialize<_i27.RoomTransaction>(data['data']);
    }
    if (data['className'] == 'Staff') {
      return deserialize<_i28.Staff>(data['data']);
    }
    if (data['className'] == 'TransactionType') {
      return deserialize<_i29.TransactionType>(data['data']);
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
      case _i5.Company:
        return _i5.Company.t;
      case _i8.Guest:
        return _i8.Guest.t;
      case _i9.GuestInOutDate:
        return _i9.GuestInOutDate.t;
      case _i10.GuestTransaction:
        return _i10.GuestTransaction.t;
      case _i14.Payment:
        return _i14.Payment.t;
      case _i18.RateTable:
        return _i18.RateTable.t;
      case _i20.Reservation:
        return _i20.Reservation.t;
      case _i21.Room:
        return _i21.Room.t;
      case _i23.RoomGuest:
        return _i23.RoomGuest.t;
      case _i24.RoomInOutDate:
        return _i24.RoomInOutDate.t;
      case _i27.RoomTransaction:
        return _i27.RoomTransaction.t;
      case _i28.Staff:
        return _i28.Staff.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'westwind';
}
