import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/home/data/datasource/home_datasource.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';
import 'package:googleapis/drive/v3.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<File>?>> getDriveNotesFiles() async {
    final driveNotesFolderId = await dataSource.getDriveNotesFolderId();
    return await driveNotesFolderId.fold((failure) => Left(failure), (
      id,
    ) async {
      if (id == null) return Left(Failure("Drive Notes folder does not exist"));
      final files = await dataSource.getDriveNotesFiles(id);
      return files.fold((failure) => Left(failure), (files) => Right(files));
    });
  }

  @override
  Future<Either<Failure, bool>> deleteNote(String noteId) async {
    final result = await dataSource.deleteNote(noteId);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, File>> createNote(String title) async {
    final folderId = await dataSource.getDriveNotesFolderId();
    return await folderId.fold((failure) => Left(failure), (id) async {
      if (id == null) return Left(Failure("Drive Notes folder does not exist"));
      final result = await dataSource.createNote(title, id);
      return result.fold(
        (failure) => Left(failure),
        (success) => Right(success),
      );
    });
  }

  @override
  Future<Either<Failure, bool>> createDriveNotesFolder() {
    return dataSource.createDriveNotesFolder();
  }
}
