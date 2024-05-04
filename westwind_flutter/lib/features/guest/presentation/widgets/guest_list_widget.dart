import 'package:flutter/material.dart';

class GuestListWidgets extends StatefulWidget {
  const GuestListWidgets({super.key});

  @override
  State<GuestListWidgets> createState() => _GuestListWidgetsState();
}

class _GuestListWidgetsState extends State<GuestListWidgets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return const Card(
          child: ListTile(title: Text("Text")),
        );
      },
    );
  }
}
