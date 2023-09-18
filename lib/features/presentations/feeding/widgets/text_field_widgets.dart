import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/feeding_cubit.dart';

class TextFieldWidgets extends StatelessWidget {
  const TextFieldWidgets({
    super.key,
    required this.cubit,
  });

  final FeedingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          //text field for time
          _timeTextFieldBuilder(context),
          const SizedBox(height: 29),
          //text field for amount
          _amountTextFieldBuilder(),
          const SizedBox(height: 29),
          //text field for note
          _noteTextFieldBuilder(),
        ],
      ),
    );
  }

  TextField _noteTextFieldBuilder() {
    return TextField(
      onChanged: (value) {
        cubit.nullControl();
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

  TextField _amountTextFieldBuilder() {
    return TextField(
      onChanged: (value) {
        cubit.nullControl();
        if (value.length > 4) {
          cubit.amountTextController.text = value.substring(0, 4);
          cubit.amountTextController.selection =
              TextSelection.fromPosition(const TextPosition(offset: 4));
        }
      },
      controller: cubit.amountTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        fillColor: ColorConstant.grey,
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: TextConstant.amount,
        hintStyle: const TextStyle(
          color: ColorConstant.grey2,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextField _timeTextFieldBuilder(BuildContext context) {
    return TextField(
      onChanged: (value) {
        cubit.nullControl();
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
                    cubit.selectTime(newDate);
                  },
                ),
              ),
            );
          },
        );
      },
      readOnly: true,
      controller: cubit.timeTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        fillColor: ColorConstant.grey,
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: TextConstant.time,
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
