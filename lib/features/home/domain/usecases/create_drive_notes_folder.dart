import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';

class CreateDriveNotesFolder implements UseCase<bool, NoParams> {
  final HomeRepository repository;

  CreateDriveNotesFolder(this.repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.createDriveNotesFolder();
  }
}
