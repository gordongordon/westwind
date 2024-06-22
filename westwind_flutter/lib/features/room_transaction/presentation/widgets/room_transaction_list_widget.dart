import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_list_bloc.dart';

class RoomTransactionListWidget extends StatefulWidget {
  const RoomTransactionListWidget({super.key});

  @override
  State<RoomTransactionListWidget> createState() =>
      _roomTransactionListWidgetState();
}

class _roomTransactionListWidgetState extends State<RoomTransactionListWidget> {
  final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];

  final List<String> _transactionTypeOptions =
      TransactionType.values.map((e) => e.name).toList();
        final List<String> _itemTypeOptions =
     ItemType.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();

    context
        .read<RoomTransactionListBloc>()
        .add(FetchRoomTransactionsListEvent());

    //   final List<PlutoColumn> columns = <PlutoColumn>[
    columns.addAll(
      [
        PlutoColumn(
            title: 'Id',
            field: 'id',
            type: PlutoColumnType.number(),
            titlePadding: const EdgeInsets.all(8),
            textAlign: PlutoColumnTextAlign.start,
            // titleTextAlign: PlutoColumnTextAlign.end,
            //   enableRowChecked: true,

            //   frozen: PlutoColumnFrozen.start,
            // checkReadOnly: true,
            enableDropToResize: true,
            readOnly: true,
            width: 70,
            footerRenderer: (rendererContext) {
              return PlutoAggregateColumnFooter(
                rendererContext: rendererContext,
                type: PlutoAggregateColumnType.count,
                format: '#',
                alignment: Alignment.center,
                titleSpanBuilder: (text) {
                  return [
                    const TextSpan(
                      text: '# of',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: ' : '),
                    TextSpan(text: text),
                  ];
                },
              );
            }),
        PlutoColumn(
          title: 'Room Id',
          field: 'roomId',
          type: PlutoColumnType.number(),
          width: 120,
        ),
        PlutoColumn(
          title: 'Guest Id',
          field: 'guestId',
          type: PlutoColumnType.number(
            negative: false,
          ),
          width: 80,
        ),
        PlutoColumn(
          title: 'Transaction Type',
          field: 'transactionType',
          type: PlutoColumnType.select(_transactionTypeOptions),
          width: 120,
        ),
        PlutoColumn(
            title: 'Amount',
            field: 'amount',
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
                    const TextSpan(
                      text: 'sum',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: ' : '),
                    TextSpan(text: text),
                  ];
                },
              );
            }),
        PlutoColumn(
            title: 'Tax1',
            field: 'tax1',
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
                    const TextSpan(
                      text: 'sum',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: ' : '),
                    TextSpan(text: text),
                  ];
                },
              );
            }),
        PlutoColumn(
            title: 'Tax2',
            field: 'tax2',
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
                    const TextSpan(
                      text: 'sum',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: ' : '),
                    TextSpan(text: text),
                  ];
                },
              );
            }),
        PlutoColumn(
            title: 'Tax3',
            field: 'tax3',
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
                    const TextSpan(
                      text: 'sum',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: ' : '),
                    TextSpan(text: text),
                  ];
                },
              );
            }),
        PlutoColumn(
          title: 'Transaction Day',
          field: 'transactionDay',
          type: PlutoColumnType.date(),
          width: 100,
        ),
        PlutoColumn(
          title: 'Description',
          field: 'description',
          type: PlutoColumnType.text(),
          width: 120,
        ),
              PlutoColumn(
          title: 'Item Type',
          field: 'itemType',
          type: PlutoColumnType.select(_itemTypeOptions),
          width: 120,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomTransactionListBloc, RoomTransactionListState>(
      builder: (context, state) {
        debugPrint("building RoomTransaction List");
        switch (state) {
          case RoomTransactionListStateInitial():
            return const SizedBox.shrink();
          case RoomTransactionListStateLoading():
            return const Loader();
          case RoomTransactionListStateLoaded():
            final roomTransactions = state.roomTransactions;
            final roomTransactionSelected = roomTransactions;

            return Column(
              children: [
                Expanded(child: buildDataTable(context, roomTransactions)),
                buildSubmit(context, roomTransactionSelected),
                buildCancelReseration(context, roomTransactionSelected),
                //    buildSubmit(context, RoomGuestSelected, ref),
              ],
            );
          case RoomTransactionListStateFailure():
            return Center(
              child: Text(state.message),
            );
          default:
            return Placeholder();
        }
      },
    );
  }

  // final List<String> _rateTypeOptions =
  //   RateType.values.map((e) => e.name).toList();

  Widget buildDataTable(
    BuildContext context,
    List<RoomTransaction> roomTransactions,
    // List<roomGuest> roomGuestSelected,
  ) {
    final List<PlutoRow> rows = roomTransactions.map((roomTransaction) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: roomTransaction.id!),
          'roomId': PlutoCell(value: roomTransaction.roomId),
          'guestId': PlutoCell(value: roomTransaction.guestId),
          'transactionType': PlutoCell(value: roomTransaction.transactionType),
          'amount': PlutoCell(value: roomTransaction.amount),
          'tax1': PlutoCell(value: roomTransaction.tax1),
          'tax2': PlutoCell(value: roomTransaction.tax2),
          'tax3': PlutoCell(value: roomTransaction.tax3),
          'transactionDay': PlutoCell(value: roomTransaction.transactionDay),
          'description': PlutoCell(value: roomTransaction.description),
          'itemType' :  PlutoCell(value: roomTransaction.itemType),
        },
      );
    }).toList();

    return PlutoGrid(
        columns: columns,
        rows: rows,
        //     onChanged: (PlutoGridOnChangedEvent event) {
        //    print(event);
        //     },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          event.stateManager.setShowColumnFilter(true);
          stateManager = event.stateManager;
        },
        onRowDoubleTap: (event) {
          //    if (event.rowIdx == null) {
          //     showSnackbar(context, 'Row Index cannot be found!');
          //  }
          debugPrint('onSelected');
          final field = event.row.cells['id'];

          if (field == null) {
            showSnackbar(context, 'Cell id cannot be found!');
          }

          //  if (event.row.cells['isInHouse']!.value == false) {
          //! todo
          // context.push(RoomTransactionEditPage.route(field!.value));
          //   }
        },
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
              } else if (column.field == 'transactionType') {
                return resolver<ClassYouImplemented>() as PlutoFilterType;
              }

              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            },
          ),
        ));
  }

  Widget buildSubmit(
    BuildContext context,
    List<RoomTransaction> roomTransactionSelected,
  ) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        color: Colors.black,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size.fromHeight(40),
          ),
          child: Text('Select ${roomTransactionSelected.length} to Check In'),
          onPressed: () {
            //    final id = roomGuestSelected.map((roomGuest) => roomGuest.id).join(', ');

// context.read<roomGuestListBloc>().add( SelectroomGuestEvent( roomGuest: roomGuestSelected.first ) );

            roomTransactionSelected.forEach((element) {
              //  ref.read(roomGuestProvider(0).notifier).checkIn(element, element.id!);
              // context.read<roomGuestListBloc>().add( roomGuestListStateSelected(roomGuests));
            });

            //  Utils.showSnackBar(context, 'Selected roomGuest: $id ');
          },
        ),
      );
  Widget buildCancelReseration(
    BuildContext context,
    List<RoomTransaction> roomTransactionSelected,
  ) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        color: Colors.black,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(40),
          ),
          child: Text('Select ${roomTransactionSelected.length} to Cancel'),
          onPressed: () {
            //          final id = roomGuestSelected.map((roomGuest) => roomGuest.id).join(', ');

            roomTransactionSelected.forEach((element) {
              //       ref
              //          .read(roomGuestProvider(0).notifier)
              //         .roomGuestClient
              //        .cancelroomGuest(id: element.id!);
            });

            //  Utils.showSnackBar(context, 'Selected roomGuest: $id ');
          },
        ),
      );
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
