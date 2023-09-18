import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class PremiumCardWidget extends StatelessWidget {
  const PremiumCardWidget({
    super.key,
    required this.title,
    required this.price,
    required this.isSelect,
  });
  final String title;
  final String price;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity - 2,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        border: isSelect
            ? const GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: ColorConstant.gradientColors,
                ),
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              title,
              style: const TextStyle(
                color: ColorConstant.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Text(
              price,
              style: const TextStyle(
                color: ColorConstant.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
