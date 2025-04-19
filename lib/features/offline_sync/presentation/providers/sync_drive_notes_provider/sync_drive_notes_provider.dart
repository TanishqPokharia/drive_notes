import 'package:drive_notes_app/features/offline_sync/domain/usecases/sync_drive_notes.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_drive_notes_provider.g.dart';

@riverpod
SyncDriveNotes syncDriveNotes(Ref ref) {
  return SyncDriveNotes(getIt());
}
