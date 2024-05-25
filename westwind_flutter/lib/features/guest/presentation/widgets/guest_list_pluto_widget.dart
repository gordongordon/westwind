import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_state.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';

class GuestListPlutoWidget extends StatefulWidget {
  const GuestListPlutoWidget({super.key});

  @override
  State<GuestListPlutoWidget> createState() => _GuestListPlutoWidgetState();
}

class _GuestListPlutoWidgetState extends State<GuestListPlutoWidget> {
  // final List<String> _rateTypeOptions =
  //     RateType.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();

    context.read<GuestListBloc>().add(FetchGuestsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  late final PlutoGridStateManager stateManager;

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

  // final List<String> _rateTypeOptions =
  //   RateType.values.map((e) => e.name).toList();

  Widget buildDataTable(
    BuildContext context,
    List<Guest> guests,
    List<Guest> guestSelected,
  ) {
//! Column
    final List<PlutoColumn> columns = <PlutoColumn>[
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
        width:  60,

     
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
        title: 'Phone',
        field: 'phone',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Email',
        field: 'email',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Is in house',
        field: 'isInHouse',
        type: PlutoColumnType.select(<bool>[true, false]),
             width: 120,
      ),
      PlutoColumn(
        title: 'Rate Type',
        field: 'rateType',
        type: PlutoColumnType.select(<String>[
          'Programmer',
          'Designer',
          'Owner',
        ]),
        width: 120,
      ),
      PlutoColumn(
        title: 'Create At',
        field: 'createAt',
        type: PlutoColumnType.date(),
             width: 120,
      ),
      PlutoColumn(
        title: 'Update At',
        field: 'updateAt',
        type: PlutoColumnType.date(),
             width: 120,
      ),
      PlutoColumn(
        title: 'Stuff Id',
        field: 'stuffId',
        type: PlutoColumnType.number(),
             width: 120,
      ),
      PlutoColumn(
        title: 'Company Id',
        field: 'companyId',
        type: PlutoColumnType.number(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Rig #',
        field: 'rigNumber',
        type: PlutoColumnType.number(),
           width: 120,
      ),
      /*
    PlutoColumn(
      title: 'salary',
      field: 'salary',
      type: PlutoColumnType.currency(),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          formatAsCurrency: true,
          type: PlutoAggregateColumnType.sum,
          format: '#,###',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Sum',
                style: TextStyle(color: Colors.red),
              ),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    ), */
    ];

    List<PlutoRow> rows = guests.map((guest) {
      return PlutoRow(
        cells: {
          /*
          'id': PlutoCell(value: 1),
          'firstName': PlutoCell(value: 'gordon'),
          'lastName': PlutoCell(value: 'wong'),
          'phone': PlutoCell(value: '17805420047'),
          'email': PlutoCell(value: '3225297@gmail.com'),
          'isInHouse': PlutoCell(value: 'false'),
          'rateType': PlutoCell(value: 'Programmer'),
          'createAt': PlutoCell(value: '2020-08-06'),
          'updateAt': PlutoCell(value: '2020-08-06'),
          'stuffId': PlutoCell(value: 1),
          'companyId': PlutoCell(value: 1),
          'rigNumber': PlutoCell(value: 1),
          */

          'id': PlutoCell(value: guest.id!),
          'firstName': PlutoCell(value: guest.firstName),
          'lastName': PlutoCell(value: guest.lastName),
          'phone': PlutoCell(value: guest.phone),
          'email': PlutoCell(value: guest.email),
          'isInHouse': PlutoCell(value: guest.isInHouse),
          'rateType': PlutoCell(value: guest.rateType.toString()),
          'createAt': PlutoCell(value: guest.dateCreate),
          'updateAt': PlutoCell(value: guest.dateUpdate),
          'stuffId': PlutoCell(value: guest.staffId),
          'companyId': PlutoCell(value: guest.companyId),
          'rigNumber': PlutoCell(value: guest.runtimeType),
        },
      );
    }).toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      //     onChanged: (PlutoGridOnChangedEvent event) {
      //    print(event);
      //     },
      onLoaded: (PlutoGridOnLoadedEvent event) =>
          stateManager = event.stateManager,
      onRowDoubleTap: (event) {
    //    if (event.rowIdx == null) {
     //     showSnackbar(context, 'Row Index cannot be found!');
      //  }
        debugPrint('onSelected');
        context.push(GuestEditPage.route(guests[event.rowIdx].id!));
      },
    );
  }

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
