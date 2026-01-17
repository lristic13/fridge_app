import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/providers/auth_provider.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/providers/user_provider.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/settings/widgets/invite_member_dialog.dart';

class MembersBottomSheet extends ConsumerStatefulWidget {
  const MembersBottomSheet({super.key});

  @override
  ConsumerState<MembersBottomSheet> createState() => _MembersBottomSheetState();
}

class _MembersBottomSheetState extends ConsumerState<MembersBottomSheet> {
  Map<String, String> _memberEmails = {};
  bool _isLoading = true;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _loadMemberEmails();
  }

  Future<void> _loadMemberEmails() async {
    final fridge = ref.read(selectedFridgeProvider);
    if (fridge == null) return;

    final userRepository = ref.read(userRepositoryProvider);
    final allMemberIds = [fridge.ownerId, ...fridge.memberIds];
    final uniqueIds = allMemberIds.toSet().toList();

    try {
      final emails = await userRepository.getUserEmailsByIds(uniqueIds);
      if (mounted) {
        setState(() {
          _memberEmails = emails;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        UiHelpers.showErrorSnackBar(context, 'Failed to load members');
      }
    }
  }

  Future<void> _removeMember(String userId) async {
    final fridge = ref.read(selectedFridgeProvider);
    if (fridge == null) return;

    final confirmed = await _showRemoveConfirmation();
    if (confirmed != true) return;

    setState(() => _isRemoving = true);

    try {
      final fridgeRepository = ref.read(fridgeRepositoryProvider);
      await fridgeRepository.removeMemberFromFridge(
        fridgeId: fridge.id,
        userId: userId,
      );

      final updatedFridge = fridge.copyWith(
        memberIds: fridge.memberIds.where((id) => id != userId).toList(),
      );
      await ref
          .read(selectedFridgeProvider.notifier)
          .setSelectedFridge(updatedFridge);

      if (mounted) {
        setState(() {
          _memberEmails.remove(userId);
          _isRemoving = false;
        });
        UiHelpers.showSuccessSnackBar(context, AppStrings.memberRemoved);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isRemoving = false);
        UiHelpers.showErrorSnackBar(context, 'Failed to remove member');
      }
    }
  }

  Future<bool?> _showRemoveConfirmation() {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.removeMemberTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.removeMemberMessage,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(AppStrings.cancel),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(AppStrings.remove),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
    );
  }

  void _showInviteDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const InviteMemberDialog(),
    ).then((_) => _loadMemberEmails());
  }

  @override
  Widget build(BuildContext context) {
    final fridge = ref.watch(selectedFridgeProvider);
    final currentUser = ref.watch(currentUserProvider).valueOrNull;

    if (fridge == null) {
      return const SizedBox.shrink();
    }

    final isOwner = currentUser?.uid == fridge.ownerId;
    final allMemberIds = [fridge.ownerId, ...fridge.memberIds];
    final uniqueIds = allMemberIds.toSet().toList();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.people, color: AppColors.primary, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          AppStrings.members,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: uniqueIds.length,
                  itemBuilder: (context, index) {
                    final userId = uniqueIds[index];
                    final email = _memberEmails[userId] ?? 'Loading...';
                    final isMemberOwner = userId == fridge.ownerId;
                    final isCurrentUser = userId == currentUser?.uid;
                    final canRemove = isOwner && !isMemberOwner && !_isRemoving;

                    return _MemberListTile(
                      email: email,
                      isOwner: isMemberOwner,
                      isCurrentUser: isCurrentUser,
                      canRemove: canRemove,
                      onRemove: () => _removeMember(userId),
                    );
                  },
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: OutlinedButton.icon(
                  onPressed: _showInviteDialog,
                  icon: const Icon(Icons.person_add),
                  label: Text(AppStrings.addMember),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberListTile extends StatelessWidget {
  final String email;
  final bool isOwner;
  final bool isCurrentUser;
  final bool canRemove;
  final VoidCallback onRemove;

  const _MemberListTile({
    required this.email,
    required this.isOwner,
    required this.isCurrentUser,
    required this.canRemove,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Icon(Icons.person, color: AppColors.primary),
      ),
      title: Text(
        email,
        style: TextStyle(
          fontWeight: isCurrentUser ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: Row(
        children: [
          if (isOwner)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                AppStrings.owner,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          if (isOwner && isCurrentUser) const SizedBox(width: 8),
          if (isCurrentUser)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                AppStrings.you,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      trailing:
          canRemove
              ? IconButton(
                icon: Icon(Icons.remove_circle_outline, color: AppColors.error),
                onPressed: onRemove,
              )
              : null,
    );
  }
}
