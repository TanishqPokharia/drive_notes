import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/notes/domain/repository/note_repository.dart';

class GetNoteContent implements UseCase<String, GetNoteContentParams> {
  final NoteRepository repository;

  GetNoteContent(this.repository);
  @override
  Future<Either<Failure, String>> call(GetNoteContentParams params) {
    return repository.getNoteContent(params.noteId);
  }
}

class GetNoteContentParams {
  final String noteId;

  GetNoteContentParams({required this.noteId});
}
