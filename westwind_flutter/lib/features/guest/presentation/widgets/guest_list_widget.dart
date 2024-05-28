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

class GuestListWidget extends StatefulWidget {
  const GuestListWidget({super.key});

  @override
  State<GuestListWidget> createState() => _GuestListWidgetState();
}

class _GuestListWidgetState extends State<GuestListWidget> {
  final List<PlutoColumn> columns = [];


  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();

    context.read<GuestListBloc>().add(FetchGuestsEvent());

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
                      text: 'Guests',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: ' : '),
                    TextSpan(text: text),
                  ];
                },
              );
            }),
        PlutoColumn(
          title: 'First Name',
          field: 'firstName',
          type: PlutoColumnType.text(),
          width: 120,
        renderer: (rendererContext) {
            Color textColor = Colors.black;

            return Text(
              rendererContext.cell.value.toString(),
              style: TextStyle(
                color: textColor,
            //    fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ); 
          },
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
          title: 'Rate Type',
          field: 'rateType',
          type: PlutoColumnType.select(_rateTypeOptions),
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
          footerRenderer: (rendererContext) {
            return PlutoAggregateColumnFooter(
              rendererContext: rendererContext,
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
    return BlocBuilder<GuestListBloc, GuestListState>(
      builder: (context, state) {
        debugPrint("building GuestListWidget");
        switch (state) {
          case GuestListStateInitial():
            // return const SizedBox.shrink();
          return const Placeholder();
          case GuestListStateLoading():
            return const Loader();
          case GuestListStateLoaded():
            final guests = state.guests;
            final guestSelected = guests;
            
            debugPrint("GusetListStateLoaded");
             return   buildDataTable(context, guests);
      //   return  buildSubmit(context, guestSelected);
/* 
            return Column(
            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     //       mainAxisAlignment: MainAxisAlignment,
                            mainAxisSize: MainAxisSize.min,
              children: [
       //           Padding(
        //             padding: const EdgeInsets.only(right: 20),
               //      child: Placeholder(),
      //   child :   
              buildDataTable(context, guests)

           //   Expanded(child: buildDataTable(context, guests)),
           //  child:   buildSubmit(context, guestSelected),
      //     child:      buildCancelReseration(context, guestSelected),
                //    buildSubmit(context, guestSelected, ref),
              //  ),
              ],
            );
            */
          case GuestListStateFailure():
            return Center(
              child: Text(state.message),
            );
          default:
        }
        return const SizedBox.shrink();
      },
    );
  }

  // final List<String> _rateTypeOptions =
  //   RateType.values.map((e) => e.name).toList();

  Widget buildDataTable(
    BuildContext context,
    List<Guest> guests,
  ) {
//! Column

    // List<PlutoRow> rows = guests.map((guest) {
    final List<PlutoRow> rows = guests.map((guest) {
      return PlutoRow(
        cells: {
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
          'rigNumber': PlutoCell(value: guest.rigNumber),
          //   'checkIn': PlutoCell(value: 'Yes'),
          //  'salary' : PlutoCell(value: 100),
        },
      );
    }).toList();

    //   final List<PlutoColumn> columns = <PlutoColumn>[

    return PlutoGrid(
        columns: columns,
        rows: rows,

        //     onChanged: (PlutoGridOnChangedEvent event) {
        //    print(event);
        //     },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          //     event.stateManager.setShowColumnFilter(true);
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

          if (event.row.cells['isInHouse']!.value == false) {
            context.push(GuestEditPage.route(field!.value));
          }
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
            //      final id = guestSelected.map((guest) => guest.id).join(', ');

// context.read<GuestListBloc>().add( SelectGuestEvent( guest: guestSelected.first ) );

        //    guestSelected.forEach((element) {
              //  ref.read(guestProvider(0).notifier).checkIn(element, element.id!);
              // context.read<GuestListBloc>().add( GuestListStateSelected(guests));
         //   });

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
