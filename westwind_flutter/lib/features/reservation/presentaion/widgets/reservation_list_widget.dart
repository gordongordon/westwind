import 'package:flutter/material.dart';
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
  late final PlutoGridStateManager stateManager;

   

  @override
  void initState() {
    super.initState();
    context.read<ReservationListBloc>().add(FetchReservationsEvent());
    _initColumns();
  }

  void _initColumns() {
    columns.addAll([
      _buildIdColumn(),
      _buildNumberColumn('Room Id', 'roomId'),
      _buildNameColumn('First Name', 'firstName'),
      _buildNameColumn('Last Name', 'lastName'),
      _buildDateColumn('Check In', 'checkIn'),
      _buildDateColumn('Check Out', 'checkOut'),
      _buildBooleanColumn('Is Night Shift', 'isNightShift'),
      _buildSelectColumn('Rate Type', 'rateType', _rateTypeOptions),
      _buildSelectColumn('Rate Reason', 'rateReason', _rateReasonOptions),
      _buildNumberColumn('Rate', 'rate', width: 70),
      _buildTextColumn('Note', 'note', width: 60),
      _buildBooleanColumn('Is Check In', 'isCheckIn', icon: Icons.single_bed),
      _buildBooleanColumn('Is Canceled', 'isCanceled'),
      _buildDateColumn('Create At', 'createAt'),
      _buildDateColumn('Update At', 'updateAt'),
      _buildNumberColumn('Guest Id', 'guestId', width: 80),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationListBloc, ReservationListState>(
      builder: (context, state) {
        if (state is ReservationListStateInitial) {
          return const SizedBox.shrink();
        } else if (state is ReservationListStateLoading) {
          return const Loader();
        } else if (state is ReservationListStateLoaded) {
          return _buildDataTable(context, state.reservations);
        } else if (state is ReservationListStateFailure) {
          return Center(child: Text(state.message));
        }
        return const Placeholder();
      },
    );
  }

  Widget _buildDataTable(BuildContext context, List<Reservation> reservations) {
    final rows =
        reservations.map((reservation) => _createRow(reservation)).toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        event.stateManager.setShowColumnFilter(true);
        stateManager = event.stateManager;
      },
      onRowDoubleTap: _handleRowDoubleTap,
      configuration: PlutoGridConfiguration(
        columnFilter: _buildColumnFilterConfig(),
      ),
    );
  }

  PlutoRow _createRow(Reservation reservation) {
    
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
  }

  void _handleRowDoubleTap(PlutoGridOnRowDoubleTapEvent event) {
    final field = event.row.cells['id'];
    if (field == null) {
      showSnackbar(context, 'Cell id cannot be found!');
    } else {
      context.push(ReservationEditPage.route(field.value));
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
      width: 70,
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

  PlutoColumn _buildDateColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.date(),
      width: 100,
    );
  }

  PlutoColumn _buildTextColumn(String title, String field,
      {double width = 100}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.text(),
      width: width,
    );
  }

  PlutoColumn _buildNumberColumn(String title, String field,
      {double width = 120}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.number(),
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

  PlutoColumn _buildNameColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.text(),
      width: 100,
      titleSpan: TextSpan(
        text: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      renderer: (rendererContext) {
        return Text(
          rendererContext.cell.value.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 12),
        );
      },
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
