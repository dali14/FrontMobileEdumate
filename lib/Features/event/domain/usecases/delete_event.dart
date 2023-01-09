

import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../repositories/event_repository.dart';

class DeleteEventUsecase {
  final EventsRepository repository;

  DeleteEventUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int eventId) async {
    return await repository.deleteEvent(eventId);
  }
}
