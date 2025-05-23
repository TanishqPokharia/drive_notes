import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/get_file_content.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/update_note_in_local.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/get_offline_file_content_provider/get_offline_file_content_provider.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/update_note_in_local_provider/update_note_in_local_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offline_drive_note_notifier.g.dart';

@riverpod
class OfflineDriveNoteNotifier extends _$OfflineDriveNoteNotifier {
  @override
  Future<String> build({required String email, required String fileId}) async {
    final getOfflineFileContent = ref.read(getOfflineFileContentProvider);
    final result = await getOfflineFileContent(
      GetOfflineFileContentParams(email, fileId),
    );
    return result.fold((failure) => failure.message, (content) => content);
  }

  Future<Either<Failure, void>> updateContent(
    String email,
    String fileId,
    String content,
  ) async {
    state = AsyncLoading();
    final updateNoteInLocal = ref.read(updateNoteInLocalProvider);
    final result = await updateNoteInLocal(
      UpdateNoteInLocalParams(email, fileId, content),
    );
    return result.fold(
      (failure) {
        print(failure.message);
        state = AsyncError(failure.message, StackTrace.current);
        return Left(failure);
      },
      (success) {
        print("Update successful");
        state = AsyncData(content);
        return Right(success);
      },
    );
  }
}
