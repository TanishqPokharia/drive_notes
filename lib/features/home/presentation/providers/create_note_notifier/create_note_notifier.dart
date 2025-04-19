import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/home/domain/usecases/create_note.dart';
import 'package:drive_notes_app/features/notes/presentation/providers/create_note_provider/create_note_provider.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_note_notifier.g.dart';

@riverpod
class CreateNoteNotifier extends _$CreateNoteNotifier {
  @override
  bool build() {
    return false;
  }

  Future<Either<Failure, File>> createNote(String name) async {
    if (name.isEmpty) {
      return const Left(Failure('Note name cannot be empty'));
    }
    state = true;
    final createNote = ref.read(createNoteProvider);
    final file = await createNote(CreateNoteParams(title: name));
    state = false;
    return file;
  }
}
