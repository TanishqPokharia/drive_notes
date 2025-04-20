import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';

class CheckOfflineNotesExist
    implements UseCase<bool, CheckOfflineNotesExistParams> {
  final OfflineSyncRepository repository;

  CheckOfflineNotesExist(this.repository);

  @override
  Future<Either<Failure, bool>> call(
    CheckOfflineNotesExistParams params,
  ) async {
    return repository.offlineNotesExist(params.email);
  }
}

class CheckOfflineNotesExistParams {
  final String email;

  CheckOfflineNotesExistParams(this.email);
}
