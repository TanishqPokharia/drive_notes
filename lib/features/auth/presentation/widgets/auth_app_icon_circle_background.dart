import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class AuthAppIconCircleBackground extends StatefulWidget {
  const AuthAppIconCircleBackground({super.key});

  @override
  State<AuthAppIconCircleBackground> createState() =>
      _AuthAppIconCircleBackgroundState();
}

class _AuthAppIconCircleBackgroundState
    extends State<AuthAppIconCircleBackground> {
  double scale = 0;
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      if (mounted) {
        setState(() {
          scale = 1;
        });
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        AnimatedScale(
          scale: scale,
          duration: Duration(milliseconds: 400),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: context.rs(120),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 400),
              opacity: opacity,
              child: Padding(
                padding: EdgeInsets.all(context.rs(30)),
                child: Image.asset("assets/drive_notes_icon.png"),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 400),
          opacity: opacity,
          child: Text("Drive Notes", style: context.textTheme.headlineLarge),
        ),
      ],
    );
  }
}
