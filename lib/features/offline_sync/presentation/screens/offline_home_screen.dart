import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/offline_notes_notifier/offline_notes_notifier.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OfflineHomeScreen extends ConsumerWidget {
  const OfflineHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offline Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) {
          //     // return CreateNoteDialog();
          //   },
          // );
        },
        child: Icon(Icons.edit_note_rounded, size: context.rs(40)),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(offlineNotesNotifierProvider.future),
          child: Builder(
            builder: (context) {
              final offlineNotes = ref.watch(offlineNotesNotifierProvider);
              return offlineNotes.when(
                data: (notes) {
                  if (notes == null) {
                    return const Center(child: Text("No offline notes found"));
                  }
                  if (notes.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(context.rs(20)),
                      child: const Center(
                        child: Text(
                          "No notes found, creating offline notes will sync them in next online session",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index] as ContentFile;
                      return ListTile(
                        title: Text(
                          note.fileName,
                          style: context.textTheme.titleMedium,
                        ),
                        onTap: () {
                          context.pushNamed(AppRoutes.noteRoute, extra: note);
                        },
                        leading:
                            note.mimeType ==
                                    "application/vnd.google-apps.folder"
                                ? const Icon(
                                  Icons.folder_rounded,
                                  color: Colors.yellow,
                                )
                                : const Icon(
                                  Icons.file_present,
                                  color: Colors.yellow,
                                ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: context.theme.iconTheme.color!.withAlpha(100),
                        ),
                      );
                    },
                  );
                },
                error:
                    (error, stackTrace) => SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(child: Text(error.toString())),
                    ),
                loading:
                    () => SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
