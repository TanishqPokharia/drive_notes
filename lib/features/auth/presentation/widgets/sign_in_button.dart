import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/sign_in_user.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:drive_notes_app/main.dart';
import 'package:go_router/go_router.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  void signInUser() {}
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        final signInUser = getIt<SignInUser>();
        final result = await signInUser(NoParams());
        result.fold(
          (failure) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(failure.message),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          (success) {
            context.goNamed(AppRoutes.homeRoute);
          },
        );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        textStyle: WidgetStatePropertyAll(
          context.textTheme.titleMedium!.copyWith(),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign In With Google"),
          Image.asset("assets/google_icon.png", height: context.rs(60)),
        ],
      ),
    );
  }
}
