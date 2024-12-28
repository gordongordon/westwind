import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_guest_transactions_manage_widget.dart';


class RoomGuestTransactionsManagePage extends StatefulWidget {

  final int? roomGuestId;

  static String route([int? roomGuestId]) =>
      "/roomguesttransactionsmanage/edit/${roomGuestId ?? ':id'}";


  const RoomGuestTransactionsManagePage({super.key, this.roomGuestId});

  @override
  State<RoomGuestTransactionsManagePage > createState() => _RoomGuestTransactionsManagePage();

}

class _RoomGuestTransactionsManagePage extends State<RoomGuestTransactionsManagePage> {
   
  late String firstName;
  late String lastName; 
  late int roomNumber;

  @override
  void initState() {
    super.initState();
    firstName = "Gordon";
    lastName = "Wong";
    roomNumber = 0;
    if (widget.roomGuestId != null) {
      context.read<RoomGuestManageBloc>().add(
        RetrieveRoomGuest( widget.roomGuestId! ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title:  Text("Room Transaction - $firstName $lastName - Room # ${roomNumber.toString}"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
  //    floatingActionButton: FloatingActionButton(onPressed: () {
  //         context.push(RoomTransactionEditPage.routeNew());   
  //    },child: const Icon( Icons.add),),

    //  body: RoomGuestTransactionsManageWidget(roomGuestId: widget.roomGuestId ?? 0 ),
      
      body: BlocConsumer<RoomGuestManageBloc, RoomGuestManageState>(
        listener: _blocListener,
        builder: (context, state) {
          return RoomGuestTransactionsManageWidget(roomGuestId: widget.roomGuestId ?? 0 );
        },
      ),


     //const RoomTransactionListWidget(),
    );
    
  }

  void _blocListener(BuildContext context, RoomGuestManageState state) {
    if (state is RoomGuestManageStateFailure) {
      showSnackbar(context, state.message );
    } if (state is RoomGuestManageStateRetrieveSuccess) {
      setState(() {
         firstName = state.roomGuest.guest!.firstName;
         lastName = state.roomGuest.guest!.lastName;
         roomNumber = state.roomGuest.roomId;
      });
    }
  }
}

