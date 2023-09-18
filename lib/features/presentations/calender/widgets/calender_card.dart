import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CalenderCard extends StatelessWidget {
  final Size sizeOf;
  final String date;
  final String category;
  final Widget icon;
  final String time;
  const CalenderCard({
    super.key,
    required this.sizeOf,
    required this.date,
    required this.category,
    required this.icon,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: sizeOf.width,
          height: 120,
          decoration: ShapeDecoration(
            color: ColorConstant.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0) +
                    const EdgeInsets.only(top: 18, bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.91,
                        letterSpacing: -0.50,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: ColorConstant.grey2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    icon,
                    const SizedBox(width: 4),
                    Text(
                      category,
                      style: const TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      time,
                      style: const TextStyle(
                        color: ColorConstant.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
