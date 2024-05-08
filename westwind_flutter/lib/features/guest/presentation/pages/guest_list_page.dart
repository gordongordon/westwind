import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';

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
      body: const GuestListWidgets(),
    );
    
  }
}
