import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/main.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart';

abstract class HomeDataSource {
  Future<Either<Failure, List<File>?>> getDriveNotesFiles(String id);
  Future<Either<Failure, String?>> getDriveNotesFolderId();
  Future<Either<Failure, bool>> createDriveNotesFolder();
  Future<Either<Failure, File>> createNote(String title, String folderId);
  Future<Either<Failure, bool>> deleteNote(String noteId);
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<Either<Failure, List<File>?>> getDriveNotesFiles(String id) async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }
      final driveApi = DriveApi(authenticatedClient);
      final targetFiles = await driveApi.files.list(q: "'$id' in parents");
      final driveNotesFiles = targetFiles.files;
      return Right(driveNotesFiles);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNote(String noteId) async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }
      final driveApi = DriveApi(authenticatedClient);
      await driveApi.files.delete(noteId);
      return Right(true);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createDriveNotesFolder() async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }
      final driveApi = DriveApi(authenticatedClient);
      final file = File();
      file.name = "DriveNotes";
      file.mimeType = "application/vnd.google-apps.folder";
      return driveApi.files.create(file).then((value) => Right(true));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getDriveNotesFolderId() async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }

      final driveApi = DriveApi(authenticatedClient);
      final driveFiles = await driveApi.files.list(
        q: "name = 'DriveNotes' and mimeType = 'application/vnd.google-apps.folder'",
      );
      final files = driveFiles.files;
      if (files == null || files.isEmpty) {
        return Right(null);
      }

      String? driveNotesId;
      driveNotesId = files[0].id;

      return Right(driveNotesId);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> createNote(
    String title,
    String folderId,
  ) async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }
      final driveApi = DriveApi(authenticatedClient);
      final file = File();
      file.name = title;
      file.mimeType = "text/plain";
      file.parents = [folderId];
      final content = "";
      final media = Media(
        Stream.fromIterable([utf8.encode(content)]),
        content.length,
      );
      final createdFile = await driveApi.files.create(file, uploadMedia: media);
      return Right(createdFile);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
