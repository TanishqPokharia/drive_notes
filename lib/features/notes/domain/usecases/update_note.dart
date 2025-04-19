import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/features/notes/domain/repository/note_repository.dart';

class UpdateNote implements UseCase<bool, UpdateNoteParams> {
  final NoteRepository repository;

  UpdateNote(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateNoteParams params) {
    return repository.updateNote(params.noteId, params.content);
  }
}

class UpdateNoteParams {
  final String noteId;
  final String content;

  UpdateNoteParams({required this.noteId, required this.content});
}
