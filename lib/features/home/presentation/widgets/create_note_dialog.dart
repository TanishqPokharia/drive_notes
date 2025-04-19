import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/features/home/presentation/providers/create_note_notifier/create_note_notifier.dart';
import 'package:drive_notes_app/features/home/presentation/providers/drive_notes_files_notifier/drive_notes_files_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateNoteDialog extends ConsumerStatefulWidget {
  const CreateNoteDialog({super.key});

  @override
  ConsumerState<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends ConsumerState<CreateNoteDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createNoteNotifierProvider);
    return Dialog(
      backgroundColor: context.theme.dialogTheme.backgroundColor,
      child: Container(
        margin: EdgeInsets.all(context.rs(20)),
        height: context.rs(300),
        width: context.rs(300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create Note", style: context.textTheme.titleLarge),
                const Divider(),
              ],
            ),
            isLoading
                ? CircularProgressIndicator()
                : Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.rs(10)),
                      child: TextField(
                        controller: _textEditingController,
                        style: context.textTheme.titleMedium,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Note Title",
                          labelStyle: context.textTheme.titleMedium,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            "Cancel",
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_textEditingController.text.isNotEmpty) {
                              final createNoteStatus = await ref
                                  .read(createNoteNotifierProvider.notifier)
                                  .createNote(_textEditingController.text);
                              createNoteStatus.fold(
                                (failure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(failure.message),
                                      backgroundColor:
                                          context.theme.colorScheme.error,
                                    ),
                                  );
                                },
                                (file) {
                                  Navigator.pop(context);
                                  ref
                                      .read(
                                        driveNotesFilesNotifierProvider
                                            .notifier,
                                      )
                                      .addFile(file);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Note created successfully",
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          },
                          child: Text(
                            "Create",
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
