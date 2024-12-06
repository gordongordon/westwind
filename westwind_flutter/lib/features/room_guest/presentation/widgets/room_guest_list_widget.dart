import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_guest_transactions_manage_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_create_page.dart';

class RoomGuestListWidget extends StatefulWidget {
  const RoomGuestListWidget({super.key});

  @override
  State<RoomGuestListWidget> createState() => _RoomGuestListWidgetState();
}

class _RoomGuestListWidgetState extends State<RoomGuestListWidget> {
  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];
  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();
  late final PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
    context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
    _initColumns();
  }

  void _initColumns() {
    columns.addAll([
      _buildIdColumn(),
      _buildNumberColumn('Room Id', 'roomId'),
      _buildNameColumn('First', 'firstName'),
      _buildNameColumn('Last', 'lastName'),
      _buildDateColumn('Stay Day', 'stayDay'),
      _buildDateColumn('C/I', 'checkIn', width: 80),
      _buildDateColumn('C/O', 'checkOut', width: 80),
      _buildSelectColumn('Rate Type', 'rateType', _rateTypeOptions),
      _buildSelectColumn('Rate Reason', 'rateReason', _rateReasonOptions),
      _buildRateColumn(),
      _buildBooleanColumn('Is C/O', 'isCheckOut'),
      _buildTextColumn('Company', 'companyName'),
      _buildBalanceColumn(),
      _buildNumberColumn('ResId', 'reservationId', width: 80),
      _buildDateColumn('Update At', 'updateAt'),
      _buildNumberColumn('Guest Id', 'guestId', width: 80),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomGuestListBloc, RoomGuestListState>(
      builder: (context, state) {
        debugPrint("building RoomGuest List");
        if (state is RoomGuestListStateInitial) {
          return const SizedBox.shrink();
        } else if (state is RoomGuestListStateLoading) {
          return const Loader();
        } else if (state is RoomGuestListStateLoaded) {
          return _buildDataTable(context, state.roomGuests);
        } else if (state is RoomGuestListStateFailure) {
          return Center(child: Text(state.message));
        }
        return const Placeholder();
      },
    );
  }


    PlutoColumn _buildBooleanColumn(String title, String field,
      {IconData? icon}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.select(<bool>[true, false]),
      width: 120,
      renderer: (rendererContext) {
        Color textColor =
            rendererContext.cell.value ? Colors.red : Colors.green;
        if (icon != null) {
          return Icon(icon, color: textColor);
        }
        return Text(
          rendererContext.cell.value.toString(),
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _buildDataTable(BuildContext context, List<RoomGuest> roomGuests) {
    final rows = roomGuests.map(_createRow).toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        event.stateManager.setShowColumnFilter(true);
        stateManager = event.stateManager;
      },
      onSelected: _handleRowSelected,
      //! Testing 
      onRowDoubleTap: _handleRowDoubleTap,
     // onRowDoubleTap: _handleRowDoubleTapRoomGuestTransactioin,

      configuration: PlutoGridConfiguration(
        columnFilter: _buildColumnFilterConfig(),
      ),
    );
  }



  PlutoRow _createRow(RoomGuest roomGuest) {
    // Compute Balance
    final List<RoomTransaction>? transactions = roomGuest.roomTransactions;
    double totalSum = 0;

    if (transactions != null) {
      for (RoomTransaction transaction in transactions) {
        totalSum += transaction.total;
      }
    }

    return PlutoRow(
      cells: {
        'id': PlutoCell(value: roomGuest.id!),
        'roomId': PlutoCell(value: roomGuest.roomId),
        'stayDay': PlutoCell(value: roomGuest.stayDay),
        'guestId': PlutoCell(value: roomGuest.guestId),
        'rateType': PlutoCell(value: roomGuest.rateType.toString()),
        'rateReason': PlutoCell(value: roomGuest.rateReason.toString()),
        'rate': PlutoCell(value: roomGuest.rate),
        'reservationId': PlutoCell(value: roomGuest.reservationId),
        'checkIn': PlutoCell(value: roomGuest.checkInDate),
        'checkOut': PlutoCell(value: roomGuest.checkOutDate),
        'updateAt': PlutoCell(value: roomGuest.updateDate),
        'firstName': PlutoCell(value: roomGuest.guest!.firstName),
        'lastName': PlutoCell(value: roomGuest.guest!.lastName),
        'companyName': PlutoCell(value: roomGuest.guest!.company!.name),
        'balance': PlutoCell(value: totalSum),
        'isCheckOut': PlutoCell(value: roomGuest.isCheckOut),
      },
    );
  }

  void _handleRowDoubleTapRoomGuestTransactioin(PlutoGridOnRowDoubleTapEvent event) {
    final field = event.row.cells['id'];
    if (field == null) {
      showSnackbar(context, 'Cell id cannot be found!');
    } else {
      context.push(RoomGuestTransactionsManagePage.route(field.value));
    }
  }


  void _handleRowSelected(PlutoGridOnSelectedEvent event) {
    context.push(RoomTransactionCreatePage.route(1));
  }

  void _handleRowDoubleTap(PlutoGridOnRowDoubleTapEvent event) {
    final field = event.row.cells['id'];
    if (field == null) {
      showSnackbar(context, 'Cell id cannot be found!');
    } else {
      context.push(RoomGuestEditPage.route(field.value));
    }
  }

  PlutoGridColumnFilterConfig _buildColumnFilterConfig() {
    return PlutoGridColumnFilterConfig(
      filters: const [...FilterHelper.defaultFilters, ClassYouImplemented()],
      resolveDefaultColumnFilter: (column, resolver) {
        if (column.field == 'id') {
          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
        } else if (column.field == 'firstName') {
          return resolver<PlutoFilterTypeGreaterThan>() as PlutoFilterType;
        } else if (column.field == 'createAt') {
          return resolver<PlutoFilterTypeLessThan>() as PlutoFilterType;
        } else if (column.field == 'rateType') {
          return resolver<ClassYouImplemented>() as PlutoFilterType;
        }
        return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
      },
    );
  }

  // Helper methods to create columns
  PlutoColumn _buildIdColumn() {
    return PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.number(),
      width: 50,
      enableDropToResize: true,
      readOnly: true,
      titlePadding: const EdgeInsets.all(8),
      textAlign: PlutoColumnTextAlign.start,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.count,
          format: '#',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: '# of', style: TextStyle(color: Colors.red)),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    );
  }

  PlutoColumn _buildDateColumn(String title, String field,
      {double width = 100}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.date(startDate: DateTime.now(), format: 'MM-dd'),
      width: width,
    );
  }

  PlutoColumn _buildTextColumn(String title, String field,
      {double width = 80}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.text(),
      width: width,
    );
  }

  PlutoColumn _buildNumberColumn(String title, String field,
      {double width = 100}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.number(negative: false),
      width: width,
    );
  }

  PlutoColumn _buildSelectColumn(
      String title, String field, List<String> options) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.select(options),
      width: 120,
    );
  }

  PlutoColumn _buildRateColumn() {
    return PlutoColumn(
      title: 'Rate',
      field: 'rate',
      type: PlutoColumnType.number(
          negative: false, format: "#.##", applyFormatOnInit: true),
      width: 70,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          formatAsCurrency: true,
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          format: '#',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'sum', style: TextStyle(color: Colors.red)),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    );
  }

  PlutoColumn _buildBalanceColumn() {
    return PlutoColumn(
      title: 'Balance',
      field: 'balance',
      type: PlutoColumnType.number(
          negative: false, format: "#.##", applyFormatOnInit: true),
      width: 70,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          formatAsCurrency: true,
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          format: '#',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'sum', style: TextStyle(color: Colors.red)),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    );
  }

  PlutoColumn _buildCheckOutColumn() {
    return PlutoColumn(
      title: 'isCheckOut',
      field: 'isCheckOut',
      type: PlutoColumnType.select(<bool>[true, false]),
      width: 120,
      renderer: (rendererContext) {
        Color textColor =
            rendererContext.cell.value ? Colors.red : Colors.green;
        return Icon(Icons.single_bed, color: textColor);
      },
    );
  }

  PlutoColumn _buildNameColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.text(),
      width: 80,
    );
  }
}

class ClassYouImplemented implements PlutoFilterType {
  @override
  String get title => 'Custom contains';

  @override
  get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        var keys = search!.split(',').map((e) => e.toUpperCase()).toList();
        return keys.contains(base!.toUpperCase());
      };

  const ClassYouImplemented();
}
