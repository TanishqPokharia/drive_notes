import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';

class UpdateNoteInLocal implements UseCase<void, UpdateNoteInLocalParams> {
  final OfflineSyncRepository repository;

  UpdateNoteInLocal(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateNoteInLocalParams params) {
    return repository.updateNoteInLocal(
      params.email,
      params.fileId,
      params.content,
    );
  }
}

class UpdateNoteInLocalParams {
  final String fileId;
  final String content;
  final String email;
  UpdateNoteInLocalParams(this.email, this.fileId, this.content);
}
