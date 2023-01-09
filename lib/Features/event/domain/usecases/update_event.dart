

import 'dart:html';

import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class UpdateEventUsecase {
  final EventsRepository repository;

  UpdateEventUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Event event) async {
    return await repository.updateEvent(event);
  }
}