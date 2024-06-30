import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/room_row_widget.dart';

class RoomCalendar extends StatefulWidget {
  const RoomCalendar({Key? key}) : super(key: key);

  @override
  State<RoomCalendar> createState() => _RoomCalendarState();
}

class _RoomCalendarState extends State<RoomCalendar> {
  @override
  void initState() {
    super.initState();
    context.read<RoomCalendarBloc>().add(FetchReservations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Westwind Motor Inn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<RoomCalendarBloc>().add(FetchReservations()),
            tooltip: 'Fetch latest reservations',
          ),
        ],
      ),
      body: BlocBuilder<RoomCalendarBloc, RoomCalendarState>(
        builder: (context, state) {
          if (state is RoomCalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomCalendarError) {
            return Center(child: Text(state.message));
          } else if (state is RoomCalendarLoaded) {
            return Column(
              children: [
                _buildTopBar(context, state),
                const _LegendWidget(),
                Expanded(child: _CalendarGridWidget(state: state)),
              ],
            );
          }
          return const Center(child: Text('Initializing...'));
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, RoomCalendarLoaded state) {
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
                icon: const Icon(Icons.navigate_before),
                onPressed: () => _changeStartDate(context, state, -state.daysToShow),
                tooltip: 'Previous week',
              ),
              IconButton(
                icon: const Icon(Icons.navigate_next),
                onPressed: () => _changeStartDate(context, state, state.daysToShow),
                tooltip: 'Next week',
              ),
              const SizedBox(width: 20),
              DropdownButton<int>(
                value: state.daysToShow,
                items: [7, 14, 30].map((days) => DropdownMenuItem<int>(value: days, child: Text('$days days'))).toList(),
                onChanged: (value) => context.read<RoomCalendarBloc>().add(ChangeDaysToShow(value!)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _changeStartDate(BuildContext context, RoomCalendarLoaded state, int daysToAdd) {
    context.read<RoomCalendarBloc>().add(ChangeStartDate(state.startDate.add(Duration(days: daysToAdd))));
  }
}

class _LegendWidget extends StatelessWidget {
  const _LegendWidget({Key? key}) : super(key: key);

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

class _CalendarGridWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const _CalendarGridWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateHeaderWidget(state: state),
        Expanded(
          child: ListView.builder(
            itemCount: state.roomNumbers.length,
            itemBuilder: (context, index) {
              final roomNumber = state.roomNumbers[index];
              return RoomRowWidget(
                state: state,
                roomNumber: roomNumber,
                isEvenRow: index % 2 == 0,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DateHeaderWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const _DateHeaderWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 50, child: Text('Room', style: TextStyle(fontSize: 12))),
        ...List.generate(state.daysToShow, (index) {
          final date = state.startDate.add(Duration(days: index));
          return SizedBox(
            width: 100,
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



