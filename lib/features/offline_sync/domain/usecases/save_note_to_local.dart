import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';
import 'package:googleapis/drive/v3.dart';

class SaveNoteToLocal implements UseCase<void, SaveNoteToLocalParams> {
  final OfflineSyncRepository repository;

  SaveNoteToLocal(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveNoteToLocalParams params) async {
    return await repository.saveNoteToLocal(params.file);
  }
}

class SaveNoteToLocalParams {
  final File file;

  SaveNoteToLocalParams({required this.file});
}
