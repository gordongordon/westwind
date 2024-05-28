import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/utils/app_bloc_observer.dart';
import 'package:westwind_flutter/core/widgets/dashboard_testing.dart';
import 'package:westwind_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/core/router/app_router.dart';
import 'package:westwind_flutter/dependencies.dart';
import 'package:westwind_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:westwind_flutter/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serverLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serverLocator<GuestListBloc>()),
      BlocProvider(create: (_) => serverLocator<GuestDetailBloc>()),
      BlocProvider(
          create: (_) =>
              serverLocator<AuthBloc>()..add(AuthIsUserLoggedInEvent())),
      BlocProvider(create: (_) => serverLocator<GuestManageBloc>()),
      BlocProvider(create: (_) => serverLocator<RoomGuestManageBloc>()),
      BlocProvider(create: (_) => serverLocator<ReservationListBloc>()),
      BlocProvider(create: (_) => serverLocator<ReservationManageBloc>()),
      BlocProvider(create: (_) => serverLocator<RoomGuestListBloc>()),
      BlocProvider(create: (_) => serverLocator<RoomGuestManageBloc>()),
      BlocProvider(create: (_) => serverLocator<DashboardBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        AppRouter.router.refresh();
      },
      child: MaterialApp.router(
        title: "Westwind ServerPod",
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
