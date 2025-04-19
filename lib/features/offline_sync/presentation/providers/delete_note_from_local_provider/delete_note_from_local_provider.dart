import 'package:drive_notes_app/features/offline_sync/domain/usecases/delete_note_from_local.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_note_from_local_provider.g.dart';

@riverpod
DeleteNoteFromLocal deleteNoteFromLocal(Ref ref) {
  return DeleteNoteFromLocal(getIt());
}
