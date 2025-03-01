import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/room_calendar_widget.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';


class ReservationCalendarPage extends StatelessWidget {
  static String route() => "/reservationCalendar";

  const ReservationCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
       // title: const Text("Calendar"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
       // backgroundColor: Colors.,
        onPressed: () {
           context.push(ReservationEditPage.routeNew());   
      },child: const Icon( Icons.add),),
    //   body: const ReservationListWidgets(),
  //  body: const ReservationListWidget(),
    body: const RoomCalendarWidget(),
    );
    
  }
}
