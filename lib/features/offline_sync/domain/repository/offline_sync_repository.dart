import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:googleapis/drive/v3.dart';

abstract class OfflineSyncRepository {
  Future<Either<Failure, void>> syncNotes();
  Future<Either<Failure, bool>> offlineNotesExist();
  Future<Either<Failure, void>> saveNoteToLocal(File file);
  Future<Either<Failure, void>> deleteNoteFromLocal(File file);
  Future<Either<Failure, void>> updateNoteInLocal(File file, File newFile);
  Future<Either<Failure, List<File>>> getLocalFiles();
  Future<Either<Failure, void>> clearLocalFiles();
  Future<Either<Failure, void>> storeFiles(List<File> files);
}
