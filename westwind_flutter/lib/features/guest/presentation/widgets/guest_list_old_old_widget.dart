import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/widgets/Utils.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_state.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';

class GuestListWidget extends StatefulWidget {
  const GuestListWidget({super.key});

  @override
  State<GuestListWidget> createState() => _GuestListWidgetsState();
}

class _GuestListWidgetsState extends State<GuestListWidget> {
  @override
  void initState() {
    super.initState();

    context.read<GuestListBloc>().add(FetchGuestsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestListBloc, GuestListState>(
      builder: (context, state) {
        debugPrint("building SB");
        switch (state) {
          case GuestListStateInitial():
            return const SizedBox.shrink();
          case GuestListStateLoading():
            return const Loader();
          case GuestListStateLoaded():
            final guests = state.guests;
            final guestSelected = guests;
            return Column(
              children: [
                Expanded(child: buildDataTable(context, guests, guestSelected)),
                buildSubmit(context, guestSelected),
                buildCancelReseration(context, guestSelected),
                //    buildSubmit(context, guestSelected, ref),
              ],
            );
          case GuestListStateFailure():
            return Center(
              child: Text(state.message),
            );
        }
      },
    );
  }

  Widget buildDataTable(
    BuildContext context,
    List<Guest> guests,
    List<Guest> guestSelected,
  ) {
    //  final guests = ref.watch(guestProvider(0));
    // final guestSelected = ref.watch(guestSelectedProvider);

    final columns = [
      'Id',
      'First Name',
      'Last Name',
      'Phone',
      'Email',
      'is In House',
      'Create At',
      'Update At',
      'Rate Type',
      'Staff Id',
      'Company Id',
      'Rig Number',
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
      rows: getRows(context, guests, guestSelected),
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
    List<Guest> guests,
    List<Guest> guestSelected,
  ) =>
      guests.map((Guest guest) {
        final cells = [
          guest.id,
          guest.firstName,
          guest.lastName,
          guest.phone,
          guest.email,
          guest.isInHouse,
          guest.dateCreate
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          guest.dateUpdate!
              .getDateOnly()
              .toString()
              .replaceAll("00:00:00.000", ""),
          guest.rateType.toString(),
          guest.staffId,
          guest.companyId,
          guest.rigNumber,
        ];

        return DataRow(
          // selected: true,
          // selected: guestSelected.contains(guest),
          onSelectChanged: (isSelected) {
            context.push(GuestEditPage.route(guest.id));
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
    List<Guest> guestSelected,
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
          child: Text('Select ${guestSelected.length} to Check In'),
          onPressed: () {
            final id = guestSelected.map((guest) => guest.id).join(', ');

// context.read<GuestListBloc>().add( SelectGuestEvent( guest: guestSelected.first ) );

            guestSelected.forEach((element) {
              //  ref.read(guestProvider(0).notifier).checkIn(element, element.id!);
              // context.read<GuestListBloc>().add( GuestListStateSelected(guests));
            });

            //  Utils.showSnackBar(context, 'Selected guest: $id ');
          },
        ),
      );
  Widget buildCancelReseration(
    BuildContext context,
    List<Guest> guestSelected,
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
          child: Text('Select ${guestSelected.length} to Cancel'),
          onPressed: () {
            final id = guestSelected.map((guest) => guest.id).join(', ');

            guestSelected.forEach((element) {
              //       ref
              //          .read(guestProvider(0).notifier)
              //         .guestClient
              //        .cancelguest(id: element.id!);
            });

            //  Utils.showSnackBar(context, 'Selected guest: $id ');
          },
        ),
      );
}
