import 'package:go_router/go_router.dart';
import 'package:westwind_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_detail_page.dart';
import 'package:westwind_flutter/features/guest/presentation/pages/guest_list_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: LoginPage.route(),
    routes: [
      GoRoute(
        path: LoginPage.route(),
        builder: (context, _) => const LoginPage(),
      ),
      GoRoute(
        path: GuestListPage.route(),
        builder: (context, _) => const GuestListPage(),
      ),
      GoRoute(
        path: GuestDetailPage.route(),
        builder: (context, state) => GuestDetailPage(
          guestId: int.parse(state.pathParameters['id'] ?? '0'),
        ),
      ),
    ],
  );
}
