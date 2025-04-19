import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:googleapis/drive/v3.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<File>?>> getDriveNotesFiles();
  Future<Either<Failure, File>> createNote(String title);
  Future<Either<Failure, bool>> deleteNote(String noteId);
  Future<Either<Failure, bool>> createDriveNotesFolder();
}
