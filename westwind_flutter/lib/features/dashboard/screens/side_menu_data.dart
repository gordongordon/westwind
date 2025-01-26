
import 'package:flutter/material.dart';
import 'package:westwind_flutter/features/dashboard/model/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Dashboard'),
    MenuModel(icon: Icons.person, title: 'Guests'),
    MenuModel(icon: Icons.app_registration_rounded, title: 'Reservtions'),
    MenuModel(icon: Icons.calendar_month, title: 'Calendar'),
    MenuModel(icon: Icons.bed_rounded, title: 'RoomGuests'),
    MenuModel(icon: Icons.payment, title: 'RoomTransactions'),
    MenuModel(icon: Icons.book_sharp, title: 'Booking'),
    MenuModel(icon: Icons.print, title: 'PDFs'),
    MenuModel(icon: Icons.history, title: 'History'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
