import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';
import 'package:googleapis/drive/v3.dart';

class CreateNote implements UseCase<File, CreateNoteParams> {
  final HomeRepository repository;

  CreateNote(this.repository);
  @override
  Future<Either<Failure, File>> call(CreateNoteParams params) async {
    return repository.createNote(params.title);
  }
}

class CreateNoteParams {
  final String title;
  CreateNoteParams({required this.title});
}
