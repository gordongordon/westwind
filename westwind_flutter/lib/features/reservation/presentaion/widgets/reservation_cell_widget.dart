import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/guest_reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_guest_transactions_manage_page.dart';

class ReservationCellWidget extends StatefulWidget {
  final List<Reservation> reservations;
  final List<RoomTransaction> roomTransactions;
  final List<RoomGuest> roomGuests;
  final DateTime date;
  final String roomNumber;

  const ReservationCellWidget({
    super.key,
    required this.reservations,
    required this.roomTransactions,
    required this.roomGuests,
    required this.date,
    required this.roomNumber,
  });

  @override
  ReservationCellWidgetState createState() => ReservationCellWidgetState();
}

class ReservationCellWidgetState extends State<ReservationCellWidget> {
  bool isExpanded = false;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Object>(
      onWillAcceptWithDetails: (details) {
        final draggedObject = details.data;
        setState(() => isHovering = true);

        if (draggedObject is Reservation) {
          return _canAcceptReservation(draggedObject);
        } else if (draggedObject is RoomGuest) {
          return _canAcceptRoomGuest(draggedObject);
        }

        return false;
      },
      onAcceptWithDetails: (details) => _handleDrop(context, details.data),
      onLeave: (_) => setState(() => isHovering = false),
      builder: (context, candidateData, rejectedData) {
        Widget cellContent;
        final List<dynamic> items = [
          ...widget.reservations,
          ...widget.roomTransactions,
          ...widget.roomGuests
        ];
        
       // widget.
        final roomNumber = widget.roomNumber;
        final date = widget.date;
       //  cellContent.
        if (items.isEmpty) {
          cellContent = _buildEmptyCell(context, roomNumber, date);
        } else if (items.length == 1) {
          cellContent = _buildSingleItemCell(context, items.first, roomNumber, date);
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

  bool _canAcceptReservation(Reservation reservation) {
    final currentDate = DateTime.now().getDateOnly();
    return widget.date.isAtSameMomentAs(currentDate) ||
        widget.date.isAfter(currentDate);
  }

  bool _canAcceptRoomGuest(RoomGuest roomGuest) {
    final currentDate = DateTime.now().getDateOnly();
    return widget.date.isAtSameMomentAs(currentDate) ||
        widget.date.isAfter(currentDate);
  }

  /*
  bool _canAcceptRoomGuest(RoomGuest roomGuest) {
    return roomGuest.stayDate.isSameDay(widget.date) && 
           roomGuest.roomId.toString() != widget.roomNumber;
  }
  */

  void _handleDrop(BuildContext context, dynamic droppedObject) {
    setState(() => isHovering = false);

    if (droppedObject is Reservation) {
      _handleReservationDrop(context, droppedObject);
    } else if (droppedObject is RoomGuest) {
      _handleRoomGuestDrop(context, droppedObject);
    }
  }

  void _handleReservationDrop(BuildContext context, Reservation reservation) {
    final currentDate = DateTime.now().getDateOnly();
    if ((widget.date.isAtSameMomentAs(currentDate) ||
            widget.date.isAfter(currentDate)) &&
        // if ((widget.date.isSameDay(currentDate) || widget.date.isAfter(currentDate)) &&
        (reservation.roomId.toString() != widget.roomNumber ||
            !reservation.stayDay.isSameDay(widget.date))) {
      context.read<RoomCalendarBloc>().add(MoveReservation(
            reservation: reservation,
            newRoomNumber: widget.roomNumber,
            newStartDate: widget.date,
          ));
    }
  }

  void _handleRoomGuestDrop(BuildContext context, RoomGuest droppedRoomGuest) {
    // final currentDate = DateTime.now().getDateOnly();

    if (droppedRoomGuest.roomId.toString() != widget.roomNumber) {
      context.read<RoomCalendarBloc>().add(MoveRoomGuest(
            roomGuest: droppedRoomGuest,
            newRoomNumber: widget.roomNumber,
            newStayDate: droppedRoomGuest.stayDay,
          ));
    }
  }
/*
    if ((widget.date.isAtSameMomentAs(currentDate) || widget.date.isAfter(currentDate)) &&
  //    if ((widget.date.isSameDay(currentDate) || widget.date.isAfter(currentDate)) &&
        (reservation.roomId.toString() != widget.roomNumber || !reservation.stayDate.isSameDay(widget.date))) {
      context.read<RoomCalendarBloc>().add(MoveRoomGuest(
        roomGuest: reservation,
        newRoomNumber: widget.roomNumber,
        newStayDate: widget.date,
      ));
    }

  }
*/
/*
  void _handleRoomGuestDrop(BuildContext context, RoomGuest roomGuest) {
    if (roomGuest.roomId.toString() != widget.roomNumber) {
      // Implement the logic to move a RoomGuest
      context.read<RoomCalendarBloc>().add(MoveRoomGuest(
        roomGuest: roomGuest,
        newRoomNumber: widget.roomNumber,
        newStayDate: widget.date,
      ));
    }
  }
*/

  

  Widget _buildEmptyCell(BuildContext context, [ String? roomNumber, DateTime? date ]) {
    return GestureDetector(
   //   onTap: () => _openNewReservationPage(context),
        onTap: () => _openNewGuestReservationEditPage(context, roomNumber!, date! ),
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



  Widget _buildSingleItemCell(BuildContext context, dynamic item, String roomNumber, DateTime date) {
    if (item is Reservation) {
      return _buildSingleReservationCell(context, item);
    } else if (item is RoomTransaction) {
      return _buildSingleRoomTransactionCell(context, item);
    } else if (item is RoomGuest) {
      return _buildSingleRoomGuestCell(context, item);
    }
    return _buildEmptyCell(context, roomNumber, date);
  }

  Widget _buildSingleReservationCell(
      BuildContext context, Reservation reservation) {
    return Draggable<Reservation>(
      data: reservation,
      feedback: _buildDragFeedback(context, reservation),
      childWhenDragging: _buildEmptyCell(context, reservation.roomId.toString(), reservation.stayDay),
      child: GestureDetector(
        onTap: () => _showReservationDetails(context, reservation),
        onDoubleTap: () => _openReservationEditPage(context, reservation),
        child: _buildReservationContent(context, reservation),
      ),
    );
  }

  Widget _buildSingleRoomTransactionCell(
      BuildContext context, RoomTransaction transaction) {
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

  Widget _buildSingleRoomGuestCell(BuildContext context, RoomGuest roomGuest) {
    return Draggable<RoomGuest>(
      data: roomGuest,
      feedback: _buildDragFeedback(context, roomGuest),
      childWhenDragging: _buildEmptyCell(context),
      child: GestureDetector(
        onTap: () => _showRoomGuestDetails(context, roomGuest),
        onDoubleTap: () => _openRoomGuestEditPage(context, roomGuest),
        onLongPress: () =>
            _openRoomGuestTransactionManagePage(context, roomGuest),
        //  context.push(RoomGuestTransactionsManagePage.route(roomGuest.id)),
        child: _buildRoomGuestContent(context, roomGuest),
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
        duration: const Duration(milliseconds: 200),
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
        } else if (item is RoomGuest) {
          return _buildRoomGuestListItem(context, item);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCollapsedContent(BuildContext context, List<dynamic> items) {
    return Center(
      child: Text(
        '${items.length} Guests',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildReservationContent(
      BuildContext context, Reservation reservation) {
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

  Widget _buildRoomGuestContent(BuildContext context, RoomGuest roomGuest) {
    final String displayText =
        '${roomGuest.guest?.firstName ?? ''} ${roomGuest.guest?.lastName ?? ''}'
            .trim();

    return Container(
      width: 110,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.blue,
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

  Widget _buildDragFeedback(BuildContext context, dynamic item) {
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: item is Reservation
            ? _buildReservationContent(context, item)
            : _buildRoomGuestContent(context, item),
      ),
    );
  }

  Widget _buildReservationListItem(
      BuildContext context, Reservation reservation) {
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

  Widget _buildRoomTransactionListItem(
      BuildContext context, RoomTransaction transaction) {
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

  Widget _buildRoomGuestListItem(BuildContext context, RoomGuest roomGuest) {
    return Draggable<RoomGuest>(
      data: roomGuest,
      feedback: _buildDragFeedback(context, roomGuest),
      child: GestureDetector(
        //! Handle
        onTap: () => _showRoomGuestDetails(context, roomGuest),
        onDoubleTap: () => _openRoomGuestEditPage(context, roomGuest),
        onLongPress: () =>
            _openRoomGuestTransactionManagePage(context, roomGuest),
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${roomGuest.guest?.firstName} ${roomGuest.guest?.lastName}',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.hotel, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
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
              Text(
                  'Guest: ${reservation.guest?.firstName} ${reservation.guest?.lastName}'),
              Text(
                  'Stay-day: ${reservation.stayDay.day}/${reservation.stayDay.month}/${reservation.stayDay.year}'),
              Text(
                  'Check-in: ${reservation.checkInDate.day}/${reservation.checkInDate.month}/${reservation.checkInDate.year}'),
              Text(
                  'Check-out: ${reservation.checkOutDate.day}/${reservation.checkOutDate.month}/${reservation.checkOutDate.year}'),
              Text('Room: ${reservation.roomId}'),
              Text('Rate Type :  ${reservation.rateType}'),
              Text(
                  'Status: ${reservation.isCheckedIn ? 'Checked In' : 'Not Checked In'}'),
              Text('Rate : ${reservation.rate}'),
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

  void _showRoomGuestDetails(BuildContext context, RoomGuest roomGuest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('RoomGuest Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Guest: ${roomGuest.guest?.firstName} ${roomGuest.guest!.lastName}'),
              Text(
                  'Stay-day: ${roomGuest.stayDay.day}/${roomGuest.stayDay.month}/${roomGuest.stayDay.year}'),
              Text(
                  'Check-in: ${roomGuest.checkInDate.day}/${roomGuest.checkInDate.month}/${roomGuest.checkInDate.year}'),
              Text(
                  'Check-out: ${roomGuest.checkOutDate.day}/${roomGuest.checkOutDate.month}/${roomGuest.checkOutDate.year}'),
              Text('Room: ${roomGuest.roomId}'),
              Text('Rate Type :  ${roomGuest.rateType}'),
              Text('Rate Reason :  ${roomGuest.rateReason}'),
              Text('Rate : ${roomGuest.rate}'),
              Text('Balance : ${roomGuest.guest!.accountBalance}')
              // Text('Status: ${roomGuest.isCheckedIn ? 'Checked In' : 'Not Checked In'}'),
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

  void _showRoomTransactionDetails(
      BuildContext context, RoomTransaction transaction) {
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
              Text(
                  'Stay Day: ${transaction.stayDay.day}/${transaction.stayDay.month}/${transaction.stayDay.year}'),
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

  void _openNewGuestReservationEditPage(BuildContext context, String roomNumber, DateTime date ) {
      final int roomId = int.parse(roomNumber);

      context.push(GuestReservationEditPage.routeCalendar(roomId, date));
  }

  void _openNewReservationPage(BuildContext context) {
    context.push(ReservationEditPage.routeNew());
  }

  void _openRoomGuestEditPage(BuildContext context, RoomGuest roomGuest) {
    if (roomGuest.id != null && roomGuest.id! > 0) {
      context.push(RoomGuestEditPage.route(roomGuest.id));
    }
  }

  void _openRoomGuestTransactionManagePage(
      BuildContext context, RoomGuest roomGuest) {
    if (roomGuest.id != null && roomGuest.id! > 0) {
      context.push(RoomGuestTransactionsManagePage.route(roomGuest.id));
    }
  }
}
