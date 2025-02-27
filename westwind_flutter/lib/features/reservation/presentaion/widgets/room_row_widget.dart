import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/reservation_cell_widget.dart';

class RoomRowWidget extends StatefulWidget {
  final RoomCalendarLoaded state;
  final String roomNumber;
  final String roomType;
  final bool isEvenRow;
  final String roomStatus;

  const RoomRowWidget({
    super.key,
    required this.state,
    required this.roomNumber,
    required this.roomType,
    required this.isEvenRow,
    required this.roomStatus,
  });

  @override
  State<RoomRowWidget> createState() => _RoomRowWidgetState();
}

class _RoomRowWidgetState extends State<RoomRowWidget> {

  // In RoomRowWidget
Color _getStatusColor(String status) {
  switch (status) {
    case 'BLK': return Colors.red.shade700; // Blocked
    case 'VCC': return Colors.green.shade600; // Vacant Clean
    case 'DRT': return Colors.orange.shade700; // Dirty
    case 'CO': return Colors.purple.shade500; // Check Out
    case 'M': return Colors.blue.shade600; // Maintenance
    case 'MM': return Colors.indigo.shade500; // Major Maintenance
    case 'CH': return Colors.amber.shade700; // Check
    case 'DDD': return Colors.brown.shade700; // Do Not Disturb
    default: return Colors.grey; // Default
  }
}
/*
  Color _getStatusColor(String status) {
    Color result;
    // Add your status color logic here
    switch ( status ) {
      case 'BLK' : result = Colors.redAccent;
      break;
      case 'VCC' : result = Colors.green;
      break;
          case 'DRT' : result = Colors.black;
      break;
      case 'CO' : result = Colors.orange;
      break;
      default : result =  Colors.blue; 
    }

    return result; // Default color
  }
*/

  List<T> _findItemsForDate<T>(List<T> items, DateTime date) {
    return items.where((item) {
      if (item is Reservation) {
        return item.stayDay.isSameDay(date) ||
            (date.isAfter(item.stayDay) && date.isBefore(item.checkOutDate));
      } else if (item is RoomTransaction) {
        return item.stayDay.isSameDay(date);
      } else if (item is RoomGuest) {
        return item.stayDay.isSameDay(date) ||
            (date.isAfter(item.stayDay) && date.isBefore(item.checkOutDate));
      }
      return false;
    }).toList();
  }


  Widget _buildRoomStatusIndicator(String status) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    decoration: BoxDecoration(
      color: _getStatusColor(status).withOpacity(0.2),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: _getStatusColor(status),
        width: 1,
      ),
    ),
    child: Text(
      status,
      style: TextStyle(
        fontSize: 10,
        color: _getStatusColor(status),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final reservationsForRoom = widget.state.reservationsByRoom[widget.roomNumber] ?? [];
    final roomTransactionsForRoom =
        widget.state.roomTransactionsByRoom[widget.roomNumber] ?? [];
    final roomGuestsForRoom = widget.state.roomGuestsByRoom[widget.roomNumber] ?? [];

    return Container(
      color: widget.isEvenRow ? Colors.grey[200] : Colors.white,
      padding: EdgeInsets.all(0.5),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Text(
              widget.roomNumber,
              style: const TextStyle(fontSize: 14, color: Colors.black,          fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(
            width: 35,
            child: Text(
              widget.roomType,
              style: const TextStyle(fontSize: 13, color: Colors.blue),
            ),
          ),
          SizedBox(
            width: 30,
            child: GestureDetector(
              onTap: () {
                context.read<RoomCalendarBloc>().add(
                  ToggleRoomStatus(
                     int.parse(widget.roomNumber)
                  ),
                );
              },
              child: _buildRoomStatusIndicator(widget.roomStatus),
              /*
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(widget.roomStatus).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: _getStatusColor(widget.roomStatus),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  widget.roomStatus,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(widget.roomStatus),
                   // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
*/

            ),
          ),
          ...List.generate(widget.state.daysToShow, (index) {
            final date = widget.state.startDate.add(Duration(days: index));
            final reservationsForDate =
                _findItemsForDate(reservationsForRoom, date);
            final roomTransactionsForDate =
                _findItemsForDate(roomTransactionsForRoom, date);
            final roomGuestsForDate =
                _findItemsForDate(roomGuestsForRoom, date);

            return ReservationCellWidget(
              reservations: reservationsForDate,
              roomTransactions: roomTransactionsForDate,
              roomGuests: roomGuestsForDate,
              date: date,
              roomNumber: widget.roomNumber,
            );
          }),
        ],
      ),
    );
  }
}