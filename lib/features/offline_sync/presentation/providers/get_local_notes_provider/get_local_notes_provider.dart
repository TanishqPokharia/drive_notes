import 'package:drive_notes_app/features/offline_sync/domain/usecases/get_local_notes.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_local_notes_provider.g.dart';

@riverpod
GetLocalNotes getLocalNotes(Ref ref) {
  return GetLocalNotes(getIt());
}
