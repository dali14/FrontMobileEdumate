import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:integration_project_version2/Features/event/domain/entities/event.dart';

import '../../../../Core/error/failures.dart';
import '../repositories/event_repository.dart';

class GetAllEventUsecase {
  final EventsRepository repository;

  GetAllEventUsecase(this.repository);

  Future<Either<Failure, List<Event>>> call() async {
    return await repository.getAllEvents();
  }
}