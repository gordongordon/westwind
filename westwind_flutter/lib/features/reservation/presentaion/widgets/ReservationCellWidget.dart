
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';

class ReservationCellWidget extends StatefulWidget {
  final List<Reservation> reservations;
  final DateTime date;
  final String roomNumber;

  const ReservationCellWidget({
    Key? key,
    required this.reservations,
    required this.date,
    required this.roomNumber,
  }) : super(key: key);

  @override
  State<ReservationCellWidget> createState() => _ReservationCellWidgetState();
}

class _ReservationCellWidgetState extends State<ReservationCellWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Reservation>(
      onWillAccept: (data) => true,
      onAccept: (data) => _handleDrop(context, data),
      builder: (context, candidateData, rejectedData) {
        if (widget.reservations.isEmpty) {
          return _buildEmptyCell(context);
        } else if (widget.reservations.length == 1) {
          return _buildSingleReservationCell(context, widget.reservations.first);
        } else {
          return _buildMultiReservationCell(context);
        }
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

  Widget _buildMultiReservationCell(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 110,
        height: isExpanded ? widget.reservations.length * 35.0 : 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.orange,
        ),
        child: isExpanded
            ? _buildExpandedContent(context)
            : _buildCollapsedContent(context),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return ListView.builder(
      itemCount: widget.reservations.length,
      itemBuilder: (context, index) {
        final reservation = widget.reservations[index];
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
                  Icon(Icons.drag_handle, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    return Center(
      child: Text(
        '${widget.reservations.length} Reservations',
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
    final String displayText = '${reservation.guest?.firstName ?? ''} ${reservation.guest?.lastName ?? ''}'.trim();

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

  void _handleDrop(BuildContext context, Reservation droppedReservation) {
    if (droppedReservation.roomId.toString() != widget.roomNumber || droppedReservation.checkInDate != widget.date) {
      context.read()<RoomCalendarBloc>().add(MoveReservation(
        reservation: droppedReservation,
        newRoomNumber: widget.roomNumber,
        newStartDate: widget.date,
      ));
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
          title: Text('Reservation Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Guest: ${reservation.guest?.firstName} ${reservation.guest?.lastName}'),
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

  void _openReservationEditPage(BuildContext context, Reservation reservation) {
    if (reservation.id != null && reservation.id! > 0) {
      context.push(ReservationEditPage.route(reservation.id));
    }
  }

  void _openNewReservationPage(BuildContext context) {
    context.push(ReservationEditPage.routeNew());
  }
}