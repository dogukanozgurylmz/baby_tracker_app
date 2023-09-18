// ignore_for_file: use_build_context_synchronously

import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/enums/premium_enum.dart';
import 'package:baby_tracker_app/features/core/widgets/custom_button.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/premium_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:baby_tracker_app/features/presentations/home/home_view.dart';
import 'package:baby_tracker_app/features/presentations/inapp/cubit/in_app_cubit.dart';
import 'package:baby_tracker_app/features/presentations/inapp/widgets/premium_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InAppView extends StatelessWidget {
  final PremiumLocalDatasource _premiumLocalDatasource =
      PremiumLocalDatasourceImpl();
  final bool openedFromOnboarding;
  InAppView({
    super.key,
    required this.openedFromOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => InAppCubit(
        premiumLocalDatasource: _premiumLocalDatasource,
      ),
      child: BlocBuilder<InAppCubit, InAppState>(
        builder: (context, state) {
          var cubit = context.read<InAppCubit>();
          return OrientationBuilder(builder: (context, orientation) {
            return Scaffold(
              backgroundColor: ColorConstant.backgroundColor,
              body: SafeArea(
                child: Center(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: orientation == Orientation.landscape
                                  ? null
                                  : sizeOf.height * .4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    TextConstant.getPremium,
                                    style: TextStyle(
                                      color: ColorConstant.primaryColor,
                                      fontSize: 27,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/inapp/baby_moon.png",
                                    height: 100,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 16),
                                              SizedBox(width: 8),
                                              Text(
                                                TextConstant.inappInfo1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.62,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 16),
                                              SizedBox(width: 8),
                                              Text(
                                                TextConstant.inappInfo2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.62,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 16),
                                              SizedBox(width: 8),
                                              Text(
                                                TextConstant.inappInfo3,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.62,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: orientation == Orientation.landscape
                                  ? null
                                  : sizeOf.height * 0.55,
                              child: Container(
                                width: sizeOf.width,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  color: ColorConstant.backgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x4CDBDBDB),
                                      blurRadius: 5,
                                      offset: Offset(0, 0),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child:
                                    _premiumCardsBuilder(state, cubit, context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 23,
                        child: IconButton(
                          onPressed: () {
                            if (!openedFromOnboarding) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeView(),
                                ),
                                (route) => false,
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          icon: Image.asset(
                            "assets/app_icon/close.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Padding _premiumCardsBuilder(
      InAppState state, InAppCubit cubit, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (state.selectedPremium == Premium.weekly) {
                cubit.selectPremium(Premium.empty);
              } else {
                cubit.selectPremium(Premium.weekly);
              }
            },
            child: PremiumCardWidget(
              title: TextConstant.weekly,
              price: "\$10",
              isSelect: state.selectedPremium == Premium.weekly ? true : false,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (state.selectedPremium == Premium.monthly) {
                cubit.selectPremium(Premium.empty);
              } else {
                cubit.selectPremium(Premium.monthly);
              }
            },
            child: PremiumCardWidget(
              title: TextConstant.monthly,
              price: "\$20",
              isSelect: state.selectedPremium == Premium.monthly ? true : false,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (state.selectedPremium == Premium.annual) {
                cubit.selectPremium(Premium.empty);
              } else {
                cubit.selectPremium(Premium.annual);
              }
            },
            child: PremiumCardWidget(
              title: TextConstant.annual,
              price: "\$30",
              isSelect: state.selectedPremium == Premium.annual ? true : false,
            ),
          ),
          const SizedBox(height: 4),
          CustomButton(
            isEnabled: true,
            onPressed: () async {
              if (state.selectedPremium != Premium.empty) {
                await cubit.updatePremium();
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomeView(),
                    ),
                    (route) => false);
              }
            },
            child: const Text(
              TextConstant.start,
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
    );
  }
}
