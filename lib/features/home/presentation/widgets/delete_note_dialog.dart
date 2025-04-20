import 'package:drive_notes_app/core/is_online_provider.dart';
import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/features/home/presentation/providers/drive_notes_files_notifier/drive_notes_files_notifier.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/offline_notes_notifier/offline_notes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart';

final _isDeletingProvider = StateProvider<bool>((ref) => false);

class DeleteNoteDialog extends ConsumerWidget {
  const DeleteNoteDialog({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(_isDeletingProvider);
    final isOnline = ref.read(isOnlineProvider);
    if (isDeleting) {
      return Dialog(
        child: Container(
          height: context.rs(200),
          width: context.rs(200),
          padding: EdgeInsets.all(context.rs(10)),
          child: Center(
            child: SizedBox(
              height: context.rs(40),
              width: context.rs(40),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: context.rs(200),
      width: context.rs(200),
      child: AlertDialog(
        title: Text("Delete ${file.name}"),
        content: Text("Are you sure you want to delete this file?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel", style: context.textTheme.bodyMedium),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: context.theme.colorScheme.error,
              textStyle: context.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              ref.read(_isDeletingProvider.notifier).update((state) => true);

              ref.read(_isDeletingProvider.notifier).update((state) => false);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  void deleteDriveNote(BuildContext context, WidgetRef ref) async {
    final deleteStatus = await ref
        .read(driveNotesFilesNotifierProvider.notifier)
        .tryDeleteFile(file.id ?? "");
    deleteStatus.fold(
      (failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (status) {
        if (status) {
          ref
              .read(driveNotesFilesNotifierProvider.notifier)
              .removeFromCurrentFiles(file.id ?? "");
          Navigator.of(context).pop();
        }
      },
    );
  }

  void deleteOfflineNote(BuildContext context, WidgetRef ref) {
    ref.read(offlineNotesNotifierProvider.notifier).deleteNote(file);
  }
}
