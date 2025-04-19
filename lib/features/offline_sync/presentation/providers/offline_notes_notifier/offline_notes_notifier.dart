import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/delete_note_from_local.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/save_note_to_local.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/delete_note_from_local_provider/delete_note_from_local_provider.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/get_local_notes_provider/get_local_notes_provider.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/save_note_to_local_provider/save_note_to_local_provider.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/sync_drive_notes_provider/sync_drive_notes_provider.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offline_notes_notifier.g.dart';

@riverpod
class OfflineNotesNotifier extends _$OfflineNotesNotifier {
  @override
  Future<List<File>?> build() async {
    final getDriveNotesFiles = ref.read(getLocalNotesProvider);
    final files = await getDriveNotesFiles(NoParams());
    return files.fold((failure) => null, (files) => files);
  }

  void deleteNote(File file) async {
    final deleteLocalNote = ref.read(deleteNoteFromLocalProvider);
    final result = await deleteLocalNote(DeleteNoteFromLocalParams(file));
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (success) {
        state = AsyncValue.data(
          state.value?.where((f) => f.id != file.id).toList(),
        );
      },
    );
  }

  Future<Either<Failure, void>> addNote(File file) async {
    final saveNoteToLocal = ref.read(saveNoteToLocalProvider);
    final result = await saveNoteToLocal(SaveNoteToLocalParams(file: file));
    return result.fold((failure) => Left(failure), (success) {
      state = AsyncValue.data([...?state.value, file]);
      return Right(success);
    });
  }

  Future<Either<Failure, void>> syncNotes() async {
    state = const AsyncValue.loading();
    final syncLocalNotes = ref.read(syncDriveNotesProvider);
    final result = await syncLocalNotes(NoParams());
    return result.fold((failure) => Left(failure), (success) {
      return Right(success);
    });
  }
}
