import 'package:assembly/core/constants.dart';
import 'package:assembly/firebase_options.dart';
import 'package:assembly/generated/locale_loader.g.dart';
import 'package:assembly/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'resources/langs/',
        supportedLocales:
            CodegenLoader.mapLocales.keys.map((e) => Locale(e)).toList(),
        assetLoader: CodegenLoader(),
        child: const AssemblyApp(),
      ),
    ),
  );
}

class AssemblyApp extends ConsumerWidget {
  const AssemblyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: kSeedColor),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
