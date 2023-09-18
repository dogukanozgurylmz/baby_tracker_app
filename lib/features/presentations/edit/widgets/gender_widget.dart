import 'package:baby_tracker_app/features/core/enums/gender_enum.dart';
import 'package:baby_tracker_app/features/presentations/edit/cubit/edit_cubit.dart';
import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.cubit,
    required this.gender,
  });

  final EditCubit cubit;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            cubit.selectGender(Gender.boy);
            // cubit.nullControle();
          },
          child: Image.asset(
            gender == Gender.boy
                ? "assets/app_icon/selected_boy.png"
                : "assets/app_icon/boy.png",
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            cubit.selectGender(Gender.girl);
            // cubit.nullControle();
          },
          child: Image.asset(
            gender == Gender.girl
                ? "assets/app_icon/selected_girl.png"
                : "assets/app_icon/girl.png",
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
