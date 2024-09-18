
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/reservation_cell_widget.dart';

class RoomRowWidget extends StatelessWidget {
  final RoomCalendarLoaded state;
  final String roomNumber;
  final String roomType;
  final bool isEvenRow;

  const RoomRowWidget({
    super.key,
    required this.state,
    required this.roomNumber,
    required this.roomType,
    required this.isEvenRow,
  });

  @override
  Widget build(BuildContext context) {
    final reservationsForRoom = state.reservationsByRoom[roomNumber] ?? [];
    final roomTransactionsForRoom =
        state.roomTransactionsByRoom[roomNumber] ?? [];
    final roomGuestsForRoom = state.roomGuestsByRoom[roomNumber] ?? [];

    return Container(
      color: isEvenRow ? Colors.grey[200] : Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              roomNumber,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              roomType,
              style: const TextStyle(fontSize: 13, color: Colors.blue),
            ),
          ),
          ...List.generate(state.daysToShow, (index) {
            final date = state.startDate.add(Duration(days: index));
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
              roomNumber: roomNumber,
            );
          }),
        ],
      ),
    );
  }

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

        //  return item.stayDate.isSameDay(date);
      }
      return false;
    }).toList();
  }
}

