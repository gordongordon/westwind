import 'package:flutter/material.dart';
import 'package:westwind_flutter/features/guest/presentation/widgets/guest_list_widget.dart';

class GuestListPage extends StatelessWidget {
  static String route() => "/guests";

  const GuestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest"),

      ),
      body: const GuestListWidgets(),
    );
  }
}
