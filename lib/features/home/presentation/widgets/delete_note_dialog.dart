import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/features/home/presentation/providers/drive_notes_files_notifier/drive_notes_files_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart';

final isDeletingProvider = StateProvider<bool>((ref) => false);

class DeleteNoteDialog extends ConsumerWidget {
  const DeleteNoteDialog({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(isDeletingProvider);
    if (isDeleting) {
      return Dialog(child: const Center(child: CircularProgressIndicator()));
    }
    return AlertDialog(
      title: Text("Delete ${file.name}"),
      content: Text("Are you sure you want to delete this file?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: context.textTheme.bodyMedium),
        ),
        TextButton(
          onPressed: () async {
            ref.read(isDeletingProvider.notifier).update((state) => true);
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
            ref.read(isDeletingProvider.notifier).update((state) => false);
          },
          child: Text("Delete", style: context.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
