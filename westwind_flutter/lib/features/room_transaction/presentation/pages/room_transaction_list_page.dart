import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_edit_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_transaction_list_widget.dart';


class RoomTransactionListPage extends StatelessWidget {
  static String route() => "/roomtransactions";

  const RoomTransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Transaction"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
           context.push(RoomTransactionEditPage.routeNew());   
      },child: const Icon( Icons.add),),
      body: 
      //! handle input roomGuestId 
     // const RoomGuestTransactionsWidget(roomGuestId: 1),
      
       const RoomTransactionListWidget(),
    );
    
  }
}

