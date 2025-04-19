import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalFilesDataSource {
  Future<Either<Failure, void>> storeList(List<String> fileData);
  Future<Either<Failure, void>> removeFile(String fileId);
  Future<Either<Failure, List<String>>> getFiles();
  Future<Either<Failure, void>> clearFiles();
  Future<Either<Failure, void>> updateFile(String fileId, String newFileId);
}

class SharedPreferencesStorageFilesDataSourceImpl
    implements LocalFilesDataSource {
  SharedPreferencesStorageFilesDataSourceImpl();
  @override
  Future<Either<Failure, void>> clearFiles() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final deleted = await sp.remove('offline_files');
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
  Future<Either<Failure, List<String>>> getFiles() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final files = sp.getStringList('offline_files');
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
  Future<Either<Failure, void>> removeFile(String fileId) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final files = sp.getStringList('offline_files');
      if (files != null) {
        files.remove(fileId);
        final updated = await sp.setStringList('offline_files', files);
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
  Future<Either<Failure, void>> storeList(List<String> fileData) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final stored = await sp.setStringList('offline_files', fileData);
      if (stored) {
        return const Right(());
      } else {
        return Left(Failure('Failed to store files'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFile(
    String fileId,
    String newFileId,
  ) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final files = sp.getStringList('offline_files');
      if (files != null) {
        files[files.indexOf(fileId)] = newFileId;
        final updated = await sp.setStringList('offline_files', files);
        if (updated) {
          return const Right(());
        } else {
          return Left(Failure('Failed to update file'));
        }
      } else {
        return const Right(());
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
