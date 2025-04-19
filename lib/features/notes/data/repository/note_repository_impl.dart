import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/notes/data/datasource/note_datasource.dart';
import 'package:drive_notes_app/features/notes/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDataSource datasource;

  NoteRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> getNoteContent(String noteId) async {
    final result = await datasource.getNoteContent(noteId);
    return result.fold((failure) => Left(failure), (content) => Right(content));
  }

  @override
  Future<Either<Failure, bool>> updateNote(
    String noteId,
    String content,
  ) async {
    final result = await datasource.updateNote(noteId, content);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
