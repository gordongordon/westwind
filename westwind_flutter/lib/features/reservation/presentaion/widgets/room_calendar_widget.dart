import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';

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
              return _RoomRowWidget(
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

class _RoomRowWidget extends StatelessWidget {
  final RoomCalendarLoaded state;
  final String roomNumber;
  final bool isEvenRow;

  const _RoomRowWidget({
    Key? key,
    required this.state,
    required this.roomNumber,
    required this.isEvenRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservationsForRoom = state.reservationsByRoom[roomNumber] ?? [];

    return Container(
      color: isEvenRow ? Colors.grey[200] : Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              roomNumber,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          ...List.generate(state.daysToShow, (index) {
            final date = state.startDate.add(Duration(days: index));
            final reservation = _findReservationForDate(reservationsForRoom, date);
            return _ReservationCellWidget(
              reservation: reservation,
              date: date,
              roomNumber: roomNumber,
            );
          }),
        ],
      ),
    );
  }

  Reservation _findReservationForDate(List<Reservation> reservations, DateTime date) {
    return reservations.firstWhere(
      (r) => date.isAtSameMomentAs(r.checkInDate) || (date.isAfter(r.checkInDate) && date.isBefore(r.checkOutDate)),
      orElse: () => Reservation(
        id: 0,
        checkInDate: date,
        checkOutDate: date,
        guestId: 0,
        roomId: int.tryParse(roomNumber) ?? 0,
        rateType: RateType.standard,
        rateReason: RateReason.single,
        rate: 0,
        isCheckedIn: false,
        isCanceled: false,
        isNightShift: false,
        dateCreate: DateTime.now(),
      ),
    );
  }
}

class _ReservationCellWidget extends StatelessWidget {
  final Reservation reservation;
  final DateTime date;
  final String roomNumber;

  const _ReservationCellWidget({
    Key? key,
    required this.reservation,
    required this.date,
    required this.roomNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Reservation>(
      onWillAcceptWithDetails: (details) => _onWillAccept(context, details),
      onAcceptWithDetails: (details) => _onAccept(context, details),
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            Draggable<Reservation>(
              data: reservation,
              feedback: _buildReservationContent(context, reservation, date),
              childWhenDragging: Container(
                width: 110,
                height: 30,
                color: Colors.grey.withOpacity(0.5),
              ),
              child: _buildReservationContent(context, reservation, date),
            ),
          ],
        );
      },
    );
  }

  bool _onWillAccept(BuildContext context, DragTargetDetails<Reservation> details) {
    final droppedReservation = details.data;
    return droppedReservation.roomId.toString() != roomNumber ||
        !context.read<RoomCalendarBloc>().isOverlapping(droppedReservation, reservation, date);
  }

  void _onAccept(BuildContext context, DragTargetDetails<Reservation> details) {
    final droppedReservation = details.data;
    context.read<RoomCalendarBloc>().add(MoveReservation(
      reservation: droppedReservation,
      newRoomNumber: roomNumber,
      newStartDate: date,
    ));
  }

  Widget _buildReservationContent(BuildContext context, Reservation reservation, DateTime date) {
    final bool isEmptyReservation = reservation.id == 0;
    final String displayText = isEmptyReservation
        ? ''
        : '${reservation.guest?.firstName ?? ''} ${reservation.guest?.lastName ?? ''}'.trim();

    return GestureDetector(
      onTap: () => _handleReservationTap(context, reservation),
      onDoubleTap: isEmptyReservation ? null : () => _openReservationEditPage(context, reservation),
      child: Container(
        width: 110,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: isEmptyReservation ? Colors.white : _getReservationColor(reservation),
        ),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              color: isEmptyReservation ? Colors.black : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Color _getReservationColor(Reservation reservation) {
    if (reservation.id == 0) return Colors.white;
    if (reservation.isCheckedIn) return Colors.blue;
    if (reservation.isCanceled) return Colors.grey;
    return Colors.green;
  }

  void _handleReservationTap(BuildContext context, Reservation reservation) {
    if (reservation.id == 0) {
      _openNewReservationPage(context);
    } else {
      _showReservationDetails(context, reservation);
    }
  }

  void _showReservationDetails(BuildContext context, Reservation reservation) {
    // Implementation of showing reservation details (e.g., in a dialog)
  }

  void _openReservationEditPage(BuildContext context, Reservation reservation) {
    if (reservation.id != null && reservation.id! > 0) {
      context.push(ReservationEditPage.route(reservation.id));
    }
  }

  void _openNewReservationPage(BuildContext context) {
    context.push(ReservationEditPage.routeNew());
  }
}