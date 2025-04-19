import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';
import 'package:googleapis/drive/v3.dart';

class GetLocalNotes implements UseCase<List<File>, NoParams> {
  final OfflineSyncRepository repository;

  GetLocalNotes(this.repository);
  @override
  Future<Either<Failure, List<File>>> call(NoParams params) async {
    return repository.getLocalFiles();
  }
}
