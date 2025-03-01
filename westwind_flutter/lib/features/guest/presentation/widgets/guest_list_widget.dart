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
  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
    context.read<GuestListBloc>().add(FetchGuestsEvent());
    _initializeColumns();
  }

  void _initializeColumns() {
    columns.addAll([
      _buildIdColumn(),
      _buildTextColumn('First Name', 'firstName', width: 120),
      _buildTextColumn('Last Name', 'lastName', width: 120),
      _buildTextColumn('Phone', 'phone', width: 120),
      _buildTextColumn('Email', 'email', width: 140),
      _buildIsInHouseColumn(),
      _buildRateTypeColumn(),
      _buildDateColumn('Create At', 'createAt'),
      _buildDateColumn('Update At', 'updateAt'),
      _buildNumberColumn('Stuff Id', 'stuffId'),
      _buildNumberColumn('Company Id', 'companyId'),
      _buildRigNumberColumn(),
    ]);
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
      width: 70,
      footerRenderer: (rendererContext) => PlutoAggregateColumnFooter(
        rendererContext: rendererContext,
        type: PlutoAggregateColumnType.count,
        format: '#',
        alignment: Alignment.center,
        titleSpanBuilder: (text) => [
          const TextSpan(text: 'Guests', style: TextStyle(color: Colors.red)),
          const TextSpan(text: ' : '),
          TextSpan(text: text),
        ],
      ),
    );
  }

  PlutoColumn _buildTextColumn(String title, String field, {double? width}) {
    const double defaultWidth = 80;

    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.text(),
      width: width ?? defaultWidth, // Provide a default value if width is null
    );
  }

  PlutoColumn _buildIsInHouseColumn() {
    return PlutoColumn(
      title: 'Is in house',
      field: 'isInHouse',
      type: PlutoColumnType.select(<bool>[true, false]),
      width: 120,
      renderer: (rendererContext) {
        bool isInHouse = rendererContext.cell.value ?? false;
        Color iconColor = isInHouse ? Colors.red : Colors.green;
        return Icon(Icons.single_bed, color: iconColor);
      },
    );
  }

  PlutoColumn _buildRateTypeColumn() {
    return PlutoColumn(
      title: 'Rate Type',
      field: 'rateType',
      type: PlutoColumnType.select(_rateTypeOptions),
      width: 120,
    );
  }

  PlutoColumn _buildDateColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.date(),
      width: 120,
    );
  }

  PlutoColumn _buildNumberColumn(String title, String field) {
    return PlutoColumn(
      title: title,
      field: field,
      type: PlutoColumnType.number(),
      width: 120,
    );
  }

  PlutoColumn _buildRigNumberColumn() {
    return PlutoColumn(
      title: 'Rig #',
      field: 'rigNumber',
      type: PlutoColumnType.number(),
      width: 120,
      footerRenderer: (rendererContext) => PlutoAggregateColumnFooter(
        rendererContext: rendererContext,
        type: PlutoAggregateColumnType.sum,
        format: '#,###',
        alignment: Alignment.center,
        titleSpanBuilder: (text) => [
          const TextSpan(text: 'Sum', style: TextStyle(color: Colors.red)),
          const TextSpan(text: ' : '),
          TextSpan(text: text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestListBloc, GuestListState>(
      builder: (context, state) {
        if (state is GuestListStateInitial) {
          return const Placeholder();
        } else if (state is GuestListStateLoading) {
          return const Loader();
        } else if (state is GuestListStateLoaded) {
          return _buildDataTable(context, state.guests);
        } else if (state is GuestListStateFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDataTable(BuildContext context, List<Guest> guests) {
    final List<PlutoRow> rows = guests.map(_createPlutoRow).toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        event.stateManager.setShowColumnFilter(true);
        stateManager = event.stateManager;
      },
      onRowDoubleTap: (event) => _handleRowDoubleTap(context, event),
      configuration: _getPlutoGridConfiguration(),
    );
  }

  PlutoRow _createPlutoRow(Guest guest) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: guest.id),
        'firstName': PlutoCell(value: guest.firstName),
        'lastName': PlutoCell(value: guest.lastName),
        'phone': PlutoCell(value: guest.phone),
        'email': PlutoCell(value: guest.email),
        'isInHouse': PlutoCell(value: guest.isInHouse),
        'rateType': PlutoCell(value: guest.rateType.toString() ?? ''),
        'createAt': PlutoCell(value: guest.dateCreate),
        'updateAt': PlutoCell(value: guest.dateUpdate),
        'stuffId': PlutoCell(value: guest.staffId),
        'companyId': PlutoCell(value: guest.companyId),
        'rigNumber': PlutoCell(value: guest.rigNumber),
      },
    );
  }

  void _handleRowDoubleTap(
      BuildContext context, PlutoGridOnRowDoubleTapEvent event) {
    final field = event.row.cells['id'];
    if (field == null || field.value == null) {
      showSnackbar(context, 'Cell id cannot be found!');
      return;
    }
    final isInHouse = event.row.cells['isInHouse']?.value as bool? ?? false;
    if (!isInHouse) {
      context.push(GuestEditPage.route(field.value));
    }
  }

  PlutoGridConfiguration _getPlutoGridConfiguration() {
    return PlutoGridConfiguration(
      columnFilter: PlutoGridColumnFilterConfig(
        filters: const [
          ...FilterHelper.defaultFilters,
          ClassYouImplemented(),
        ],
        resolveDefaultColumnFilter: (column, resolver) {
          if (column.field == 'id') {
            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          } else if (column.field == 'firstName') {
            return resolver<PlutoFilterTypeContains>()
                as PlutoFilterType; // ✅ FIXED
          } else if (column.field == 'createAt') {
            return resolver<PlutoFilterTypeLessThan>() as PlutoFilterType;
          } else if (column.field == 'rateType') {
            return resolver<ClassYouImplemented>() as PlutoFilterType;
          }
          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
        },
      ),
    );
  }
}

class ClassYouImplemented implements PlutoFilterType {
  @override
  String get title => 'Custom contains';

  @override
  bool Function({
    required String? base,
    required String? search,
    required PlutoColumn? column,
  }) get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        if (base == null || search == null) return false;
        final keys = search.split(',').map((e) => e.toUpperCase()).toList();
        return keys.contains(base.toUpperCase());
      };

  const ClassYouImplemented();
}
