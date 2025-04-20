import 'package:drive_notes_app/core/is_online_provider.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/features/home/presentation/providers/drive_notes_files_notifier/drive_notes_files_notifier.dart';
import 'package:drive_notes_app/features/home/presentation/widgets/create_note_dialog.dart';
import 'package:drive_notes_app/features/home/presentation/widgets/delete_note_dialog.dart';
import 'package:drive_notes_app/features/home/presentation/widgets/profile_dialog.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/sync_drive_notes.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/providers/offline_notes_notifier/offline_notes_notifier.dart';
import 'package:drive_notes_app/main.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _isSyncingProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen(this.email, {super.key});
  final String? email;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final isOnline = ref.read(isOnlineProvider);
      if (isOnline) {
        if (mounted) {
          syncOfflineNotes(context, ref, googleSignIn.currentUser?.email ?? "");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.read(isOnlineProvider);
    final isSyncing = ref.watch(_isSyncingProvider);

    final driveNotesList =
        isOnline
            ? ref.watch(driveNotesFilesNotifierProvider)
            : ref.watch(
              offlineNotesNotifierProvider(email: widget.email ?? ""),
            );

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
          if (widget.email != null)
            SizedBox(
              width: context.rs(200),
              child: Text(widget.email ?? "", overflow: TextOverflow.ellipsis),
            ),
          SizedBox(width: context.rs(20)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CreateNoteDialog(widget.email);
            },
          );
        },
        label: Text("Create"),
        icon: Icon(Icons.edit_note_rounded, size: context.rs(40)),
      ),
      body: Builder(
        builder: (context) {
          if (isSyncing) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: context.rs(40),
                    width: context.rs(40),
                    child: CircularProgressIndicator(),
                  ),
                  Text("Syncing offline notes..."),
                ],
              ),
            );
          }

          return SafeArea(
            child: RefreshIndicator(
              onRefresh:
                  () => ref.refresh(driveNotesFilesNotifierProvider.future),
              child: driveNotesList.when(
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
                          isOnline
                              ? "No text files currently in DriveNotes folder, please create one"
                              : "No files currently in your offline notes",
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
                        onTap: () {
                          final Map<String, dynamic> queryParams = {};
                          if (!isOnline) {
                            queryParams["email"] = widget.email;
                          }
                          context.pushNamed(
                            AppRoutes.noteRoute,
                            pathParameters: {
                              "fileName":
                                  isOnline
                                      ? file.name ?? "No name"
                                      : (file as ContentFile).fileName,
                              "fileId": file.id ?? " ",
                            },
                            queryParameters: queryParams,
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return DeleteNoteDialog(widget.email, file: file);
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
                          isOnline
                              ? file.name ?? "No name"
                              : (file as ContentFile).fileName,
                          style: context.textTheme.titleMedium,
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  print(error);
                  print(stackTrace);
                  return Center(
                    child: Text(
                      (error.toString()),
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }

  void syncOfflineNotes(
    BuildContext context,
    WidgetRef ref,
    String email,
  ) async {
    ref.read(_isSyncingProvider.notifier).update((state) => true);
    final syncNotes = getIt<SyncDriveNotes>();
    final syncStatus = await syncNotes(SyncDriveNotesParams(email));
    syncStatus.fold(
      (failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (synced) {
        if (synced) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Sync completed")));
          ref.refresh(driveNotesFilesNotifierProvider.future);
        }
      },
    );
    ref.read(_isSyncingProvider.notifier).update((state) => false);
  }
}
