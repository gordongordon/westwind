import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';

import 'package:westwind_flutter/features/guest/presentation/widgets/guest_list_widget.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/widgets/reservation_list_widget.dart';

class ReservationListPage extends StatelessWidget {
  static String route() => "/reservations";

  const ReservationListPage({super.key});

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
           context.push(ReservationEditPage.routeNew());   
      },child: const Icon( Icons.add),),
      body: const ReservationListWidgets(),
    );
    
  }
}
