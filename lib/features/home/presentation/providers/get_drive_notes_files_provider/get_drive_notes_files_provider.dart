import 'package:drive_notes_app/features/home/domain/usecases/get_drive_notes_files.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_drive_notes_files_provider.g.dart';

@riverpod
GetDriveNotesFiles getDriveNotesFiles(Ref ref) {
  return GetDriveNotesFiles(getIt());
}
