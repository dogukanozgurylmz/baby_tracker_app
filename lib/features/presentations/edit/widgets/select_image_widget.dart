import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/presentations/edit/cubit/edit_cubit.dart';
import 'package:flutter/material.dart';

class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({
    super.key,
    required this.cubit,
    required this.state,
  });

  final EditCubit cubit;
  final EditState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await cubit.selectImage();
        // cubit.nullControle();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 136,
            height: 136,
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
            width: 134,
            height: 134,
            decoration: BoxDecoration(
              image: state.image.isEmpty
                  ? null
                  : DecorationImage(
                      image: MemoryImage(state.image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: state.image.isEmpty
                ? Icon(
                    Icons.camera_alt,
                    color: Colors.grey.shade400,
                    size: 52,
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            bottom: 0,
            right: 8,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 8),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(136),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: ColorConstant.gradientColors,
                ),
              ),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
