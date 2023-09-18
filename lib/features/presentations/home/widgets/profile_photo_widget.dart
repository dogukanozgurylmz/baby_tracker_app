import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/presentations/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class ProfilePhotoWidgets extends StatelessWidget {
  const ProfilePhotoWidgets({
    super.key,
    required this.state,
  });

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(136),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ColorConstant.gradientColors,
            ),
          ),
        ),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: MemoryImage(state.babyModel.image!), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
