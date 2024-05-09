import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/core/router/app_router.dart';
import 'package:westwind_flutter/dependencies.dart';
import 'package:westwind_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serverLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serverLocator<GuestListBloc>()),
        BlocProvider(create: (_) => serverLocator<GuestDetailBloc>()),
        BlocProvider(
            create: (_) =>
                serverLocator<AuthBloc>()..add(AuthIsUserLoggedInEvent())),
        BlocProvider(create: (_) => serverLocator<GuestManageBloc>()),
      ],
      child: const MyApp(),
    ),
  );
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
