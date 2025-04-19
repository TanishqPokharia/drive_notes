import 'package:drive_notes_app/features/home/domain/usecases/create_note.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_note_provider.g.dart';

@riverpod
CreateNote createNote(Ref ref) {
  return CreateNote(getIt());
}
