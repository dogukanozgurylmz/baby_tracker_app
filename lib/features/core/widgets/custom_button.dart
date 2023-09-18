import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final Widget child;

  const CustomButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorConstant.primaryColor,
        minimumSize: const Size(double.infinity, 64),
        shadowColor: Colors.transparent,
        foregroundColor: ColorConstant.primaryColor,
        surfaceTintColor: ColorConstant.primaryColor,
        disabledBackgroundColor: ColorConstant.grey2,
      ),
      child: child,
    );
  }
}
