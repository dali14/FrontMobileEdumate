import 'core/network/network_info.dart';
import 'features/event/data/datasources/event_local_data_source.dart';
import 'features/event/data/datasources/event_remote_data_source.dart';
import 'features/event/data/repositories/event_repository_implement.dart';
import 'features/event/domain/repositories/event_repository.dart';
import 'features/event/domain/usecases/add_event.dart';
import 'features/event/domain/usecases/delete_event.dart';
import 'features/event/domain/usecases/get_all_events.dart';
import 'features/event/domain/usecases/update_event.dart';
import 'features/event/presentation/blocs/add_delete_update_event/add_delete_update_event_bloc.dart';
import 'features/event/presentation/blocs/events/event_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupEventDI() async {
//! Features - events

// Bloc

  sl.registerFactory(() => EventsBloc(getAllEvents: sl()));
  sl.registerFactory(() => AddDeleteUpdateEventBloc(
      addEvent: sl(), updateEvent: sl(), deleteEvent: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllEventUsecase(sl()));
  sl.registerLazySingleton(() => AddEventUsecase(sl()));
  sl.registerLazySingleton(() => DeleteEventUsecase(sl()));
  sl.registerLazySingleton(() => UpdateEventUsecase(sl()));

// Repository

  sl.registerLazySingleton<EventsRepository>(() => EventsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<EventRemoteDataSource>(
          () => EventRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<EventLocalDataSource>(
          () => EventLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
