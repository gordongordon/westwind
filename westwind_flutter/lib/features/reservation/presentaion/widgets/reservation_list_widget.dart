import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';

class ReservationListWidget extends StatefulWidget {
  const ReservationListWidget({super.key});

  @override
  State<ReservationListWidget> createState() => _ReservationListWidgetState();
}

class _ReservationListWidgetState extends State<ReservationListWidget> {
  final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];
  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();

    context.read<ReservationListBloc>().add(FetchReservationsEvent());

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
          title: 'Check In',
          field: 'checkIn',
          type: PlutoColumnType.date(),
          width: 100,
        ),
        PlutoColumn(
          title: 'check Out',
          field: 'checkOut',
          type: PlutoColumnType.date(),
          width: 100,
        ),
        PlutoColumn(
          title: 'Note',
          field: 'note',
          type: PlutoColumnType.text(),
          width: 60,
        ),
        PlutoColumn(
          title: 'Create At',
          field: 'createAt',
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
          title: 'Guest Id',
          field: 'guestId',
          type: PlutoColumnType.number(),
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
          type: PlutoColumnType.number(),
          width: 70,
        ),
        PlutoColumn(
          title: 'is Check In',
          field: 'isCheckIn',
          type: PlutoColumnType.select(<bool>[true, false]),
          width: 120,
          renderer: (rendererContext) {
            Color textColor = Colors.black;

            if (rendererContext.cell.value == true) {
              textColor = Colors.red;
            } else if (rendererContext.cell.value == false) {
              textColor = Colors.green;
            }

            return Icon(
              Icons.single_bed,
              color: textColor,
            );
            /*
            return Text(
              rendererContext.cell.value.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ); */
          },
        ),
        PlutoColumn(
          title: 'Is Canceled',
          field: 'isCanceled',
          type: PlutoColumnType.select(<bool>[true, false]),
          width: 120,
          renderer: (rendererContext) {
            Color textColor = Colors.black;

            if (rendererContext.cell.value == true) {
              textColor = Colors.red;
            } else if (rendererContext.cell.value == false) {
              textColor = Colors.green;
            }

            //      return Icon(
            //        Icons.single_bed,
            //        color: textColor,
            //     );

            return Text(
              rendererContext.cell.value.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        PlutoColumn(
          title: 'Is Night Shift',
          field: 'isNightShift',
          type: PlutoColumnType.select(<bool>[true, false]),
          width: 120,
          renderer: (rendererContext) {
            Color textColor = Colors.black;

            if (rendererContext.cell.value == true) {
              textColor = Colors.red;
            } else if (rendererContext.cell.value == false) {
              textColor = Colors.green;
            }

            //      return Icon(
            //        Icons.single_bed,
            //        color: textColor,
            //     );

            return Text(
              rendererContext.cell.value.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        PlutoColumn(
          title: 'Room Id',
          field: 'roomId',
          type: PlutoColumnType.number(),
          width: 120,
        ),
        PlutoColumn(
          title: 'First Name',
          field: 'firstName',
          type: PlutoColumnType.text(),
          width: 100,
          titleSpan: const TextSpan(
            text: 'First Name',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            ),


          renderer: (rendererContext) {
            Color textColor = Colors.black;

            return Text(
              rendererContext.cell.value.toString(),
              style: TextStyle(
                color: textColor,
             //   fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          },
        ),
        PlutoColumn(
          title: 'Last Name',
          field: 'lastName',
          type: PlutoColumnType.text(),
          width: 100,
                  titleSpan: const TextSpan(
            text: 'Last Name',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            ),
            renderer: (rendererContext) {
            Color textColor = Colors.black;

            return Text(
              rendererContext.cell.value.toString(),
              style: TextStyle(
                color: textColor,
             //   fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          },
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
    return BlocBuilder<ReservationListBloc, ReservationListState>(
      builder: (context, state) {
        // debugPrint("building SB");
        switch (state) {
          case ReservationListStateInitial():
            return const SizedBox.shrink();
          case ReservationListStateLoading():
            return const Loader();
          case ReservationListStateLoaded():
            final reservations = state.reservations;
            final reservationSelected = reservations;
            return Column(
              children: [
                Expanded(child: buildDataTable(context, reservations)),
                buildSubmit(context, reservationSelected),
                buildCancelReseration(context, reservationSelected),
                //    buildSubmit(context, ReservationSelected, ref),
              ],
            );
          case ReservationListStateFailure():
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
    List<Reservation> reservations,
    // List<reservation> reservationSelected,
  ) {
    final List<PlutoRow> rows = reservations.map((reservation) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: reservation.id!),
          'checkIn': PlutoCell(value: reservation.checkInDate),
          'checkOut': PlutoCell(value: reservation.checkOutDate),
          'note': PlutoCell(value: reservation.note),
          'createAt': PlutoCell(value: reservation.dateCreate),
          'updateAt': PlutoCell(value: reservation.dateUpdate),
          'guestId': PlutoCell(value: reservation.guestId),
          'rateType': PlutoCell(value: reservation.rateType.toString()),
          'rateReason': PlutoCell(value: reservation.rateReason.toString()),
          'rate': PlutoCell(value: reservation.rate),
          'isCheckIn': PlutoCell(value: reservation.isCheckedIn),
          'isCanceled': PlutoCell(value: reservation.isCanceled),
          'isNightShift': PlutoCell(value: reservation.isNightShift),
          'roomId': PlutoCell(value: reservation.roomId),
          'firstName': PlutoCell(value: reservation.guest!.firstName),
          'lastName': PlutoCell(value: reservation.guest!.lastName),
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
          context.push(ReservationEditPage.route(field!.value));
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
    List<Reservation> reservationSelected,
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
          child: Text('Select ${reservationSelected.length} to Check In'),
          onPressed: () {
            //    final id = ReservationSelected.map((Reservation) => Reservation.id).join(', ');

// context.read<ReservationListBloc>().add( SelectReservationEvent( Reservation: ReservationSelected.first ) );

            reservationSelected.forEach((element) {
              //  ref.read(ReservationProvider(0).notifier).checkIn(element, element.id!);
              // context.read<ReservationListBloc>().add( ReservationListStateSelected(Reservations));
            });

            //  Utils.showSnackBar(context, 'Selected Reservation: $id ');
          },
        ),
      );
  Widget buildCancelReseration(
    BuildContext context,
    List<Reservation> ReservationSelected,
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
          child: Text('Select ${ReservationSelected.length} to Cancel'),
          onPressed: () {
            //          final id = ReservationSelected.map((Reservation) => Reservation.id).join(', ');

            ReservationSelected.forEach((element) {
              //       ref
              //          .read(ReservationProvider(0).notifier)
              //         .ReservationClient
              //        .cancelReservation(id: element.id!);
            });

            //  Utils.showSnackBar(context, 'Selected Reservation: $id ');
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
