import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/router/app_router.dart';
import 'package:fridge_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: FridgeApp()));
}

class FridgeApp extends ConsumerStatefulWidget {
  const FridgeApp({super.key});

  @override
  ConsumerState<FridgeApp> createState() => _FridgeAppState();
}

class _FridgeAppState extends ConsumerState<FridgeApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(selectedFridgeProvider.notifier).loadSelectedFridge();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          bodySmall: TextStyle(fontSize: 12, color: AppColors.textHint),
        ),
      ),
      routerConfig: router,
    );
  }
}
