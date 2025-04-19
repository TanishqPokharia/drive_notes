import 'package:drive_notes_app/features/offline_sync/domain/usecases/update_note_in_local.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_note_in_local_provider.g.dart';

@riverpod
UpdateNoteInLocal updateNoteInLocal(Ref ref) {
  return UpdateNoteInLocal(getIt());
}
