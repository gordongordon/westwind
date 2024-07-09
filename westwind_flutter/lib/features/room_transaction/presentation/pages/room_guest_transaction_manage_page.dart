import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_edit_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_guest_transactions_widget.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_transaction_list_widget.dart';


class RoomGuestTransactionsManagePage extends StatelessWidget {

  final int? roomGuestId;

  static String route([int? roomGuestId]) =>
      "/roomguesttransactionsmanage/edit/${roomGuestId ?? ':id'}";



  const RoomGuestTransactionsManagePage({super.key, this.roomGuestId});

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title:  Text("Room Transaction ${roomGuestId ?? 0}"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
           context.push(RoomTransactionEditPage.routeNew());   
      },child: const Icon( Icons.add),),
      body: RoomGuestTransactionsWidget(roomGuestId: roomGuestId ?? 0 ),
      
     //const RoomTransactionListWidget(),
    );
    
  }
}

