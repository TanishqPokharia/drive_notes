import 'package:drive_notes_app/features/home/domain/usecases/delete_note.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_note_provider.g.dart';

@riverpod
DeleteNote deleteNote(Ref ref) {
  return DeleteNote(getIt());
}
