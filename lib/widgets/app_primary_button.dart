import 'package:flutter/material.dart';
import 'package:fridge_app/widgets/app_elevated_button.dart';
import 'package:fridge_app/widgets/app_outlined_button.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double height;

  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child:
          isOutlined
              ? AppOutlinedButton(
                text: text,
                onPressed: onPressed,
                isLoading: isLoading,
              )
              : AppElevatedButton(
                text: text,
                onPressed: onPressed,
                isLoading: isLoading,
              ),
    );
  }
}
