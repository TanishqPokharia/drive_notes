import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:googleapis/drive/v3.dart';

abstract class LocalFilesRepository {
  Future<Either<Failure, void>> storeFiles(List<File> files);
  Future<Either<Failure, void>> removeFile(File file);
  Future<Either<Failure, List<File>>> getFiles();
  Future<Either<Failure, void>> clearFiles();
  Future<Either<Failure, void>> updateFile(File file, File newFile);
}
