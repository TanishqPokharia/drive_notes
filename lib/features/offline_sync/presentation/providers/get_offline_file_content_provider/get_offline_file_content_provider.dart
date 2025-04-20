import 'package:drive_notes_app/features/offline_sync/domain/usecases/get_file_content.dart';
import 'package:drive_notes_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_offline_file_content_provider.g.dart';

@riverpod
GetOfflineFileContent getOfflineFileContent(Ref ref) {
  return GetOfflineFileContent(getIt());
}
