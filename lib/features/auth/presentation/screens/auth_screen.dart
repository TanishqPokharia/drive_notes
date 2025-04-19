import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:drive_notes_app/features/auth/presentation/widgets/animated_branding.dart';
import 'package:drive_notes_app/features/auth/presentation/widgets/auth_app_icon_circle_background.dart';
import 'package:drive_notes_app/features/auth/presentation/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [SignInButton()],
      persistentFooterAlignment: AlignmentDirectional.center,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AuthAppIconCircleBackground(),
            Padding(
              padding: EdgeInsets.all(context.rs(20)),
              child: AnimatedBranding(style: context.textTheme.headlineLarge!),
            ),
          ],
        ),
      ),
    );
  }
}
