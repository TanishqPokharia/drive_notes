import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';

abstract class NoteRepository {
  Future<Either<Failure, String>> getNoteContent(String noteId);
  Future<Either<Failure, bool>> updateNote(String noteId, String content);
}
