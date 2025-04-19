import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/main.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart';

abstract class NoteDataSource {
  Future<Either<Failure, String>> getNoteContent(String noteId);
  Future<Either<Failure, bool>> updateNote(String noteId, String content);
}

class NoteDataSourceImpl implements NoteDataSource {
  @override
  Future<Either<Failure, String>> getNoteContent(String noteId) async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }
      final drivesApi = DriveApi(authenticatedClient);
      final Media file =
          await drivesApi.files.get(
                noteId,
                downloadOptions: DownloadOptions.fullMedia,
              )
              as Media;
      final content = StringBuffer();
      await for (var data in file.stream.transform(utf8.decoder)) {
        content.write(data);
      }
      return Right(content.toString());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateNote(
    String noteId,
    String content,
  ) async {
    try {
      final authenticatedClient = await googleSignIn.authenticatedClient();
      if (authenticatedClient == null) {
        throw "Could not get authenticated client";
      }
      final driveApi = DriveApi(authenticatedClient);
      final media = Media(
        Stream.fromIterable([utf8.encode(content)]),
        content.length,
      );
      await driveApi.files.update(File(), noteId, uploadMedia: media);
      return Right(true);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
