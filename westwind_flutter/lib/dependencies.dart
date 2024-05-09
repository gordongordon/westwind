import 'package:get_it/get_it.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/features/auth/data/datasources/auth_datasource.dart';
import 'package:westwind_flutter/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:westwind_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/current_user.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_confirm_registration.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_logout.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_register.dart';
import 'package:westwind_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:westwind_flutter/features/guest/data/datasources/guest_datasource.dart';
import 'package:westwind_flutter/features/guest/data/repositories/guest_repository_imp.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/delete_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/list_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

final serverLocator = GetIt.instance;

Future<void> initDependencies() async {

  serverLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );

  serverLocator.registerLazySingleton<Client>(
    () => Client(
      "http://localhost:8080/",
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor(),
  );

  serverLocator.registerLazySingleton<SessionManager>(
    () => SessionManager(
      caller: serverLocator<Client>().modules.auth,
    ),
  );

  await serverLocator<SessionManager>().initialize();

  _initAuth();

  _initGuest();
}

void _initAuth() {
  // DataSource
  serverLocator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(
      serverLocator<Client>(),
      serverLocator<SessionManager>(),
    ),
  );

  // Repositories
  serverLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      serverLocator<AuthDataSource>(),
    ),
  );

  // Use Case
  serverLocator.registerFactory<CurrentUserUseCase>(
    () => CurrentUserUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
  serverLocator.registerFactory<UserLoginUseCase>(
    () => UserLoginUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
  serverLocator.registerFactory<UserLogoutUseCase>(
    () => UserLogoutUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
    serverLocator.registerFactory<UserRegisterUseCase>(
    () => UserRegisterUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
    serverLocator.registerFactory<UserConfirmRegistrationUseCase>(
    () => UserConfirmRegistrationUseCase(
      serverLocator<AuthRepository>(),
    ),
  );

  // Bloc
  serverLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      appUserCubit: serverLocator<AppUserCubit>(),
      currentUser: serverLocator<CurrentUserUseCase>(),
      userLogin: serverLocator<UserLoginUseCase>(),
      userLogout:  serverLocator<UserLogoutUseCase>(),
      userRegister: serverLocator<UserRegisterUseCase>(),
      userConfirmRegistration: serverLocator<UserConfirmRegistrationUseCase>(),
    ),
  );
}

void _initGuest() {
  // Data Source
  serverLocator.registerFactory<GuestDatasource>(
    () => GuestDatasourceImpl(
      serverLocator<Client>(),
    ),
  );

  // Repository
  serverLocator.registerFactory<GuestRepository>(
    () => GuestRepositoryImp(
      serverLocator<GuestDatasource>(),
    ),
  );

  // Use Cases
  //! register as Singleton base on Reso coder, for cacheing .
  serverLocator.registerFactory<ListGuestsUseCase>(
    () => ListGuestsUseCase(
      serverLocator<GuestRepository>(),
    ),
  );

  serverLocator.registerFactory<DeleteGuestUseCase>(
    () => DeleteGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
  serverLocator.registerFactory<RetrieveGuestUseCase>(
    () => RetrieveGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );

  // Blocs
  //! May be register as Factory base on Reso Coder for all bloc, because of Close stream issum after user come back to the page.
  serverLocator.registerLazySingleton(
    () => GuestListBloc(
      listGuests: serverLocator<ListGuestsUseCase>(),
      deleteGuest: serverLocator<DeleteGuestUseCase>(),
    ),
  );

  serverLocator.registerLazySingleton(
    () => GuestDetailBloc(
      retrieveGuest: serverLocator<RetrieveGuestUseCase>(),
    ),
  );
}
