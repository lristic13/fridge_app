import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/router/app_routes.dart';
import 'package:fridge_app/features/fridge_selection/widgets/empty_fridges_state.dart';
import 'package:fridge_app/features/fridge_selection/widgets/fridge_card.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';
import 'package:fridge_app/widgets/shimmer/fridge_shimmer.dart';
import 'package:go_router/go_router.dart';

class FridgeSelectionScreen extends ConsumerStatefulWidget {
  final bool isManualNavigation;

  const FridgeSelectionScreen({super.key, this.isManualNavigation = false});

  @override
  ConsumerState<FridgeSelectionScreen> createState() =>
      _FridgeSelectionScreenState();
}

class _FridgeSelectionScreenState extends ConsumerState<FridgeSelectionScreen> {
  bool _hasAutoNavigated = false;

  @override
  Widget build(BuildContext context) {
    final fridgesAsyncValue = ref.watch(userFridgesProvider);
    final selectedFridge = ref.watch(selectedFridgeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Select Fridge'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: fridgesAsyncValue.when(
          data: (fridges) {
            if (fridges.isEmpty) {
              return const AppEmptyFridgesState();
            }

            if (fridges.length == 1 &&
                !widget.isManualNavigation &&
                !_hasAutoNavigated) {
              _hasAutoNavigated = true;
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (selectedFridge?.id != fridges.first.id) {
                  await ref
                      .read(selectedFridgeProvider.notifier)
                      .setSelectedFridge(fridges.first);
                }
                if (mounted) {
                  context.go(AppRoutes.home);
                }
              });
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: fridges.length,
                    itemBuilder: (context, index) {
                      final fridge = fridges[index];
                      return AppFridgeCard(
                        fridge: fridge,
                        onTap: () async {
                          await ref
                              .read(selectedFridgeProvider.notifier)
                              .setSelectedFridge(fridge);
                          if (context.mounted) {
                            context.go(AppRoutes.home);
                          }
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, -2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: AppPrimaryButton(
                    text: AppStrings.addNewFridge,
                    onPressed: () {
                      context.push(AppRoutes.createFridge);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const AppFridgeShimmer(),
          error:
              (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: AppColors.error),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.errorFailedToLoadFridges,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
