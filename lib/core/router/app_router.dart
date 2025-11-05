import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/auth_provider.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/router/app_routes.dart';
import 'package:fridge_app/features/auth/login/views/login_screen.dart';
import 'package:fridge_app/features/auth/register/views/register_screen.dart';
import 'package:fridge_app/features/fridge_selection/views/create_fridge_screen.dart';
import 'package:fridge_app/features/fridge_selection/views/fridge_selection_screen.dart';
import 'package:fridge_app/features/home/views/home_screen.dart';
import 'package:fridge_app/features/products/add/views/add_product_screen.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/edit/views/edit_product_screen.dart';
import 'package:fridge_app/features/settings/views/settings_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final selectedFridge = ref.watch(selectedFridgeProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isRegistering = state.matchedLocation == AppRoutes.register;
      final isSelectingFridge =
          state.matchedLocation == AppRoutes.fridgeSelection;
      final isCreatingFridge = state.matchedLocation == AppRoutes.createFridge;

      if (!isAuthenticated && !isLoggingIn && !isRegistering) {
        return AppRoutes.login;
      }

      if (isAuthenticated && (isLoggingIn || isRegistering)) {
        return AppRoutes.fridgeSelection;
      }

      if (isAuthenticated &&
          selectedFridge == null &&
          !isSelectingFridge &&
          !isCreatingFridge) {
        return AppRoutes.fridgeSelection;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.fridgeSelection,
        builder: (context, state) {
          final isManualNavigation = state.extra == 'manual';
          return FridgeSelectionScreen(isManualNavigation: isManualNavigation);
        },
      ),
      GoRoute(
        path: AppRoutes.createFridge,
        builder: (context, state) => const CreateFridgeScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addProduct,
        builder: (context, state) {
          final productToDuplicate = state.extra as ProductModel?;
          return AddProductScreen(productToDuplicate: productToDuplicate);
        },
      ),
      GoRoute(
        path: AppRoutes.editProduct,
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return EditProductScreen(product: product);
        },
      ),
    ],
  );
});
