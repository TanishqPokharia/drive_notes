import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/features/home/presentation/providers/drive_notes_files_notifier/drive_notes_files_notifier.dart';
import 'package:drive_notes_app/features/home/presentation/widgets/create_note_dialog.dart';
import 'package:drive_notes_app/features/home/presentation/widgets/delete_note_dialog.dart';
import 'package:drive_notes_app/features/home/presentation/widgets/profile_dialog.dart';
import 'package:drive_notes_app/main.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          if (googleSignIn.currentUser != null)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ProfileDialog();
                  },
                );
              },
              child: GoogleUserCircleAvatar(
                identity: googleSignIn.currentUser!,
              ),
            ),
          SizedBox(width: context.rs(20)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CreateNoteDialog();
            },
          );
        },
        child: Icon(Icons.edit_note_rounded, size: context.rs(40)),
      ),
      body: Builder(
        builder: (context) {
          final driveNotesFiles = ref.watch(driveNotesFilesNotifierProvider);
          return SafeArea(
            child: RefreshIndicator(
              onRefresh:
                  () => ref.refresh(driveNotesFilesNotifierProvider.future),
              child: driveNotesFiles.when(
                skipLoadingOnRefresh: false,
                data: (files) {
                  if (files == null) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "DriveNotes folder does not exist in your Google Drive",
                                textAlign: TextAlign.center,
                                style: context.textTheme.titleMedium,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(
                                        driveNotesFilesNotifierProvider
                                            .notifier,
                                      )
                                      .createDriveNotesFolder();
                                },
                                child: Text("Create DriveNotes Folder"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (files.isEmpty) {
                    return Container(
                      margin: EdgeInsets.all(context.rs(10)),
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          "No text files currently in DriveNotes folder, please create one",
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return ListTile(
                        onTap:
                            () => context.pushNamed(
                              AppRoutes.noteRoute,
                              pathParameters: {
                                "fileName": file.name ?? "No name",
                                "fileId": file.id ?? "",
                              },
                            ),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return DeleteNoteDialog(file: file);
                            },
                          );
                        },
                        leading:
                            file.mimeType ==
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
                        title: Text(
                          file.name ?? "No name",
                          style: context.textTheme.titleMedium,
                        ),
                      );
                    },
                  );
                },
                error:
                    (error, stackTrace) => Center(
                      child: Text(
                        (error as Failure).message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}
