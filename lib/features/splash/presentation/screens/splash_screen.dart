import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/get_previous_user.dart';
import 'package:drive_notes_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.getPreviousUser});
  final GetPreviousUser getPreviousUser;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () async {
      final isOnline = await isDeviceOnline();
      if (!isOnline) {
        if (mounted) {
          context.goNamed(AppRoutes.offlineHomeRoute);
        }
      }
      final previousUser = await widget.getPreviousUser(NoParams());
      previousUser.fold(
        (failure) {
          if (mounted) {
            context.goNamed(AppRoutes.authRoute);
            return;
          }
        },
        (user) {
          if (mounted) {
            if (user == null) {
              context.goNamed(AppRoutes.authRoute);
              return;
            } else {
              context.goNamed(AppRoutes.homeRoute);
              return;
            }
          }
        },
      );
    });
  }

  Future<bool> isDeviceOnline() async {
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/drive_notes_icon.png",
          height: context.rs(200),
        ),
      ),
    );
  }
}
