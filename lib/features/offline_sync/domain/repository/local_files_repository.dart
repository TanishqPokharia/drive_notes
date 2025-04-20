import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:googleapis/drive/v3.dart';

abstract class LocalFilesRepository {
  Future<Either<Failure, void>> storeFiles(String email, List<File> files);
  Future<Either<Failure, void>> removeFile(String email, File file);
  Future<Either<Failure, List<File>>> getFiles(String email);
  Future<Either<Failure, void>> clearFiles(String email);
  Future<Either<Failure, void>> updateFile(
    String email,
    String fileId,
    String content,
  );
  Future<Either<Failure, void>> storeFile(String email, File file);
  Future<Either<Failure, String>> getFileContent(String email, String fileId);
  Future<Either<Failure, void>> initOfflineFileStorage(String email);
}
