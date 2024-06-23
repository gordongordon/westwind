import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/register_confirmation_page.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:westwind_flutter/features/dashboard/screens/main_screen.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_detail_page.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_edit_page.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_list_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_edit_page.dart';
import 'package:westwind_flutter/features/reservation/presentaion/pages/reservation_list_page.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_edit.dart';
import 'package:westwind_flutter/features/room_guest/presentation/pages/room_guest_list.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_edit_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pages/room_transaction_list_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
      initialLocation: LoginPage.route(),
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
          builder: (context, state) => RoomTransactionListPage(),
        ),
        GoRoute(
          path: RoomTransactionEditPage.routeNew(),
          builder: (context, state) => RoomTransactionEditPage(
                    roomTransactionId: int.parse(state.pathParameters['id'] ?? '0'),
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
          if (userState is AppUserInitial) {
            return LoginPage.route();
          }
        }

        return null;
      });
}
