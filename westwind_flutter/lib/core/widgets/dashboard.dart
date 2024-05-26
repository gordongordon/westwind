import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_layout/pluto_layout.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_list_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_list_page.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_list.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

final layout = PlutoLayout(
  // This is a property that should be set by default. 
  // It is centered in the layout.
  body: PlutoLayoutContainer(
 //   child: Text('body container'),
    // child : GuestListPage(),
    child : ReservationListPage(),
  ),
  // This is an attribute that can be optionally added.
  left: PlutoLayoutContainer(
    child: PlutoLayoutTabs(
      // This property sets the size of the tab view.
      // If the size of the tab view is left or right, it means the width.
      // In the case of top and bottom, it means the height.
      // In this example code, the left property is set, 
      // so the size means the width.
      tabViewSizeResolver: PlutoLayoutTabViewSizeConstrains(
        minSize: 100,
        maxSize: 500,
        initialSize: 300,
      ),
      items: [
        PlutoLayoutTabItem(
          id: 'Files',
          title: 'Files',
          icon: Icon(Icons.file_present),
          // This property sets the size of each tab view.
          // If the size of each tab view is left or right, it means the height.
          // In the case of top and bottom, it means the width.
          // In this example code, the left property is set, 
          // so size means height.
          sizeResolver: PlutoLayoutTabItemSizeFlexible(0.3),
          // This is a callback function that returns a widget 
          // that is displayed when the tab menu button is tapped.
          tabViewWidget: Text('Files tab view'),
        ),
        PlutoLayoutTabItem(
          id: 'Users',
          title: 'Users',
          icon: Icon(Icons.account_box),
          sizeResolver: PlutoLayoutTabItemSizeFlexible(0.7),
          tabViewWidget: Text('Users tab view'),
        ),
      ],
    ),
  ),
  bottom: PlutoLayoutContainer(
          child: PlutoLayoutTabs(
            items: [
              PlutoLayoutTabItem(
                id: 'bottom1',
                title: 'bottom1',
                tabViewWidget: const Text('bottom1'),
              ),
              PlutoLayoutTabItem(
                id: 'bottom2',
                title: 'bottom2',
                tabViewWidget: const Text('bottom2'),
              ),
            ],
          ),),
);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout,
    );
  }
}