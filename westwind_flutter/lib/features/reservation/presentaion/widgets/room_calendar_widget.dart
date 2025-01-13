import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/reservation_cell_widget.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/room_row_widget.dart';

class RoomCalendarWidget extends StatefulWidget {
  const RoomCalendarWidget({super.key});

  @override
  State<RoomCalendarWidget> createState() => _RoomCalendarWidgetState();
}

class _RoomCalendarWidgetState extends State<RoomCalendarWidget> {
  @override
  void initState() {
    super.initState();
    context.read<RoomCalendarBloc>().add(const InitializeCalendar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<RoomCalendarBloc, RoomCalendarState>(
        listener: (context, state) {
          if (state is RoomCalendarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is RoomCalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomCalendarLoaded) {
            return Column(
              children: [
                _TopBarWidget(state: state),
                const LegendWidget(),
                Expanded(child: CalendarGridWidget(state: state)),
              ],
            );
          }
          return const Center(child: Text('Initializing...'));
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
     title: const Text('Westwind Motor Inn'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context
              .read<RoomCalendarBloc>()
              .add(FetchReservationsAndTransactions(DateTime.now().toUtc())),
          tooltip: 'Fetch latest data',
        ),
      ],
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const _TopBarWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(6.0),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.startDate.getMonthNameDD()}',
            //       '${state.startDate.day}.${state.startDate.month}.${state.startDate.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () => context
                    .read<RoomCalendarBloc>()
                    .add(const NavigateCalendarDays(-1)),
                tooltip: 'Previous day',
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () => context
                    .read<RoomCalendarBloc>()
                    .add(const NavigateCalendarDays(1)),
                tooltip: 'Next day',
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.keyboard_double_arrow_left),
                onPressed: () => context
                    .read<RoomCalendarBloc>()
                    .add(const NavigateCalendarWeeks(-1)),
                tooltip: 'Previous week',
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_double_arrow_right),
                onPressed: () => context
                    .read<RoomCalendarBloc>()
                    .add(const NavigateCalendarWeeks(1)),
                tooltip: 'Next week',
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
                tooltip: 'Select date',
              ),
              const SizedBox(width: 16),
              DropdownButton<int>(
                value: state.daysToShow,
                items: [7, 14, 30]
                    .map((days) => DropdownMenuItem<int>(
                        value: days, child: Text('$days days')))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    context
                        .read<RoomCalendarBloc>()
                        .add(ChangeDaysToShow(value));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.startDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != state.startDate) {
      context.read<RoomCalendarBloc>().add(SelectSpecificDate(picked));
    }
  }
}

// ... [Rest of the widget code remains the same]

class LegendWidget extends StatelessWidget {
  const LegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: const [
          _LegendItem('Reservation', Colors.green),
          _LegendItem('RoomGuest - Checked In', Colors.blue),
          _LegendItem('Cancelled', Colors.grey),
          _LegendItem('To be C/I share RM', Colors.blueGrey),
          _LegendItem('Unavariable RM', Colors.purple),
          _LegendItem('Room Transaction - Posted', Colors.orange),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendItem(this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}

class CalendarGridWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const CalendarGridWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateHeaderWidget(state: state),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(1),
            itemCount: state.roomNumbers.length,
            itemBuilder: (context, index) {
              final roomNumber = state.roomNumbers[index];
              final roomType = state.roomTypes[index];
              return RoomRowWidget(
                state: state,
                roomNumber: roomNumber,
                roomType: roomType,
                isEvenRow: index % 2 == 0,
                roomStatus: "MM",
              );
            },
          ),
        ),
      ],
    );
  }
}

class DateHeaderWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const DateHeaderWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
            width: 110,
            child: Text('Room/Type/HH', style: TextStyle(fontSize: 12))),
        ...List.generate(state.daysToShow, (index) {
          final date = state.startDate.add(Duration(days: index));
          return SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                '${date.getDDMonthName()}',
                //'${date.day}/${date.getDDMonthName()}',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ],
    );
  }
}
