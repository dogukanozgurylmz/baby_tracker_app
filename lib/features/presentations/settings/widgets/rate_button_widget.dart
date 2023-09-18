import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

import '../../webview_page/webview_page.dart';

class RateButtonWidget extends StatelessWidget {
  const RateButtonWidget({
    super.key,
    required this.sizeOf,
  });

  final Size sizeOf;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                const WebViewPage(url: 'https://www.neonapps.co/'),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: sizeOf.width,
        height: 60,
        decoration: ShapeDecoration(
          color: ColorConstant.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/app_icon/rate.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const Text(
              'Rate Us',
              style: TextStyle(
                color: ColorConstant.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorConstant.nextIcon,
            ),
          ],
        ),
      ),
    );
  }
}
