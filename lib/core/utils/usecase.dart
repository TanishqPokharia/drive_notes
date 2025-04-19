import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';

abstract interface class UseCase<ReturnValue, Parameter> {
  Future<Either<Failure, ReturnValue>> call(Parameter params);
}
