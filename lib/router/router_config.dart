import 'package:drive_notes_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:drive_notes_app/features/home/presentation/screens/home_screen.dart';
import 'package:drive_notes_app/features/notes/presentation/screens/note_screen.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/screens/offline_home_screen.dart';
import 'package:drive_notes_app/features/offline_sync/presentation/screens/offline_note_screen.dart';
import 'package:drive_notes_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:drive_notes_app/main.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen(getPreviousUser: getIt()));
        },
      ),
      GoRoute(
        path: "/auth",
        name: AppRoutes.authRoute,
        pageBuilder: (context, state) {
          return MaterialPage(child: AuthScreen());
        },
      ),
      GoRoute(
        path: "/offline",
        name: AppRoutes.offlineHomeRoute,
        pageBuilder:
            (context, state) => MaterialPage(child: OfflineHomeScreen()),
        routes: [
          GoRoute(
            path: "/note",
            name: AppRoutes.offlineNoteRoute,
            pageBuilder: (context, state) {
              final file = state.extra as ContentFile;
              return MaterialPage(child: OfflineNoteScreen(file: file));
            },
          ),
        ],
      ),
      GoRoute(
        path: "/home",
        name: AppRoutes.homeRoute,
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeScreen());
        },
        routes: [
          GoRoute(
            path: "/note/:fileName/:fileId",
            name: AppRoutes.noteRoute,
            pageBuilder: (context, state) {
              final fileName = state.pathParameters["fileName"];
              final fileId = state.pathParameters["fileId"];
              return MaterialPage(
                child: NoteScreen(
                  fileName: fileName ?? "No name",
                  fileId: fileId ?? "",
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
