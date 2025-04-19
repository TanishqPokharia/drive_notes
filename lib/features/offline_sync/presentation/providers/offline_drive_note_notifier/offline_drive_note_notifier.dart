import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/update_note_in_local.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/update_note_in_local_provider/update_note_in_local_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offline_drive_note_notifier.g.dart';

@riverpod
class OfflineDriveNoteNotifier extends _$OfflineDriveNoteNotifier {
  @override
  Future<String> build({required ContentFile file}) async {
    return file.content;
  }

  Future<Either<Failure, void>> updateContent(
    ContentFile file,
    ContentFile newFile,
  ) async {
    state = AsyncLoading();
    final updateNoteInLocal = ref.read(updateNoteInLocalProvider);
    final result = await updateNoteInLocal(
      UpdateNoteInLocalParams(file, newFile),
    );
    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        return Left(failure);
      },
      (success) {
        state = AsyncData(newFile.content);
        return Right(success);
      },
    );
  }
}
