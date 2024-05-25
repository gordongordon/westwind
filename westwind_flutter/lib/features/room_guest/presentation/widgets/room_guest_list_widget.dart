import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/widgets/Utils.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_list.dart';

class RoomGuestListWidgets extends StatefulWidget {
  const RoomGuestListWidgets({super.key});

  @override
  State<RoomGuestListWidgets> createState() => _RoomGuestListWidgetsState();
}

class _RoomGuestListWidgetsState extends State<RoomGuestListWidgets> {
  @override
  void initState() {
    super.initState();

    context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomGuestListBloc, RoomGuestListState>(
      builder: (context, state) {
        debugPrint("building SB");
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
                Expanded(
                    child:
                        buildDataTable(context, roomGuests, roomGuestSelected)),
                buildSubmit(context, roomGuestSelected),
                buildCancelReseration(context, roomGuestSelected),
                //    buildSubmit(context, RoomGuestSelected, ref),
              ],
            );
          case RoomGuestListStateFailure():
            return Center(
              child: Text(state.message),
            );
                    default: return Placeholder();
        }
      },
    );
  }

  Widget buildDataTable(
    BuildContext context,
    List<RoomGuest> RoomGuests,
    List<RoomGuest> RoomGuestSelected,
  ) {
    //  final RoomGuests = ref.watch(RoomGuestProvider(0));
    // final RoomGuestSelected = ref.watch(RoomGuestSelectedProvider);

    final columns = [
      'RoomGuest Id',
      'Room Id',
      'State Date',
      'Guest Id',
      'Rate Type',
      'Rate Reason',
      'Rate',
      'Reservation Id',
      'Check Out Date',
      'Update Date',
      'First Name',
      'Last Name',
      'Rig number',
      'Company Name',
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
      rows: getRows(context, RoomGuests, RoomGuestSelected),
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
    List<RoomGuest> roomGuests,
    List<RoomGuest> roomGuestSelected,
  ) =>
      roomGuests.map((RoomGuest roomGuest) {
        final cells = [
          roomGuest.id,
          roomGuest.roomId,
          roomGuest.stateDate
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          roomGuest.guestId,
          roomGuest.rateType.toString(),
          roomGuest.rateReason.toString(),
          roomGuest.rate,
          roomGuest.reservationId,
          roomGuest.checkOutDate
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          roomGuest.updateDate.toString(),
          roomGuest.guest?.firstName,
          roomGuest.guest?.lastName,
          roomGuest.guest?.rigNumber,
          roomGuest.guest?.company?.name,
        ];

        return DataRow(
          // selected: true,
          // selected: RoomGuestSelected.contains(RoomGuest),
          onSelectChanged: (isSelected) {
              context.push(RoomGuestEditPage.route(roomGuest.id));
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
    List<RoomGuest> RoomGuestSelected,
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
          child: Text('Select ${RoomGuestSelected.length} to Check In'),
          onPressed: () {
            //    final id = RoomGuestSelected.map((RoomGuest) => RoomGuest.id).join(', ');

// context.read<RoomGuestListBloc>().add( SelectRoomGuestEvent( RoomGuest: RoomGuestSelected.first ) );

            RoomGuestSelected.forEach((element) {
              //  ref.read(RoomGuestProvider(0).notifier).checkIn(element, element.id!);
              // context.read<RoomGuestListBloc>().add( RoomGuestListStateSelected(RoomGuests));
            });

            //  Utils.showSnackBar(context, 'Selected RoomGuest: $id ');
          },
        ),
      );
  Widget buildCancelReseration(
    BuildContext context,
    List<RoomGuest> RoomGuestSelected,
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
          child: Text('Select ${RoomGuestSelected.length} to Cancel'),
          onPressed: () {
            //          final id = RoomGuestSelected.map((RoomGuest) => RoomGuest.id).join(', ');

            RoomGuestSelected.forEach((element) {
              //       ref
              //          .read(RoomGuestProvider(0).notifier)
              //         .RoomGuestClient
              //        .cancelRoomGuest(id: element.id!);
            });

            //  Utils.showSnackBar(context, 'Selected RoomGuest: $id ');
          },
        ),
      );
}
