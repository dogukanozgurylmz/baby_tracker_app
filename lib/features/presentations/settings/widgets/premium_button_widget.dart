import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/presentations/inapp/inapp_view.dart';
import 'package:flutter/material.dart';

class PremiumButtonWidget extends StatelessWidget {
  const PremiumButtonWidget({
    super.key,
    required this.sizeOf,
  });

  final Size sizeOf;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InAppView(openedFromOnboarding: true),
            ));
      },
      child: Container(
        width: sizeOf.width,
        height: 81,
        decoration: ShapeDecoration(
          color: ColorConstant.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 30,
              bottom: -50,
              child: Container(
                width: 88,
                height: 88,
                decoration: const ShapeDecoration(
                  color: ColorConstant.primaryOpacityColor,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              right: -15,
              bottom: -30,
              child: Container(
                width: 88,
                height: 88,
                decoration: const ShapeDecoration(
                  color: ColorConstant.primaryOpacityColor,
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
                    Image.asset(
                      "assets/app_icon/crown.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      'Get Premium',
                      style: TextStyle(
                        color: ColorConstant.backgroundColor,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorConstant.backgroundColor,
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
