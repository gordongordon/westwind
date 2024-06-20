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
import 'package:westwind_flutter/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:westwind_flutter/features/guest/data/datasources/guest_datasource.dart';
import 'package:westwind_flutter/features/guest/data/repositories/guest_repository_imp.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/delete_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/list_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_by_phone_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/save_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';
import 'package:westwind_flutter/features/rate_table/data/datasources/rate_table_datasource.dart';
import 'package:westwind_flutter/features/rate_table/data/repositories/rate_table_repository_imp.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/rate_table/domain/usecases/get_rate_usecase.dart';
import 'package:westwind_flutter/features/reservation/data/datasources/reservation_datasource.dart';
import 'package:westwind_flutter/features/reservation/data/repositories/reservation_repository_imp.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/checkIn_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/delete_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/list_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/retrieve_reservation.dart';
import 'package:westwind_flutter/features/reservation/domain/usecases/save_reservation.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';
import 'package:westwind_flutter/features/room_guest/data/datasources/room_guest_datasource.dart';
import 'package:westwind_flutter/features/room_guest/data/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/calculate_rate_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/check_in_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/delete_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/list_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/retrieve_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/save_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/data/datasources/room_transaction_datasource.dart';
import 'package:westwind_flutter/features/room_transaction/data/repositories/room_transaction_repository_imp.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_Transaction_list_usercase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_create_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_delete_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_retrieve_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_list_bloc.dart';

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

  _initReservation();

  _initRateTable();

  _initRoomGuest();

  _initDashboard();

  _initRoomTransaction();
}

void _initRoomTransaction() {
  // DataSource
  serverLocator.registerLazySingleton<RoomTransactionDatasource>(
    () => RoomTransactionDatasourceImpl(
      serverLocator<Client>(),
    ),
  );

  // Repositories
  serverLocator.registerLazySingleton<RoomTransactionRepository>(
    () => RoomTransactionRepositoryImp(
      serverLocator<RoomTransactionDatasource>(),
    ),
  );

  // Use Case
  serverLocator.registerLazySingleton<ListRoomTransactionsUseCase>(
    () => ListRoomTransactionsUseCase(
      serverLocator<RoomTransactionRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<DeleteRoomTransactionUseCase>(
    () => DeleteRoomTransactionUseCase(
      serverLocator<RoomTransactionRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<RetrieveRoomTransactionUseCase>(
    () => RetrieveRoomTransactionUseCase(
      serverLocator<RoomTransactionRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<CreateRoomTransactionUseCase>(
    () => CreateRoomTransactionUseCase(
      serverLocator<RoomTransactionRepository>(),
    ),
  );

  // bloc
  serverLocator.registerFactory<RoomTransactionListBloc>(
    () => RoomTransactionListBloc(
      listRoomTransactions: serverLocator<ListRoomTransactionsUseCase>(),
      deleteRoomTransaction: serverLocator<DeleteRoomTransactionUseCase>(),
      retrieveRoomTransaction: serverLocator<RetrieveRoomTransactionUseCase>(),
      createRoomTransaction: serverLocator<CreateRoomTransactionUseCase>(),
    ),
  );
}

void _initDashboard() {
  // Bloc
  serverLocator.registerFactory<DashboardBloc>(
    () => DashboardBloc(),
  );
}

void _initRateTable() {
  // DataSource
  serverLocator.registerLazySingleton<RateTableDatasource>(
    () => RateTableDatasourceImpl(
      serverLocator<Client>(),
    ),
  );

  // Repositories
  serverLocator.registerLazySingleton<RateTableRepository>(
    () => RateTableRepositoryImpl(
      serverLocator<RateTableDatasource>(),
    ),
  );

  // Use Case
  serverLocator.registerLazySingleton<RateTableGetRateUseCase>(
    () => RateTableGetRateUseCase(
      serverLocator<RateTableRepository>(),
    ),
  );
}

void _initAuth() {
  // DataSource
  serverLocator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      serverLocator<Client>(),
      serverLocator<SessionManager>(),
    ),
  );

  // Repositories
  serverLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      serverLocator<AuthDataSource>(),
    ),
  );

  // Use Case
  serverLocator.registerLazySingleton<CurrentUserUseCase>(
    () => CurrentUserUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<UserLoginUseCase>(
    () => UserLoginUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<UserLogoutUseCase>(
    () => UserLogoutUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<UserRegisterUseCase>(
    () => UserRegisterUseCase(
      serverLocator<AuthRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<UserConfirmRegistrationUseCase>(
    () => UserConfirmRegistrationUseCase(
      serverLocator<AuthRepository>(),
    ),
  );

  // Bloc
  serverLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      appUserCubit: serverLocator<AppUserCubit>(),
      currentUser: serverLocator<CurrentUserUseCase>(),
      userLogin: serverLocator<UserLoginUseCase>(),
      userLogout: serverLocator<UserLogoutUseCase>(),
      userRegister: serverLocator<UserRegisterUseCase>(),
      userConfirmRegistration: serverLocator<UserConfirmRegistrationUseCase>(),
    ),
  );
}

void _initGuest() {
  // Data Source
  serverLocator.registerLazySingleton<GuestDatasource>(
    () => GuestDatasourceImpl(
      serverLocator<Client>(),
    ),
  );

  // Repository
  serverLocator.registerLazySingleton<GuestRepository>(
    () => GuestRepositoryImp(
      serverLocator<GuestDatasource>(),
    ),
  );

  // Use Cases
  //! register as Singleton base on Reso coder, for cacheing .
  serverLocator.registerLazySingleton<ListGuestsUseCase>(
    () => ListGuestsUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<DeleteGuestUseCase>(
    () => DeleteGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<RetrieveGuestUseCase>(
    () => RetrieveGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<SaveGuestUseCase>(
    () => SaveGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<RetrieveGuestByPhoneUseCase>(
    () => RetrieveGuestByPhoneUseCase(
      serverLocator<GuestRepository>(),
    ),
  );

  // Blocs
  //! May be register as Factory base on Reso Coder for all bloc, because of Close stream issum after user come back to the page.
  serverLocator.registerFactory(
    () => GuestListBloc(
      listGuests: serverLocator<ListGuestsUseCase>(),
      deleteGuest: serverLocator<DeleteGuestUseCase>(),
    ),
  );

  serverLocator.registerFactory(
    () => GuestManageBloc(
      deleteGuest: serverLocator<DeleteGuestUseCase>(),
      retrieveGuest: serverLocator<RetrieveGuestUseCase>(),
      saveGuest: serverLocator<SaveGuestUseCase>(),
      retrieveGuestByPhone: serverLocator<RetrieveGuestByPhoneUseCase>(),
    ),
  );

  serverLocator.registerFactory(
    () => GuestDetailBloc(
      retrieveGuest: serverLocator<RetrieveGuestUseCase>(),
    ),
  );
}

void _initReservation() {
  // Data Source
  serverLocator.registerLazySingleton<ReservationDatasource>(
    () => ReservationDatasourceImp(
      serverLocator<Client>(),
    ),
  );

  // Repository
  serverLocator.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImp(
      serverLocator<ReservationDatasource>(),
    ),
  );

  // Use Cases
  //! register as Singleton base on Reso coder, for cacheing .
  serverLocator.registerLazySingleton<ListReservationUseCase>(
    () => ListReservationUseCase(
      serverLocator<ReservationRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<RetrieveReservationUseCase>(
    () => RetrieveReservationUseCase(
      serverLocator<ReservationRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<SaveReservationUseCase>(
    () => SaveReservationUseCase(
      serverLocator<ReservationRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<DeleteReservationUseCase>(
    () => DeleteReservationUseCase(
      serverLocator<ReservationRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<CheckInReservationUseCase>(
    () => CheckInReservationUseCase(
      serverLocator<ReservationRepository>(),
    ),
  );

/*
  serverLocator.registerLazySingleton<RetrieveGuestUseCase>(
    () => RetrieveGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
*/
  // Bloc
  serverLocator.registerFactory<ReservationListBloc>(() => ReservationListBloc(
        listReservations: serverLocator<ListReservationUseCase>(),
      ));

  serverLocator
      .registerFactory<ReservationManageBloc>(() => ReservationManageBloc(
            retrieveReservation: serverLocator<RetrieveReservationUseCase>(),
            saveReservation: serverLocator<SaveReservationUseCase>(),
            deleteReservation: serverLocator<DeleteReservationUseCase>(),
            retrieveGuest: serverLocator<RetrieveGuestUseCase>(),
            retrieveGuestByPhone: serverLocator<RetrieveGuestByPhoneUseCase>(),
            checkInReservation: serverLocator<CheckInReservationUseCase>(),
            getRate: serverLocator<RateTableGetRateUseCase>(),
          ));
}

void _initRoomGuest() {
  // DataSource
  serverLocator.registerLazySingleton<RoomGuestDatasource>(
    () => RoomGuestDatasourceImpl(
      serverLocator<Client>(),
    ),
  );

  // Repositories
  serverLocator.registerLazySingleton<RoomGuestRepository>(
    () => RoomGuestRepositoryImpl(
      serverLocator<RoomGuestDatasource>(),
    ),
  );

  // Use Case
  serverLocator.registerLazySingleton<CheckInRoomGuestUseCase>(
    () => CheckInRoomGuestUseCase(
      serverLocator<RoomGuestRepository>(),
      serverLocator<RateTableRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<DeleteRoomGuestUseCase>(
    () => DeleteRoomGuestUseCase(
      serverLocator<RoomGuestRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<ListRoomGuestUseCase>(
    () => ListRoomGuestUseCase(
      serverLocator<RoomGuestRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<RetrieveRoomGuestUseCase>(
    () => RetrieveRoomGuestUseCase(
      serverLocator<RoomGuestRepository>(),
    ),
  );

  serverLocator.registerLazySingleton<SaveRoomGuestUseCase>(
    () => SaveRoomGuestUseCase(
      serverLocator<RoomGuestRepository>(),
    ),
  );
  serverLocator.registerLazySingleton<CalculateRateRoomGuestUseCase>(
    () => CalculateRateRoomGuestUseCase(
      serverLocator<RoomGuestRepository>(),
      serverLocator<RateTableRepository>(),
    ),
  );

  // Bloc
  serverLocator.registerFactory<RoomGuestListBloc>(() => RoomGuestListBloc(
        listRoomGuests: serverLocator<ListRoomGuestUseCase>(),
      ));

  serverLocator.registerFactory<RoomGuestManageBloc>(() => RoomGuestManageBloc(
        deleteRoomGuest: serverLocator<DeleteRoomGuestUseCase>(),
        retrieveRoomGuest: serverLocator<RetrieveRoomGuestUseCase>(),
        //     saveRoomGuest: serverLocator<SaveRoomGuestUseCase>(),

        //       retrieveGuest: serverLocator<RetrieveRoomGuestUseCase>(),
        checkInRoomGuest: serverLocator<CheckInRoomGuestUseCase>(),
        calculateRateRoomGuest: serverLocator<CalculateRateRoomGuestUseCase>(),
      ));
}

// class CalcullateRateRoomGuestUseCase {}
