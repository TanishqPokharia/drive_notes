import 'package:drive_notes_app/features/home/domain/usecases/create_drive_notes_folder.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_drive_notes_provider.g.dart';

@riverpod
CreateDriveNotesFolder createDriveNotesFolder(Ref ref) {
  return CreateDriveNotesFolder(getIt());
}
