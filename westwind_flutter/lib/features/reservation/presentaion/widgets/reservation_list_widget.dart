import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/widgets/Utils.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';

class ReservationListWidgets extends StatefulWidget {
  const ReservationListWidgets({super.key});

  @override
  State<ReservationListWidgets> createState() => _ReservationListWidgetsState();
}

class _ReservationListWidgetsState extends State<ReservationListWidgets> {
  @override
  void initState() {
    super.initState();

    context.read<ReservationListBloc>().add(FetchReservationsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationListBloc, ReservationListState>(
      builder: (context, state) {
        debugPrint("building SB");
        switch (state) {
          case ReservationListStateInitial():
            return const SizedBox.shrink();
          case ReservationListStateLoading():
            return const Loader();
          case ReservationListStateLoaded():
            final Reservations = state.reservations;
            final ReservationSelected = Reservations;
            return Column(
              children: [
                Expanded(
                    child: buildDataTable(
                        context, Reservations, ReservationSelected)),
                buildSubmit(context, ReservationSelected),
                buildCancelReseration(context, ReservationSelected),
                //    buildSubmit(context, ReservationSelected, ref),
              ],
            );
          case ReservationListStateFailure():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }

  Widget buildDataTable(
    BuildContext context,
    List<Reservation> Reservations,
    List<Reservation> ReservationSelected,
  ) {
    //  final Reservations = ref.watch(ReservationProvider(0));
    // final ReservationSelected = ref.watch(ReservationSelectedProvider);

    final columns = [
      'Reservation Id',
      'Check In Date',
      'Check out Date',
      'note',
      'Date Create',
      'Date Update',
      'Reservation Id',
      'Rate Type',
      'Rate Reason',
      'Rate',
      'is Check In',
      'is Canceled',
      'is Night Shift',
      'Room Id',
      'First Name',
      'Last Name',
    ];

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith(
        (states) {
          return Colors.blueGrey;
        },
      ),
      columnSpacing: 20,
      //  onSelectAll: (isSelectedAll) {
      //    Utils.showSnackBar(context, 'All Selected');
      //   },

      columns: getColumns(columns),
      rows: getRows(context, Reservations, ReservationSelected),
      //         rows: getRows(context, ref),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(
    BuildContext context,
    List<Reservation> reservations,
    List<Reservation> reservationSelected,
  ) =>
      reservations.map((Reservation reservation) {
        final cells = [
          reservation.id,
          reservation.checkInDate
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          reservation.checkOutDate
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          reservation.note.toString(),
          reservation.dateCreate
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          reservation.dateUpdate
              ?.getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          reservation.guestId,
          reservation.rateType.toString(),
          reservation.rateReason.toString(),
          reservation.rate,
          reservation.isCheckedIn.toString(),
          reservation.isCanceled.toString(),
          reservation.isNightShift.toString(),
          reservation.roomId,
          reservation.guest?.firstName,
          reservation.guest?.lastName,
        ];

        return DataRow(
          // selected: true,
          // selected: ReservationSelected.contains(Reservation),
          onSelectChanged: (isSelected) {
            context.push(ReservationEditPage.route(reservation.id));
            //     Utils.showSnackBar(context, 'All Selected');
          },
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              Text('$cell'),
            );
          }),
        );
      }).toList();

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
