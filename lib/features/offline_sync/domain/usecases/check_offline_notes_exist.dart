import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';

class CheckOfflineNotesExist implements UseCase<bool, NoParams> {
  final OfflineSyncRepository repository;

  CheckOfflineNotesExist(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.offlineNotesExist();
  }
}
