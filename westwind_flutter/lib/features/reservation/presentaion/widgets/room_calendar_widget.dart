import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
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
              .add(FetchReservationsAndTransactions(DateTime.now())),
          tooltip: 'Fetch latest data',
        ),
      ],
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const _TopBarWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      padding: const EdgeInsets.all(8.0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.startDate.day}.${state.startDate.month}.${state.startDate.year}',
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
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != state.startDate) {
      context.read<RoomCalendarBloc>().add(SelectSpecificDate(picked));
    }
  }
}

// ... [Rest of the widget code remains the same]

class LegendWidget extends StatelessWidget {
  const LegendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: const [
          _LegendItem('Reserved', Colors.green),
          _LegendItem('Checked In', Colors.blue),
          _LegendItem('Cancelled', Colors.grey),
          _LegendItem('Multiple Reservations', Colors.purple),
          _LegendItem('Room Transaction', Colors.orange),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendItem(this.label, this.color, {Key? key}) : super(key: key);

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

  const CalendarGridWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateHeaderWidget(state: state),
        Expanded(
          child: ListView.builder(
            itemCount: state.roomNumbers.length,
            itemBuilder: (context, index) {
              final roomNumber = state.roomNumbers[index];
              final roomType = state.roomTypes[index];
              return RoomRowWidget(
                state: state,
                roomNumber: roomNumber,
                roomType: roomType,
                isEvenRow: index % 2 == 0,
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

  const DateHeaderWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
            width: 80,
            child: Text('Room/Type', style: TextStyle(fontSize: 12))),
        ...List.generate(state.daysToShow, (index) {
          final date = state.startDate.add(Duration(days: index));
          return SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                '${date.day}/${date.month}',
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
