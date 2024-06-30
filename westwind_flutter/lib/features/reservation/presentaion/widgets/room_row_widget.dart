import 'package:flutter/material.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/ReservationCellWidget.dart';

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
            return ReservationCellWidget(
              reservations: reservationsForDate,
              date: date,
              roomNumber: roomNumber,
            );
          }),
        ],
      ),
    );
  }

  List<Reservation> _findReservationsForDate(List<Reservation> reservations, DateTime date) {
    return reservations.where((r) =>
      date.isAtSameMomentAs(r.checkInDate) ||
      (date.isAfter(r.checkInDate) && date.isBefore(r.checkOutDate))
    ).toList();
  }
}