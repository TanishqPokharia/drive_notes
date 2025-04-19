import 'package:drive_notes_app/features/notes/domain/usecases/get_note_content.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_note_content_provider.g.dart';

@riverpod
GetNoteContent getNoteContent(Ref ref) {
  return GetNoteContent(getIt());
}
