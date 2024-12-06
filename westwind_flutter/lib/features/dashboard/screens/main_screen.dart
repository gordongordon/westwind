import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:westwind_flutter/features/dashboard/util/responsive.dart';
import 'package:westwind_flutter/features/dashboard/widgets/dashboard_widget.dart';
import 'package:westwind_flutter/features/dashboard/widgets/side_menu_widget.dart';
import 'package:westwind_flutter/features/dashboard/widgets/summary_widget.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_list_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/guest_reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_calendar_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_list_page.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_list.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_list_page.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.grid_3x3),
    label: 'Category',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline),
    label: 'Favourite',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
];

const List<Widget> menuPages = <Widget>[
  DashboardWidget(),
  GuestListPage(),
  ReservationListPage(),
  ReservationCalendarPage(),
  RoomGuestListPage(),
  RoomTransactionListPage(),
  GuestReservationEditPage(),
];

class MainScreen extends StatelessWidget {
  static String route() => "/main";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        backgroundColor: Colors.white,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.blue,
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget(),
            )
          : null,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardStateLoaded) {
            //           context
            //      .read<DashboardBloc>()
            //      .add(DashboardMenuChange( menuIndex: state.menuIndex ));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Row(
              children: [
                if (isDesktop)
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: SideMenuWidget(),
                    ),
                  ),
                if (state is DashboardStateLoaded)
                  Expanded(
                    flex: 14,
                    child: menuPages.elementAt(state.menuIndex),
                  ),
                if (isDesktop)
                  Expanded(
                    flex: 3,
                    child: SummaryWidget(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
