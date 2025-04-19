import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';
import 'package:googleapis/drive/v3.dart';

class DeleteNoteFromLocal implements UseCase<void, DeleteNoteFromLocalParams> {
  final OfflineSyncRepository repository;

  DeleteNoteFromLocal(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteNoteFromLocalParams params) async {
    return await repository.deleteNoteFromLocal(params.file);
  }
}

class DeleteNoteFromLocalParams {
  final File file;

  DeleteNoteFromLocalParams(this.file);
}
