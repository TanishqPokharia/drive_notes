import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/home/data/datasource/home_datasource.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/local_files_repository.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';
import 'package:drive_notes_app/main.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart';

class OfflineSyncRepositoryImpl implements OfflineSyncRepository {
  final LocalFilesRepository repository;
  final HomeDataSource homeDataSource;

  OfflineSyncRepositoryImpl(this.repository, this.homeDataSource);

  @override
  Future<Either<Failure, void>> clearLocalFiles(String email) async {
    return repository.clearFiles(email);
  }

  @override
  Future<Either<Failure, void>> deleteNoteFromLocal(String email, File file) {
    return repository.removeFile(email, file);
  }

  @override
  Future<Either<Failure, List<File>>> getLocalFiles(String email) {
    return repository.getFiles(email);
  }

  @override
  Future<Either<Failure, bool>> offlineNotesExist(String email) {
    return repository.getFiles(email).then((result) {
      return result.fold(
        (failure) => Left(failure),
        (files) => Right(files.isNotEmpty),
      );
    });
  }

  @override
  Future<Either<Failure, void>> saveNoteToLocal(String email, File file) async {
    final files = await repository.getFiles(email);
    return files.fold((failure) => Left(failure), (existingFiles) {
      if (existingFiles.any((f) => (f as ContentFile).fileName == file.id)) {
        return Left(const Failure('File already exists in local storage'));
      } else {
        return repository.storeFiles(email, [...existingFiles, file]);
      }
    });
  }

  @override
  Future<Either<Failure, void>> storeFiles(String email, List<File> files) {
    return repository.storeFiles(email, files);
  }

  @override
  Future<Either<Failure, bool>> syncNotes(String email) async {
    try {
      final storedFiles = await repository.getFiles(email);
      return await storedFiles.fold(
        (failure) {
          return Left(failure);
        },
        (files) async {
          if (files.isEmpty) {
            return Right((false));
          }

          final authenticatedClient = await googleSignIn.authenticatedClient();
          if (authenticatedClient == null) {
            return Left(const Failure('User is not authenticated'));
          }
          final driveApi = DriveApi(authenticatedClient);
          final driveNotesFolderId =
              await homeDataSource.getDriveNotesFolderId();

          return driveNotesFolderId.fold((failure) => Left(failure), (
            folderId,
          ) async {
            if (folderId == null) {
              return Left(Failure("Drive Notes folder does not exist"));
            }

            final localFiles = storedFiles.fold(
              (failure) => <File>[],
              (files) => files,
            );
            for (final file in localFiles) {
              final contentFile = file as ContentFile;
              final fileUploadData = File(
                name: contentFile.fileName,
                mimeType: "text/plain",
                parents: [folderId],
              );
              final media = Media(
                Stream.fromIterable([utf8.encode(contentFile.content)]),
                contentFile.content.length,
              );

              final driveFile = await driveApi.files.create(
                fileUploadData,
                uploadMedia: media,
              );
              if (driveFile.id != null) {
                await repository.removeFile(email, file);
              }
            }
            return const Right((true));
          });
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNoteInLocal(
    String email,
    String fileId,
    String content,
  ) async {
    final files = await repository.getFiles(email);
    return files.fold((failure) => Left(failure), (existingFiles) {
      if (existingFiles.any((f) => (f as ContentFile).fileName == fileId)) {
        return repository.updateFile(email, fileId, content);
      } else {
        return Left(const Failure('File does not exist in local storage'));
      }
    });
  }
}
