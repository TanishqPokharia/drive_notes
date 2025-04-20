import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';

class SyncDriveNotes implements UseCase<bool, SyncDriveNotesParams> {
  final OfflineSyncRepository repository;

  SyncDriveNotes(this.repository);

  @override
  Future<Either<Failure, bool>> call(SyncDriveNotesParams params) async {
    return await repository.syncNotes(params.email);
  }
}

class SyncDriveNotesParams extends NoParams {
  final String email;

  SyncDriveNotesParams(this.email);
}
