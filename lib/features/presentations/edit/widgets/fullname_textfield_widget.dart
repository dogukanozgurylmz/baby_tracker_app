import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/presentations/edit/cubit/edit_cubit.dart';
import 'package:flutter/material.dart';

class FullnameTextFieldWidget extends StatelessWidget {
  const FullnameTextFieldWidget({
    super.key,
    required this.cubit,
  });

  final EditCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.length > 40) {
          cubit.fullNameTextController.text = value.substring(0, 40);
          cubit.fullNameTextController.selection =
              TextSelection.fromPosition(const TextPosition(offset: 40));
        }
      },
      controller: cubit.fullNameTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        fillColor: ColorConstant.grey,
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: TextConstant.babyFullName,
        hintStyle: const TextStyle(
          color: ColorConstant.grey2,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
