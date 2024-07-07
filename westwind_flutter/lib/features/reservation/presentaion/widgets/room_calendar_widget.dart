import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';

class RoomCalendarWidget extends StatefulWidget {
  const RoomCalendarWidget({Key? key}) : super(key: key);

  @override
  State<RoomCalendarWidget> createState() => _RoomCalendarWidgetState();
}

class _RoomCalendarWidgetState extends State<RoomCalendarWidget> {
  @override
  void initState() {
    super.initState();
    // Initialize the calendar and fetch data
    context.read<RoomCalendarBloc>().add(const InitializeCalendar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<RoomCalendarBloc, RoomCalendarState>(
        listener: (context, state) {
          // Handle any state changes that require UI feedback
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
          onPressed: () => context.read<RoomCalendarBloc>().add(FetchReservationsAndTransactions(DateTime.now())),
          tooltip: 'Fetch latest reservations',
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
                onPressed: () => context.read<RoomCalendarBloc>().add(const NavigateCalendarDays(-1)),
                tooltip: 'Previous day',
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () => context.read<RoomCalendarBloc>().add(const NavigateCalendarDays(1)),
                tooltip: 'Next day',
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.keyboard_double_arrow_left),
                onPressed: () => context.read<RoomCalendarBloc>().add(const NavigateCalendarWeeks(-1)),
                tooltip: 'Previous week',
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_double_arrow_right),
                onPressed: () => context.read<RoomCalendarBloc>().add(const NavigateCalendarWeeks(1)),
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
                    context.read<RoomCalendarBloc>().add(ChangeDaysToShow(value));
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

class DateHeaderWidget extends StatelessWidget {
  final RoomCalendarLoaded state;

  const DateHeaderWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
            width: 50, child: Text('Room', style: TextStyle(fontSize: 12))),
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

class RoomRowWidget extends StatelessWidget {
  final RoomCalendarLoaded state;
  final String roomNumber;
  final bool isEvenRow;

  const RoomRowWidget({
    Key? key,
    required this.state,
    required this.roomNumber,
    required this.isEvenRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservationsForRoom = state.reservationsByRoom[roomNumber] ?? [];
    final roomTransactionsForRoom = state.roomTransactionsByRoom[roomNumber] ?? [];

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
            final reservationsForDate = _findReservationsForDate(reservationsForRoom, date);
            final roomTransactionsForDate = _findRoomTransactionsForDate(roomTransactionsForRoom, date);
            return ReservationCellWidget(
              reservations: reservationsForDate,
              roomTransactions: roomTransactionsForDate,
              date: date,
              roomNumber: roomNumber,
            );
          }),
        ],
      ),
    );
  }

  List<Reservation> _findReservationsForDate(List<Reservation> reservations, DateTime date) {
    return reservations
        .where((r) =>
            r.stayDay.isSameDay(date) ||
            (date.isAfter(r.stayDay) && date.isBefore(r.checkOutDate)))
        .toList();
  }

  List<RoomTransaction> _findRoomTransactionsForDate(List<RoomTransaction> roomTransactions, DateTime date) {
    return roomTransactions
        .where((r) => r.stayDay.isSameDay(date))
        .toList();
  }
}

class ReservationCellWidget extends StatefulWidget {
  final List<Reservation> reservations;
  final List<RoomTransaction> roomTransactions;
  final DateTime date;
  final String roomNumber;

  const ReservationCellWidget({
    Key? key,
    required this.reservations,
    required this.roomTransactions,
    required this.date,
    required this.roomNumber,
  }) : super(key: key);

  @override
  ReservationCellWidgetState createState() => ReservationCellWidgetState();
}

class ReservationCellWidgetState extends State<ReservationCellWidget> {
  bool isExpanded = false;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Reservation>(
      onWillAcceptWithDetails: (details) {
        final Reservation draggedReservation = details.data;
        setState(() => isHovering = true);
        
        if (draggedReservation.isCheckedIn) {
          return draggedReservation.stayDay.isSameDay(widget.date) && 
                 draggedReservation.roomId.toString() != widget.roomNumber;
        } else {
           final currentDate = DateTime.now().getDateOnly();
           return widget.date.isSameDay(currentDate) || widget.date.isAfter(currentDate);
        }
      },
      onAcceptWithDetails: (details) => _handleDrop(context, details.data),
      onLeave: (_) => setState(() => isHovering = false),
      builder: (context, candidateData, rejectedData) {
        Widget cellContent;
        final List<dynamic> items = [...widget.reservations, ...widget.roomTransactions];
        if (items.isEmpty) {
          cellContent = _buildEmptyCell(context);
        } else if (items.length == 1) {
          cellContent = _buildSingleItemCell(context, items.first);
        } else {
          cellContent = _buildMultiItemCell(context, items);
        }

        return Stack(
          children: [
            cellContent,
            if (isHovering && items.isNotEmpty)
              Container(
                width: 110,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.3),
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.orange),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyCell(BuildContext context) {
    return GestureDetector(
      onTap: () => _openNewReservationPage(context),
      child: Container(
        width: 110,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSingleItemCell(BuildContext context, dynamic item) {
    if (item is Reservation) {
      return _buildSingleReservationCell(context, item);
    } else if (item is RoomTransaction) {
      return _buildSingleRoomTransactionCell(context, item);
    }
    return _buildEmptyCell(context);
  }

  Widget _buildSingleReservationCell(BuildContext context, Reservation reservation) {
    return Draggable<Reservation>(
      data: reservation,
      feedback: _buildDragFeedback(context, reservation),
      childWhenDragging: _buildEmptyCell(context),
      child: GestureDetector(
        onTap: () => _showReservationDetails(context, reservation),
        onDoubleTap: () => _openReservationEditPage(context, reservation),
        child: _buildReservationContent(context, reservation),
      ),
    );
  }

  Widget _buildSingleRoomTransactionCell(BuildContext context, RoomTransaction transaction) {
    return GestureDetector(
      onTap: () => _showRoomTransactionDetails(context, transaction),
      child: Container(
        width: 110,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.orange,
        ),
        child: Center(
          child: Text(
            '${transaction.guest!.firstName} ${transaction.guest!.lastName}',
            style: const TextStyle(
              color: Colors.white,
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

  Widget _buildMultiItemCell(BuildContext context, List<dynamic> items) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 110,
        height: isExpanded ? items.length * 35.0 : 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.purple,
        ),
        child: isExpanded
            ? _buildExpandedContent(context, items)
            : _buildCollapsedContent(context, items),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context, List<dynamic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item is Reservation) {
          return _buildReservationListItem(context, item);
        } else if (item is RoomTransaction) {
          return _buildRoomTransactionListItem(context, item);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCollapsedContent(BuildContext context, List<dynamic> items) {
    return Center(
      child: Text(
        '${items.length} Items',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildReservationContent(BuildContext context, Reservation reservation) {
    final String displayText =
        '${reservation.guest?.firstName ?? ''} ${reservation.guest?.lastName ?? ''}'
            .trim();

    return Container(
      width: 110,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: _getReservationColor(reservation),
      ),
      child: Center(
        child: Text(
          displayText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildDragFeedback(BuildContext context, Reservation reservation) {
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: _buildReservationContent(context, reservation),
      ),
    );
  }

  Widget _buildReservationListItem(BuildContext context, Reservation reservation) {
    return Draggable<Reservation>(
      data: reservation,
      feedback: _buildDragFeedback(context, reservation),
      child: GestureDetector(
        onTap: () => _showReservationDetails(context, reservation),
        onDoubleTap: () => _openReservationEditPage(context, reservation),
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${reservation.guest?.firstName} ${reservation.guest?.lastName}',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.drag_handle, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomTransactionListItem(BuildContext context, RoomTransaction transaction) {
    return GestureDetector(
      onTap: () => _showRoomTransactionDetails(context, transaction),
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${transaction.guest!.firstName} ${transaction.guest!.lastName}',
                style: const TextStyle(fontSize: 10, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.attach_money, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _handleDrop(BuildContext context, Reservation droppedReservation) {
    setState(() => isHovering = false);

    final currentDate = DateTime.now().getDateOnly();

    if (droppedReservation.isCheckedIn) {
      if (droppedReservation.roomId.toString() != widget.roomNumber) {
        context.read<RoomCalendarBloc>().add(MoveReservation(
          reservation: droppedReservation,
          newRoomNumber: widget.roomNumber,
          newStartDate: droppedReservation.stayDay,
        ));
      }
    } else {
      if ((widget.date.isSameDay(currentDate) || widget.date.isAfter(currentDate)) &&
          (droppedReservation.roomId.toString() != widget.roomNumber || !droppedReservation.stayDay.isSameDay(widget.date))) {
        context.read<RoomCalendarBloc>().add(MoveReservation(
          reservation: droppedReservation,
          newRoomNumber: widget.roomNumber,
          newStartDate: widget.date,
        ));
      }
    }
  }

  Color _getReservationColor(Reservation reservation) {
    if (reservation.isCheckedIn) return Colors.blue;
    if (reservation.isCanceled) return Colors.grey;
    return Colors.green;
  }

  void _showReservationDetails(BuildContext context, Reservation reservation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reservation Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Guest: ${reservation.guest?.firstName} ${reservation.guest?.lastName}'),
              Text('Stay-day: ${reservation.stayDay.day}/${reservation.stayDay.month}/${reservation.stayDay.year}'),
              Text('Check-in: ${reservation.checkInDate.day}/${reservation.checkInDate.month}/${reservation.checkInDate.year}'),
              Text('Check-out: ${reservation.checkOutDate.day}/${reservation.checkOutDate.month}/${reservation.checkOutDate.year}'),
              Text('Room: ${reservation.roomId}'),
              Text('Status: ${reservation.isCheckedIn ? 'Checked In' : 'Not Checked In'}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showRoomTransactionDetails(BuildContext context, RoomTransaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Room Transaction Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Transaction ID: ${transaction.id}'),
              Text('Room: ${transaction.roomId}'),
              Text('Stay Day: ${transaction.stayDay.day}/${transaction.stayDay.month}/${transaction.stayDay.year}'),
              Text('Amount: ${transaction.amount}'),
              Text('Total: ${transaction.total}'),
              Text('Description: ${transaction.description}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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