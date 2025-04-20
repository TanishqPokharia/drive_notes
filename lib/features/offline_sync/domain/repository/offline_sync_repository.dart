import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:googleapis/drive/v3.dart';

abstract class OfflineSyncRepository {
  Future<Either<Failure, bool>> syncNotes(String email);
  Future<Either<Failure, bool>> offlineNotesExist(String email);
  Future<Either<Failure, void>> saveNoteToLocal(String email, File file);
  Future<Either<Failure, void>> deleteNoteFromLocal(String email, File file);
  Future<Either<Failure, void>> updateNoteInLocal(
    String email,
    String fileId,
    String content,
  );
  Future<Either<Failure, List<File>>> getLocalFiles(String email);
  Future<Either<Failure, void>> clearLocalFiles(String email);
  Future<Either<Failure, void>> storeFiles(String email, List<File> files);
}
