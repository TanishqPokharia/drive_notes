import 'package:drive_notes_app/core/is_online_provider.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/features/notes/presentation/providers/note_notifier/note_notifier.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/offline_drive_note_notifier/offline_drive_note_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';

final _enableEditingProvider = StateProvider((ref) => false);

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen(
    this.email, {
    super.key,
    required this.fileName,
    required this.fileId,
  });

  final String? email;
  final String fileName;
  final String fileId;

  @override
  ConsumerState<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends ConsumerState<NoteScreen> {
  late TextEditingController _textEditingController;
  String initialContent = "";
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
    final noteNotifier = noteNotifierProvider(noteId: widget.fileId);
    final offlineNoteNotifier = offlineDriveNoteNotifierProvider(
      fileId: widget.fileName,
      email: widget.email ?? "",
    );
    final isOnline = ref.read(isOnlineProvider);
    final noteState =
        isOnline ? ref.watch(noteNotifier) : ref.watch(offlineNoteNotifier);
    return IgnorePointer(
      ignoring: noteState.isLoading,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.fileName)),
        persistentFooterButtons: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                if (isOnline) {
                  await updateDriveNote(noteNotifier);
                } else {
                  updateOfflineNote(offlineNoteNotifier);
                }
              },
              child: Text("Save"),
            ),
          ),
        ],
        body: Padding(
          padding: EdgeInsets.all(context.rs(10)),
          child: SizedBox.expand(
            child: noteState.when(
              data: (data) {
                initialContent = data;
                _textEditingController.text = data;
                return TextField(
                  controller: _textEditingController,
                  maxLines: null,
                  expands: true,
                  style: context.textTheme.titleMedium,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    enabled: ref.watch(_enableEditingProvider),
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                print(error);
                print(stackTrace);
                return Center(child: Text(error.toString()));
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_textEditingController.text != initialContent &&
                ref.read(_enableEditingProvider)) {
              showAlertDialog();
            } else {
              ref
                  .read(_enableEditingProvider.notifier)
                  .update((state) => !state);
            }
            String message = "";
            if (ref.read(_enableEditingProvider)) {
              message = "Editing Mode";
            } else {
              message = "Reading Mode";
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          child: Icon(
            ref.watch(_enableEditingProvider)
                ? Icons.edit_rounded
                : Icons.visibility,
            size: context.rs(30),
          ),
        ),
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.theme.dialogTheme.backgroundColor,
          titleTextStyle: context.textTheme.titleMedium,
          icon: Icon(
            Icons.warning_amber,
            color: Colors.red,
            size: context.rs(40),
          ),
          title: Text("Are you sure you want to discard changes?"),
          content: Text(
            "Changes made will be lost. Press save to keep changes.",
          ),
          alignment: Alignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: context.textTheme.bodyMedium),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(_enableEditingProvider.notifier)
                    .update((state) => !state);
                Navigator.of(context).pop();
              },
              child: Text("Discard", style: context.textTheme.bodyMedium),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateDriveNote(NoteNotifierProvider noteNotifier) async {
    final updateSuccess = await ref
        .read(noteNotifier.notifier)
        .updateNoteContent(_textEditingController.text);
    String message = "";
    if (updateSuccess) {
      if (context.mounted) {
        message = "Note updated successfully";
      } else {
        message = "Note update failed";
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void updateOfflineNote(
    OfflineDriveNoteNotifierProvider offlineNoteNotifier,
  ) async {
    final updateStatus = await ref
        .read(offlineNoteNotifier.notifier)
        .updateContent(
          widget.email ?? "",
          widget.fileName,
          _textEditingController.text,
        );
    updateStatus.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
      (success) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Note updated successfully")));
        }
      },
    );
  }
}
