import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/presentations/diaper_change/diaper_change_view.dart';
import 'package:baby_tracker_app/features/presentations/home/cubit/home_cubit.dart';
import 'package:baby_tracker_app/features/presentations/inapp/inapp_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaperChangeButtonWidget extends StatelessWidget {
  const DiaperChangeButtonWidget({
    super.key,
    required this.sizeOf,
    required this.state,
  });

  final Size sizeOf;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (state.isPremium) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => DiaperChangeView(),
            ),
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InAppView(openedFromOnboarding: true),
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        width: sizeOf.width,
        height: 63,
        decoration: ShapeDecoration(
          color: ColorConstant.diaperButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 40,
              bottom: -60,
              child: Container(
                width: 88,
                height: 88,
                decoration: const ShapeDecoration(
                  color: ColorConstant.diaperButtonOpacityColor,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              right: -5,
              bottom: -40,
              child: Container(
                width: 88,
                height: 88,
                decoration: const ShapeDecoration(
                  color: ColorConstant.diaperButtonOpacityColor,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    // Icon(MyFlutterApp.diaper),
                    Image.asset(
                      "assets/app_icon/diaper.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      TextConstant.diaperChange,
                      style: TextStyle(
                        color: ColorConstant.backgroundColor,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
