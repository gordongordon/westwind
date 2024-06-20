import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';

class RoomGuestListWidget extends StatefulWidget {
  const RoomGuestListWidget({super.key});

  @override
  State<RoomGuestListWidget> createState() => _roomGuestListWidgetState();
}

class _roomGuestListWidgetState extends State<RoomGuestListWidget> {
  final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];
  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();

    context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());

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
          title: 'Stay Date',
          field: 'stayDate',
          type: PlutoColumnType.date(startDate: DateTime.now(), format:  'yyyy-MM-dd'),
          width: 100,
        ),
        PlutoColumn(
          title: 'Guest Id',
          field: 'guestId',
          type: PlutoColumnType.number(negative: false,),
          width: 80,
        ),
        PlutoColumn(
          title: 'Rate Type',
          field: 'rateType',
          type: PlutoColumnType.select(_rateTypeOptions),
          width: 120,
        ),
        PlutoColumn(
          title: 'Rate Reason',
          field: 'rateReason',
          type: PlutoColumnType.select(_rateReasonOptions),
          width: 120,
        ),
        PlutoColumn(
          title: 'Rate',
          field: 'rate',
          type: PlutoColumnType.number(negative: false, format: "#.##", applyFormatOnInit: true),
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
            }
        ),
        PlutoColumn(
          title: 'Res Id',
          field: 'reservationId',
          type: PlutoColumnType.number(),
          width: 120,
        ),
        PlutoColumn(
          title: 'check Out',
          field: 'checkOut',
          type: PlutoColumnType.date(),
          width: 100,
        ),
        PlutoColumn(
          title: 'Update At',
          field: 'updateAt',
          type: PlutoColumnType.date(),
          width: 100,
        ),
        PlutoColumn(
          title: 'First Name',
          field: 'firstName',
          type: PlutoColumnType.text(),
          width: 120,
        ),
        PlutoColumn(
          title: 'Last Name',
          field: 'lastName',
          type: PlutoColumnType.text(),
          width: 120,
        ),
        PlutoColumn(
          title: 'Rig number',
          field: 'rigNumber',
          type: PlutoColumnType.number(),
          width: 120,
        ),
        PlutoColumn(
          title: 'Company Name',
          field: 'companyName',
          type: PlutoColumnType.text(),
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
    return BlocBuilder<RoomGuestListBloc, RoomGuestListState>(
      builder: (context, state) {
        debugPrint("building RoomGuest List");
        switch (state) {
          case RoomGuestListStateInitial():
            return const SizedBox.shrink();
          case RoomGuestListStateLoading():
            return const Loader();
          case RoomGuestListStateLoaded():
            final roomGuests = state.roomGuests;
            final roomGuestSelected = roomGuests;

            return Column(
              children: [
                Expanded(child: buildDataTable(context, roomGuests)),
                buildSubmit(context, roomGuestSelected),
                buildCancelReseration(context, roomGuestSelected),
                //    buildSubmit(context, RoomGuestSelected, ref),
              ],
            );
          case RoomGuestListStateFailure():
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
    List<RoomGuest> roomGuests,
    // List<roomGuest> roomGuestSelected,
  ) {
    final List<PlutoRow> rows = roomGuests.map((roomGuest) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: roomGuest.id!),
          'roomId': PlutoCell(value: roomGuest.roomId),
          'stayDate': PlutoCell(value: roomGuest.stayDate),
          'guestId': PlutoCell(value: roomGuest.guestId),
          'rateType': PlutoCell(value: roomGuest.rateType.toString()),
          'rateReason': PlutoCell(value: roomGuest.rateReason.toString()),
          'rate': PlutoCell(value: roomGuest.rate),
          'reservationId': PlutoCell(value: roomGuest.reservationId),
          'checkOut': PlutoCell(value: roomGuest.checkOutDate),
          'updateAt': PlutoCell(value: roomGuest.updateDate),
          'firstName': PlutoCell(value: roomGuest.guest!.firstName),
          'lastName': PlutoCell(value: roomGuest.guest!.lastName),
          'rigNumber': PlutoCell(value: roomGuest.guest!.rigNumber),
          'companyName': PlutoCell(value: roomGuest.guest!.company!.name),
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
          context.push(RoomGuestEditPage.route(field!.value));
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
              } else if (column.field == 'firstName') {
                return resolver<PlutoFilterTypeGreaterThan>()
                    as PlutoFilterType;
              } else if (column.field == 'createAt') {
                return resolver<PlutoFilterTypeLessThan>() as PlutoFilterType;
              } else if (column.field == 'rateType') {
                return resolver<ClassYouImplemented>() as PlutoFilterType;
              }

              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            },
          ),
        ));
  }

  Widget buildSubmit(
    BuildContext context,
    List<RoomGuest> roomGuestSelected,
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
          child: Text('Select ${roomGuestSelected.length} to Check In'),
          onPressed: () {
            //    final id = roomGuestSelected.map((roomGuest) => roomGuest.id).join(', ');

// context.read<roomGuestListBloc>().add( SelectroomGuestEvent( roomGuest: roomGuestSelected.first ) );

            roomGuestSelected.forEach((element) {
              //  ref.read(roomGuestProvider(0).notifier).checkIn(element, element.id!);
              // context.read<roomGuestListBloc>().add( roomGuestListStateSelected(roomGuests));
            });

            //  Utils.showSnackBar(context, 'Selected roomGuest: $id ');
          },
        ),
      );
  Widget buildCancelReseration(
    BuildContext context,
    List<RoomGuest> roomGuestSelected,
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
          child: Text('Select ${roomGuestSelected.length} to Cancel'),
          onPressed: () {
            //          final id = roomGuestSelected.map((roomGuest) => roomGuest.id).join(', ');

            roomGuestSelected.forEach((element) {
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
