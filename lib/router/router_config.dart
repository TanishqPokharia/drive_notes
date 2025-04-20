import 'package:drive_notes_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:drive_notes_app/features/home/presentation/screens/home_screen.dart';
import 'package:drive_notes_app/features/notes/presentation/screens/note_screen.dart';
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
              final child = NoteScreen(
                fileName: fileName ?? "",
                fileId: fileId ?? "",
              );
              return MaterialPage(child: child);
            },
          ),
        ],
      ),
    ],
  );
}
