import 'package:flutter/material.dart';



class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
      floatingActionButton: floatingActionButton(context),
      bottomNavigationBar: bottomNavigationBar(context),
    );


  }

  AppBar? appBar(BuildContext context) {
    return null;
  }

  Widget body(BuildContext context) {
    return SizedBox();
  }

  FloatingActionButton? floatingActionButton(BuildContext context) {
    return null;
  }

  BottomNavigationBar? bottomNavigationBar(BuildContext context) {
    return null;
  }
}