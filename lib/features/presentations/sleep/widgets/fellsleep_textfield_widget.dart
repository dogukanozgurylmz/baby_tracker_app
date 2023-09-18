import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/presentations/sleep/cubit/Sleep_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FellSleepTextFieldWidget extends StatelessWidget {
  const FellSleepTextFieldWidget({
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
      onTap: () {
        showCupertinoModalPopup<DateTime>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime(DateTime.now().year + 1, 1, 1),
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    cubit.selectFellSleep(newDate);
                  },
                ),
              ),
            );
          },
        );
      },
      readOnly: true,
      controller: cubit.fellSleepTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        fillColor: ColorConstant.grey,
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: TextConstant.fellSleep,
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
