import 'package:drive_notes_app/features/offline_sync/domain/usecases/save_note_to_local.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_note_to_local_provider.g.dart';

@riverpod
SaveNoteToLocal saveNoteToLocal(Ref ref) {
  return SaveNoteToLocal(getIt());
}
