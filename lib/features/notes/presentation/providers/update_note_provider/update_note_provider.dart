import 'package:drive_notes_app/features/notes/domain/usecases/update_note.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_note_provider.g.dart';

@riverpod
UpdateNote updateNote(Ref ref) {
  return UpdateNote(getIt());
}
