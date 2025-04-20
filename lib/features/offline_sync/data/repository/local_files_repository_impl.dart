import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/offline_sync/data/datasource/local_files_datasource.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/local_files_repository.dart';
import 'package:googleapis/drive/v3.dart';

class LocalFilesRepositoryImpl implements LocalFilesRepository {
  final LocalFilesDataSource dataSource;

  LocalFilesRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, void>> clearFiles() async {
    return dataSource.clearFiles();
  }

  @override
  Future<Either<Failure, List<File>>> getFiles() async {
    final result = await dataSource.getFiles();
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
  Future<Either<Failure, void>> removeFile(File file) async {
    final result = await dataSource.removeFile(jsonEncode(file.toJson()));
    return result.fold(
      (failure) => Left(failure),
      (success) => const Right(()),
    );
  }

  @override
  Future<Either<Failure, void>> storeFiles(List<File> fileData) async {
    final result = await dataSource.storeList(
      fileData.map((file) => jsonEncode(file.toJson())).toList(),
    );
    return result.fold(
      (failure) => Left(failure),
      (success) => const Right(()),
    );
  }

  @override
  Future<Either<Failure, void>> updateFile(
    String fileId,
    String content,
  ) async {
    final result = await dataSource.getFiles();
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
      return dataSource.storeList(newListToStore);
    });
  }

  @override
  Future<Either<Failure, void>> storeFile(File file) async {
    final storedFiles = await dataSource.getFiles();
    return storedFiles.fold((failure) => Left(failure), (files) {
      final fileList =
          files.map((file) => ContentFile.fromJson(jsonDecode(file))).toList();
      if (fileList.any((f) => f.fileName == (file as ContentFile).fileName)) {
        return const Left(Failure('File already exists'));
      } else {
        fileList.add(file as ContentFile);
        final newListToStore =
            fileList.map((file) => jsonEncode(file.toJson())).toList();
        return dataSource.storeList(newListToStore);
      }
    });
  }

  @override
  Future<Either<Failure, String>> getFileContent(String fileId) async {
    final result = await dataSource.getFiles();
    return result.fold((failure) => Left(failure), (files) {
      final contentFileList =
          files.map((file) => ContentFile.fromJson(jsonDecode(file))).toList();
      final fileToGet = contentFileList.firstWhere(
        (element) => element.name == fileId,
      );
      return Right(fileToGet.content);
    });
  }
}
