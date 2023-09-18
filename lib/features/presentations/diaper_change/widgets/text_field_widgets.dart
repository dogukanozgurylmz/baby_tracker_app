import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/enums/diaper_status.dart';
import 'package:baby_tracker_app/features/presentations/diaper_change/cubit/diaper_change_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidgets extends StatelessWidget {
  const TextFieldWidgets({
    super.key,
    required this.cubit,
    required this.state,
  });

  final DiaperChangeCubit cubit;
  final DiaperChangeState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          //for choose time
          _timeTextFieldBuilder(context),
          const SizedBox(height: 29),
          //for choose diaper status
          _diaperStatusBuilder(),
          const SizedBox(height: 29),
          //for write note
          _noteTextFieldBuilder(),
        ],
      ),
    );
  }

  TextField _noteTextFieldBuilder() {
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

  Padding _diaperStatusBuilder() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            TextConstant.diaperStatus,
            style: TextStyle(
              color: ColorConstant.black,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              cubit.selectDiaper(DiaperStatus.wet);
              cubit.nullControle();
            },
            child: Row(
              children: [
                Image.asset(
                  state.selectedDiaper == DiaperStatus.wet
                      ? "assets/app_icon/diaperchangeselected1.png"
                      : "assets/app_icon/diaperchangeunselected1.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                Text(
                  TextConstant.wet,
                  style: TextStyle(
                    color: state.selectedDiaper == DiaperStatus.wet
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey2,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              cubit.selectDiaper(DiaperStatus.dirty);
              cubit.nullControle();
            },
            child: Row(
              children: [
                Image.asset(
                  state.selectedDiaper == DiaperStatus.dirty
                      ? "assets/app_icon/diaperchangeselected2.png"
                      : "assets/app_icon/diaperchangeunselected2.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                Text(
                  TextConstant.dirty,
                  style: TextStyle(
                    color: state.selectedDiaper == DiaperStatus.dirty
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey2,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              cubit.selectDiaper(DiaperStatus.mixed);
              cubit.nullControle();
            },
            child: Row(
              children: [
                Image.asset(
                  state.selectedDiaper == DiaperStatus.mixed
                      ? "assets/app_icon/diaperchangeselected3.png"
                      : "assets/app_icon/diaperchangeunselected3.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                Text(
                  TextConstant.mixed,
                  style: TextStyle(
                    color: state.selectedDiaper == DiaperStatus.mixed
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey2,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              cubit.selectDiaper(DiaperStatus.dry);
              cubit.nullControle();
            },
            child: Row(
              children: [
                Image.asset(
                  state.selectedDiaper == DiaperStatus.dry
                      ? "assets/app_icon/diaperchangeselected4.png"
                      : "assets/app_icon/diaperchangeunselected4.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                Text(
                  TextConstant.dry,
                  style: TextStyle(
                    color: state.selectedDiaper == DiaperStatus.dry
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey2,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _timeTextFieldBuilder(BuildContext context) {
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
