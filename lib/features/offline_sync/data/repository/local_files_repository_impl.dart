import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/offline_sync/data/datasource/local_files_datasource.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/local_files_repository.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFilesRepositoryImpl implements LocalFilesRepository {
  final LocalFilesDataSource dataSource;

  LocalFilesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> clearFiles(String email) async {
    return dataSource.clearFiles(email);
  }

  @override
  Future<Either<Failure, List<File>>> getFiles(String email) async {
    final result = await dataSource.getFiles(email);
    return result.fold((failure) => Left(failure), (files) {
      if (files.isNotEmpty) {
        final fileModels =
            files
                .map((file) => ContentFile.fromJson(jsonDecode(file)))
                .toList();
        return Right(fileModels);
      } else {
        return const Right([]);
      }
    });
  }

  @override
  Future<Either<Failure, void>> removeFile(String email, File file) async {
    final result = await dataSource.getFiles(email);
    return result.fold((failure) => Left(failure), (success) {
      final fileList =
          success
              .map((file) => ContentFile.fromJson(jsonDecode(file)))
              .toList();
      fileList.removeWhere(
        (element) => element.fileName == (file as ContentFile).fileName,
      );
      final newListToStore =
          fileList.map((file) => jsonEncode(file.toJson())).toList();
      return dataSource.storeList(email, newListToStore);
    });
  }

  @override
  Future<Either<Failure, void>> storeFiles(
    String email,
    List<File> fileData,
  ) async {
    final result = await dataSource.storeList(
      email,
      fileData.map((file) => jsonEncode(file.toJson())).toList(),
    );
    return result.fold(
      (failure) => Left(failure),
      (success) => const Right(()),
    );
  }

  @override
  Future<Either<Failure, void>> updateFile(
    String email,
    String fileId,
    String content,
  ) async {
    final result = await dataSource.getFiles(email);
    return result.fold((failure) => Left(failure), (files) {
      final contentFileList =
          files.map((file) => ContentFile.fromJson(jsonDecode(file))).toList();
      final fileToUpdate = contentFileList.firstWhere(
        (element) => element.fileName == fileId,
      );
      final newFile = fileToUpdate.copyWith(
        fileName: fileToUpdate.fileName,
        content: content,
      );
      contentFileList[contentFileList.indexOf(fileToUpdate)] = newFile;
      final newListToStore =
          contentFileList.map((file) => jsonEncode(file.toJson())).toList();
      return dataSource.storeList(email, newListToStore);
    });
  }

  @override
  Future<Either<Failure, void>> storeFile(String email, File file) async {
    final storedFiles = await dataSource.getFiles(email);
    return storedFiles.fold((failure) => Left(failure), (files) {
      final fileList =
          files.map((file) => ContentFile.fromJson(jsonDecode(file))).toList();
      if (fileList.any((f) => f.fileName == (file as ContentFile).fileName)) {
        return const Left(Failure('File already exists'));
      } else {
        fileList.add(file as ContentFile);
        final newListToStore =
            fileList.map((file) => jsonEncode(file.toJson())).toList();
        return dataSource.storeList(email, newListToStore);
      }
    });
  }

  @override
  Future<Either<Failure, String>> getFileContent(
    String email,
    String fileId,
  ) async {
    final result = await dataSource.getFiles(email);
    print(fileId);
    return result.fold((failure) => Left(failure), (files) {
      final contentFileList =
          files.map((file) => ContentFile.fromJson(jsonDecode(file))).toList();
      final fileToGet = contentFileList.firstWhere(
        (element) => element.fileName == fileId,
      );
      return Right(fileToGet.content);
    });
  }

  @override
  Future<Either<Failure, void>> initOfflineFileStorage(String id) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final users = sp.getKeys();
      if (users.contains(id)) {
        return const Right(());
      }

      final stored = await sp.setStringList(id, []);
      if (stored) {
        print(sp.getKeys());
        return const Right(());
      } else {
        return Left(Failure('Failed to store files'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
