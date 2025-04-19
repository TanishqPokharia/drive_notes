import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';
import 'package:googleapis/drive/v3.dart';

class UpdateNoteInLocal implements UseCase<void, UpdateNoteInLocalParams> {
  final OfflineSyncRepository repository;

  UpdateNoteInLocal(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateNoteInLocalParams params) {
    return repository.updateNoteInLocal(params.file, params.newFile);
  }
}

class UpdateNoteInLocalParams {
  final File file;
  final File newFile;

  UpdateNoteInLocalParams(this.file, this.newFile);
}
