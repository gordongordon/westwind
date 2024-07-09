import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_edit_page.dart';

class RoomTransactionListWidget extends StatefulWidget {
  const RoomTransactionListWidget({super.key});

  @override
  State<RoomTransactionListWidget> createState() =>
      _RoomTransactionListWidgetState();
}

class _RoomTransactionListWidgetState extends State<RoomTransactionListWidget> {
  final List<PlutoColumn> columns = [];
  late final PlutoGridStateManager stateManager;

  final List<String> _transactionTypeOptions =
      TransactionType.values.map((e) => e.name).toList();
  final List<String> _itemTypeOptions =
      ItemType.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();
    context
        .read<RoomTransactionBloc>()
        .add(FetchRoomTransactionsEvent());
    _initializeColumns();
  }

  void _initializeColumns() {
    columns.addAll([
      _buildIdColumn(),
      _buildNumberColumn('Room Id', 'roomId', 120),
     _buildDateColumn('StayDay', 'stayDay'),

      _buildSelectColumn(
          'Transaction Type', 'transactionType', _transactionTypeOptions, 120),
                _buildSelectColumn('Item Type', 'itemType', _itemTypeOptions, 120),
      _buildTextColumn('Description', 'description', 120),
        _buildAmountColumn('Amount', 'amount'),
      _buildAmountColumn('GST', 'tax1'),
      _buildAmountColumn('Levy', 'tax2'),
      _buildAmountColumn('Tax3', 'tax3'),
      _buildAmountColumn('Total', 'total'),
 
      _buildDateColumn('Transaction Day', 'transactionDay'),
    

            _buildNumberColumn('RoomGuest Id', 'roomGuestId', 120),
      _buildNumberColumn('Guest Id', 'guestId', 80),    ]);
  }

  PlutoColumn _buildIdColumn() {
    return PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.number(),
      titlePadding: const EdgeInsets.all(8),
      textAlign: PlutoColumnTextAlign.start,
      enableDropToResize: true,
      readOnly: true,
      width: 50,
      footerRenderer: (rendererContext) => _buildAggregateFooter(
          rendererContext, PlutoAggregateColumnType.count),
    );
  }

  PlutoColumn _buildNumberColumn(String title, String field, double width) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.number(negative: false),
      width: width,
    );
  }

  PlutoColumn _buildSelectColumn(
      String title, String field, List<String> options, double width) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.select(options),
      width: width,
    );
  }

  PlutoColumn _buildAmountColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.number(
          negative: false, format: "#.##", applyFormatOnInit: true),
      width: 70,
      footerRenderer: (rendererContext) => _buildAggregateFooter(
          rendererContext, PlutoAggregateColumnType.sum,
          formatAsCurrency: true),
    );
  }

  PlutoColumn _buildDateColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.date(startDate: DateTime.now(), format: 'MM-dd'),
      width: 100,
    );
  }

  PlutoColumn _buildTextColumn(String title, String field, double width) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.text(),
      width: width,
    );
  }

  PlutoAggregateColumnFooter _buildAggregateFooter(
    PlutoColumnFooterRendererContext rendererContext,
    PlutoAggregateColumnType type, {
    bool formatAsCurrency = false,
  }) {
    return PlutoAggregateColumnFooter(
      rendererContext: rendererContext,
      type: type,
      format: '#',
      alignment: Alignment.center,
      formatAsCurrency: formatAsCurrency,
      titleSpanBuilder: (text) => [
        const TextSpan(text: 'sum', style: TextStyle(color: Colors.red)),
        const TextSpan(text: ' : '),
        TextSpan(text: text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomTransactionBloc, RoomTransactionState>(
      builder: (context, state) {
        debugPrint("building RoomTransaction List");
        if (state is RoomTransactionListStateInitial) {
          return const SizedBox.shrink();
        } else if (state is RoomTransactionListStateLoading) {
          return const Loader();
        } else if (state is RoomTransactionListStateLoaded) {
          return buildDataTable(context, state.roomTransactions);
        } else if (state is RoomTransactionStateFailure) {
          return Center(child: Text(state.message));
        } else {
          return const Placeholder();
        }
      },
    );
  }

  Widget buildDataTable(
      BuildContext context, List<RoomTransaction> roomTransactions) {
    final List<PlutoRow> rows = roomTransactions
        .map((roomTransaction) => _createPlutoRow(roomTransaction))
        .toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        event.stateManager.setShowColumnFilter(true);
        stateManager = event.stateManager;
      },
      onRowDoubleTap: _handleRowDoubleTap,
      configuration: PlutoGridConfiguration(
        /// If columnFilterConfig is not set, the default setting is applied.
        ///
        /// Return the value returned by resolveDefaultColumnFilter through the resolver function.
        /// Prevents errors returning filters that are not in the filters list.
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [
            ...FilterHelper.defaultFilters,
            // custom filter
            ClassYouImplemented(),
          ],
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
        ),
      ),
    );
  }

  PlutoRow _createPlutoRow(RoomTransaction roomTransaction) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: roomTransaction.id!),
        'roomId': PlutoCell(value: roomTransaction.roomId),
        'guestId': PlutoCell(value: roomTransaction.guestId),
        'roomGuestId': PlutoCell(value: roomTransaction.roomGuestId),
        'stayDay': PlutoCell(value: roomTransaction.stayDay),
        'transactionType': PlutoCell(value: roomTransaction.transactionType),
        'amount': PlutoCell(value: roomTransaction.amount),
        'tax1': PlutoCell(value: roomTransaction.tax1),
        'tax2': PlutoCell(value: roomTransaction.tax2),
        'tax3': PlutoCell(value: roomTransaction.tax3),
        'total': PlutoCell(value: roomTransaction.total),
        'transactionDay': PlutoCell(value: roomTransaction.transactionDay),
        'description': PlutoCell(value: roomTransaction.description),
        'itemType': PlutoCell(value: roomTransaction.itemType),
      },
    );
  }

  void _handleRowDoubleTap(PlutoGridOnRowDoubleTapEvent event) {
    debugPrint('onSelected');
    final field = event.row.cells['id'];

    if (field == null) {
      showSnackbar(context, 'Cell id cannot be found!');
    } else {
      context.push(RoomTransactionEditPage.route(field.value));
    }
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
