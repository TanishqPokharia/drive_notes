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
  Future<Either<Failure, void>> updateFile(File file, File newFile) async {
    final result = await dataSource.updateFile(
      jsonEncode(file.toJson()),
      jsonEncode(newFile.toJson()),
    );
    return result.fold(
      (failure) => Left(failure),
      (success) => const Right(()),
    );
  }
}
