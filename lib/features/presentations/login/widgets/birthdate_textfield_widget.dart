import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/presentations/login/cubit/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BirthDateTextFieldWidget extends StatelessWidget {
  const BirthDateTextFieldWidget({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        cubit.nullControle();
      },
      controller: cubit.birthDateTextController,
      onTap: () async {
        if (kIsWeb) {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          cubit.selectDate(selectedDate!);
        } else {
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
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    showDayOfWeek: true,
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      cubit.selectDate(newDate);
                      cubit.nullControle();
                    },
                    maximumYear: DateTime.now().year,
                  ),
                ),
              );
            },
          );
        }
      },
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        fillColor: ColorConstant.grey,
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        hintText: TextConstant.birthDate,
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
