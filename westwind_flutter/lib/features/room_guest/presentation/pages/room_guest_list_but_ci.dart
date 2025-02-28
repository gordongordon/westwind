import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_guest/presentation/widgets/room_guest_list_but_ci_widget.dart';
import 'package:westwind_flutter/features/room_guest/presentation/widgets/room_guest_list_but_co_widget.dart';

class RoomGuestListButCIPage extends StatelessWidget {
  static String route() => "/roomguestsci";

  const RoomGuestListButCIPage({super.key});

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title: const Text("RoomGuest C/I"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
           context.push(RoomGuestEditPage.routeNew());   
      },child: const Icon( Icons.add),),
      body: const RoomGuestListButCIWidget(),
    );
    
  }
}