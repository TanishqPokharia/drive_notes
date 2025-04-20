import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:drive_notes_app/features/splash/presentation/providers/theme_notifier/theme_notifier.dart';
import 'package:drive_notes_app/main.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileDialog extends ConsumerWidget {
  const ProfileDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(context.rs(20)),
        width: context.rs(400),
        height: context.rs(400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (googleSignIn.currentUser != null)
              SizedBox(
                width: context.rs(100),
                height: context.rs(100),
                child: GoogleUserCircleAvatar(
                  identity: googleSignIn.currentUser!,
                ),
              ),
            Column(
              children: [
                Text(
                  googleSignIn.currentUser?.email ?? "No email",
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  googleSignIn.currentUser?.displayName ?? "No name",
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Theme:", style: context.textTheme.bodyLarge),
                DropdownButton(
                  hint: Text("Select Theme"),
                  value: ThemeMode.system,
                  items: [
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.dark,
                      child: Text("Dark"),
                    ),
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.light,
                      child: Text("Light"),
                    ),
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.system,
                      child: Text("System"),
                    ),
                  ],
                  onChanged: (value) {
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setTheme(value ?? ThemeMode.system);
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final signOut = getIt<SignOutUser>();
                final status = await signOut(NoParams());
                status.fold(
                  (failure) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(failure.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  (success) {
                    context.pop();
                    context.goNamed(AppRoutes.authRoute);
                  },
                );
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
