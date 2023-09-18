import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/presentations/login/login_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _currentPage = 0;
  bool nextPage = false;
  bool onboardingSaw = false;

  List<OnboardingItem> onboardings = [
    OnboardingItem(
      image: "assets/onboarding/img_onboarding1.png",
      title: TextConstant.onboardingView1Title,
      body: TextConstant.onboardingView1Body,
    ),
    OnboardingItem(
      image: "assets/onboarding/img_onboarding2.png",
      title: TextConstant.onboardingView2Title,
      body: TextConstant.onboardingView2Body,
    ),
    OnboardingItem(
      image: "assets/onboarding/img_onboarding3.png",
      title: TextConstant.onboardingView3Title,
      body: TextConstant.onboardingView3Body,
    ),
  ];

  void changeOnboarding() {
    if (_currentPage == onboardings.length - 1) {
      setState(() {
        nextPage = true;
      });
    } else {
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: _imageBuilder(sizeOf),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bodyBuilder(sizeOf, context),
          ),
        ],
      ),
    );
  }

  Container _bodyBuilder(Size sizeOf, BuildContext context) {
    return Container(
      height: sizeOf.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Text(
                onboardings[_currentPage].title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorConstant.black,
                  fontSize: 31,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.41,
                ),
              ),
              const Spacer(),
              Text(
                onboardings[_currentPage].body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorConstant.black,
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.67,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardings.length, (index) {
                  bool isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    width: isActive ? 28.0 : 8.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: isActive
                          ? ColorConstant.primaryColor
                          : ColorConstant.grey2,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  changeOnboarding();
                  if (nextPage) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ),
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorConstant.primaryColor,
                  minimumSize: Size(sizeOf.width, 64),
                  shadowColor: Colors.transparent,
                  foregroundColor: ColorConstant.primaryColor,
                  surfaceTintColor: ColorConstant.primaryColor,
                ),
                child: const Text(
                  TextConstant.next,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedSwitcher _imageBuilder(Size sizeOf) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Image.asset(
        onboardings[_currentPage].image,
        key: ValueKey<int>(_currentPage),
        width: sizeOf.width,
      ),
    );
  }
}

class OnboardingItem {
  String image;
  String title;
  String body;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.body,
  });
}
