import 'package:get_it/get_it.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/guest/data/datasources/guest_datasource.dart';
import 'package:westwind_flutter/features/guest/data/repositories/guest_repository_imp.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/list_guest.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_retreive/guest_retrieve_bloc.dart';

final serverLocator = GetIt.instance;

Future<void> initDependencies() async {
  serverLocator.registerLazySingleton<Client>(
    () => Client("http://localhost:8080/")
      ..connectivityMonitor = FlutterConnectivityMonitor(),
  );

  _initGuest();
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
  serverLocator.registerFactory<ListGuestsUseCase>(
    () => ListGuestsUseCase(
      serverLocator<GuestRepository>(),
    ),
  );
    serverLocator.registerFactory<RetrieveGuestUseCase>(
    () => RetrieveGuestUseCase(
      serverLocator<GuestRepository>(),
    ),
  );

  // Blocs
  serverLocator.registerLazySingleton(
    () => GuestListBloc(
      listGuests: serverLocator<ListGuestsUseCase>(),
    ),
  );

    serverLocator.registerLazySingleton(
    () => GuestRetrieveBloc(
      retrieveGuest: serverLocator<RetrieveGuestUseCase>(),
    ),
  );

  
}
