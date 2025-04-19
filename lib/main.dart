import 'package:drive_notes_app/core/utils/dependencies.dart';
import 'package:drive_notes_app/features/splash/presentation/providers/theme_notifier/theme_notifier.dart';
import 'package:drive_notes_app/router/router_config.dart';
import 'package:drive_notes_app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerDependencies();
  await getIt.allReady();
  runApp(ProviderScope(child: const MyApp()));
}

final getIt = GetIt.instance;
final googleSignIn = GoogleSignIn.standard(scopes: [DriveApi.driveScope]);
final router = AppRouter().router;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ref.watch(themeNotifierProvider).value,
    );
  }
}
