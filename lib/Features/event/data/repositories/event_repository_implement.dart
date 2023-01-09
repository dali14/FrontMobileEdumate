

import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../../../../Core/network/network_info.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_local_data_source.dart';
import '../datasources/event_remote_data_source.dart';
import '../models/Event_model.dart';
import '../../../../core/error/exeptions.dart';

typedef Future<Unit> DeleteOrUpdateOrAddEvent();

class EventsRepositoryImpl implements EventsRepository {
  final EventRemoteDataSource remoteDataSource;
  final EventLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EventsRepositoryImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.networkInfo});

  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEvents = await remoteDataSource.getAllEvents();

        localDataSource.cacheEvents(remoteEvents);
        return Right(remoteEvents);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localEvents = await localDataSource.getCachedEvents();
        return Right(localEvents);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addEvent(Event event) async {
    final EventModel eventModel = EventModel(name: event.name,date: event.date, duration: event.duration , category: event.category, description: event.description, id: null);

    return await _getMessage(() {
      return remoteDataSource.addEvent(eventModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent(int eventId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteEvent(eventId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateEvent(Event event) async {
    final EventModel eventModel =
    EventModel(name: event.name,date: event.date, duration: event.duration , category: event.category, description: event.description, id: null);

    return await _getMessage(() {
      return remoteDataSource.updateEvent(eventModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddEvent deleteOrUpdateOrAddEvent) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddEvent();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

