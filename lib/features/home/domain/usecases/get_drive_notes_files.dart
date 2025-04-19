import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';
import 'package:googleapis/drive/v3.dart';

class GetDriveNotesFiles implements UseCase<List<File>?, NoParams> {
  final HomeRepository repository;

  GetDriveNotesFiles(this.repository);
  @override
  Future<Either<Failure, List<File>?>> call(NoParams params) {
    return repository.getDriveNotesFiles();
  }
}
