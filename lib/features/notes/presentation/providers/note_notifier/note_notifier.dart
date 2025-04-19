import 'package:drive_notes_app/features/home/domain/usecases/delete_note.dart';
import 'package:drive_notes_app/features/notes/domain/usecases/get_note_content.dart';
import 'package:drive_notes_app/features/notes/domain/usecases/update_note.dart';
import 'package:drive_notes_app/features/notes/presentation/providers/delete_note_provider/delete_note_provider.dart';
import 'package:drive_notes_app/features/notes/presentation/providers/get_note_content_provider/get_note_content_provider.dart';
import 'package:drive_notes_app/features/notes/presentation/providers/update_note_provider/update_note_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_notifier.g.dart';

@Riverpod(keepAlive: true)
class NoteNotifier extends _$NoteNotifier {
  @override
  FutureOr<String> build({required String noteId}) async {
    final noteContentProvider = ref.read(getNoteContentProvider);
    final content = await noteContentProvider(
      GetNoteContentParams(noteId: noteId),
    );
    return content.fold((failure) => failure.message, (text) => text);
  }

  Future<bool> updateNoteContent(String newContent) async {
    final previousContent = state.value ?? "";
    state = const AsyncValue.loading();
    final updateNote = ref.read(updateNoteProvider);
    final updateStatus = await updateNote(
      UpdateNoteParams(noteId: noteId, content: newContent),
    );
    return updateStatus.fold(
      (failure) {
        state = AsyncData(previousContent);
        return false;
      },
      (success) {
        state = AsyncData(newContent);
        return true;
      },
    );
  }

  Future<bool> deleteNote(String nodeId) async {
    final previousValue = state.value ?? "";
    state = const AsyncValue.loading();
    final delete = ref.read(deleteNoteProvider);
    final deleteStatus = await delete(DeleteNoteParams(nodeId: nodeId));
    return deleteStatus.fold(
      (failure) {
        state = AsyncData(previousValue);
        return false;
      },
      (success) {
        state = AsyncData("");
        return true;
      },
    );
  }
}
