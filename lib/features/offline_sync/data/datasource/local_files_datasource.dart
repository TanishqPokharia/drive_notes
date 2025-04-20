import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalFilesDataSource {
  Future<Either<Failure, void>> storeList(String email, List<String> fileData);
  Future<Either<Failure, void>> removeFile(String email, String fileId);
  Future<Either<Failure, List<String>>> getFiles(String email);
  Future<Either<Failure, void>> clearFiles(String email);
}

class SharedPreferencesStorageFilesDataSourceImpl
    implements LocalFilesDataSource {
  SharedPreferencesStorageFilesDataSourceImpl();
  @override
  Future<Either<Failure, void>> clearFiles(String email) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final deleted = await sp.setStringList(email, []);
      if (deleted) {
        return const Right(());
      } else {
        return Left(Failure('Failed to clear files'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFiles(String email) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final files = sp.getStringList(email);
      if (files != null) {
        return Right(files);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFile(String email, String fileId) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final files = sp.getStringList(email);
      if (files != null) {
        files.remove(fileId);
        final updated = await sp.setStringList(email, files);
        if (updated) {
          return const Right(());
        } else {
          return Left(Failure('Failed to remove file'));
        }
      } else {
        return const Right(());
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storeList(
    String email,
    List<String> fileData,
  ) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final stored = await sp.setStringList(email, fileData);
      if (stored) {
        return const Right(());
      } else {
        return Left(Failure('Failed to store files'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
