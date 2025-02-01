import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/register_confirmation_page.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:westwind_flutter/features/dashboard/screens/main_screen.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_detail_page.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_list_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/guest_reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_calendar_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_list_page.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_list.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_list_but_co.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_guest_transactions_manage_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_create_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_edit_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_list_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/pdf_edit.dart';

class AppRouter {
  static GoRouter router = GoRouter(
      initialLocation: LoginPage.route(),
      //  initialLocation: GuestListPage.route(),
      routes: [
        GoRoute(
          path: MainScreen.route(),
          builder: (context, _) => const MainScreen(),
        ),
        GoRoute(
          path: LoginPage.route(),
          builder: (context, _) => const LoginPage(),
        ),
        GoRoute(
          path: RegisterPage.route(),
          builder: (context, _) => const RegisterPage(),
        ),
        GoRoute(
          path: RegisterConfirmationPage.route(),
          builder: (context, _) => const RegisterConfirmationPage(),
        ),
        GoRoute(
          path: GuestListPage.route(),
          builder: (context, _) => const GuestListPage(),
        ),
        GoRoute(
          path: GuestEditPage.routeNew(),
          builder: (context, _) => GuestEditPage(),
        ),
        GoRoute(
          path: GuestEditPage.route(),
          builder: (context, state) => GuestEditPage(
            guestId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: GuestDetailPage.route(),
          builder: (context, state) => GuestDetailPage(
            guestId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: ReservationListPage.route(),
          builder: (context, _) => const ReservationListPage(),
        ),
        GoRoute(
          path: ReservationListPage.route(),
          builder: (context, _) => const ReservationCalendarPage(),
        ),
        GoRoute(
          path: ReservationEditPage.routeNew(),
          builder: (context, _) => ReservationEditPage(),
        ),
        GoRoute(
          path: ReservationEditPage.route(),
          builder: (context, state) => ReservationEditPage(
            reservationId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: RoomGuestListPage.route(),
          builder: (context, _) => const RoomGuestListPage(),
        ),
        GoRoute(
          path: RoomGuestListButCOPage.route(),
          builder: (context, _) => const RoomGuestListButCOPage(),
        ),
        GoRoute(
          path: RoomGuestEditPage.routeNew(),
          builder: (context, _) => RoomGuestEditPage(),
        ),
        GoRoute(
          path: RoomGuestEditPage.route(),
          builder: (context, state) => RoomGuestEditPage(
            roomGuestId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: RoomTransactionListPage.route(),
          builder: (context, _) => const RoomTransactionListPage(),
        ),
        GoRoute(
          path: RoomTransactionEditPage.routeNew(),
          builder: (context, _) => RoomTransactionEditPage(),
        ),
        GoRoute(
          path: RoomTransactionEditPage.route(),
          builder: (context, state) => RoomTransactionEditPage(
            roomTransactionId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: RoomTransactionCreatePage.route(),
          builder: (context, state) => RoomTransactionCreatePage(
            roomTransactionId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: RoomGuestTransactionsManagePage.route(),
          builder: (context, state) => RoomGuestTransactionsManagePage(
            roomGuestId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: GuestReservationEditPage.route(),
          builder: (context, state) => GuestReservationEditPage(
            guestId: int.parse(state.pathParameters['id'] ?? '0'),
            reservationId: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: GuestReservationEditPage.routeNew(),
          builder: (context, state) => GuestReservationEditPage(),
        ),
        GoRoute(
          path: PdfEditPage.routeNew(),
          builder: (context, state) => PdfEditPage(),
        ),
        GoRoute(
          path: PdfEditPage.route(),
          builder: (context, state) => PdfEditPage(
            roomGuestId: int.parse(state.pathParameters['id'] ?? '54'),
          ),
        ),
        GoRoute(
          path: GuestReservationEditPage.routeCalendar(),
          builder: (context, state) => GuestReservationEditPage(
            roomId: int.parse(state.pathParameters['roomId'] ?? '0'),
            date: DateTime.parse(state.pathParameters['date'] ??
                DateTime.now().getDateOnly().toString()),
          ),
        ),
      ],
      redirect: (context, state) {
        final userState = context.read<AppUserCubit>().state;

        final publicRoutes = [
          LoginPage.route(),
          RegisterPage.route(),
          RegisterConfirmationPage.route(),
        ];

        if (!publicRoutes.contains(state.matchedLocation)) {
          //GuestListPage.route();
          if (userState is AppUserInitial) {
            return LoginPage.route();
          }
        }

        return null;
      });
}
