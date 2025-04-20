import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/local_files_repository.dart';

class GetOfflineFileContent
    implements UseCase<String, GetOfflineFileContentParams> {
  final LocalFilesRepository repository;

  GetOfflineFileContent(this.repository);

  @override
  Future<Either<Failure, String>> call(GetOfflineFileContentParams params) {
    return repository.getFileContent(params.email, params.fileId);
  }
}

class GetOfflineFileContentParams {
  final String email;
  final String fileId;

  GetOfflineFileContentParams(this.email, this.fileId);
}
