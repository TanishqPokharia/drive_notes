import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/features/home/domain/usecases/delete_note.dart';
import 'package:drive_notes_app/features/home/presentation/providers/create_drive_notes_provider/create_drive_notes_provider.dart';
import 'package:drive_notes_app/features/home/presentation/providers/get_drive_notes_files_provider/get_drive_notes_files_provider.dart';
import 'package:drive_notes_app/features/notes/presentation/providers/delete_note_provider/delete_note_provider.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drive_notes_files_notifier.g.dart';

@riverpod
class DriveNotesFilesNotifier extends _$DriveNotesFilesNotifier {
  @override
  Future<List<File>?> build() async {
    final getDriveNotesFiles = ref.read(getDriveNotesFilesProvider);
    final files = await getDriveNotesFiles(NoParams());
    return files.fold((failure) => null, (files) => files);
  }

  void addFile(File file) {
    if (file.name == null) return;
    if (file.name!.isEmpty) return;
    state = AsyncData([...state.value ?? [], file]);
  }

  void createDriveNotesFolder() {
    state = AsyncLoading();
    final createDriveNotesFolder = ref.read(createDriveNotesFolderProvider);
    final createStatus = createDriveNotesFolder(NoParams());
    createStatus.then((value) {
      value.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (folder) {
          state = AsyncData([]);
        },
      );
    });
  }

  Future<Either<Failure, bool>> tryDeleteFile(String fileId) async {
    if (fileId.isEmpty) return const Left(Failure('File ID cannot be empty'));
    final deleteSelectedFile = ref.read(deleteNoteProvider);
    final deleteStatus = await deleteSelectedFile(
      DeleteNoteParams(nodeId: fileId),
    );
    return deleteStatus;
  }

  void removeFromCurrentFiles(String fileId) {
    if (fileId.isEmpty) return;
    final updatedFiles =
        state.value?.where((file) => file.id != fileId).toList();
    state = AsyncData(updatedFiles);
  }
}
