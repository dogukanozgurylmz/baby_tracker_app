import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/presentations/sleep/cubit/Sleep_cubit.dart';
import 'package:flutter/material.dart';

class NoteTextFieldWidget extends StatelessWidget {
  const NoteTextFieldWidget({
    super.key,
    required this.cubit,
  });

  final SleepCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        cubit.nullControle();
      },
      controller: cubit.noteTextController,
      maxLines: 10,
      maxLength: 200,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        fillColor: ColorConstant.grey,
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: TextConstant.note,
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
