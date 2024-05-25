import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';
import 'package:westwind_flutter/features/guest/presentation/widgets/guest_list_widget.dart';

class GuestListPage extends StatelessWidget {
  static String route() => "/guests";

  const GuestListPage({super.key});

  @override
  Widget build(BuildContext context) {
   //  final auth = serverLocator<Client>().modules.auth;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest"),
        actions: const [
            AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
           context.push(GuestEditPage.routeNew());   
      },child: const Icon( Icons.add),),
      body: const GuestListWidget(),
     // body: const GuestListPlutoWidget(),
    );
    
  }
}
