import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';

class DeleteNote implements UseCase<bool, DeleteNoteParams> {
  final HomeRepository repository;

  DeleteNote(this.repository);
  @override
  Future<Either<Failure, bool>> call(DeleteNoteParams params) async {
    return repository.deleteNote(params.nodeId);
  }
}

class DeleteNoteParams {
  final String nodeId;

  DeleteNoteParams({required this.nodeId});
}
