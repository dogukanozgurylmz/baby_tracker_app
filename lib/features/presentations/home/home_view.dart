import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/baby_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/premium_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:baby_tracker_app/features/presentations/calender/calender_view.dart';
import 'package:baby_tracker_app/features/presentations/edit/edit_view.dart';
import 'package:baby_tracker_app/features/presentations/home/widgets/diaper_change_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/home/widgets/feeding_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/home/widgets/profile_photo_widget.dart';
import 'package:baby_tracker_app/features/presentations/home/widgets/sleep_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/settings/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  final BabyLocalDatasourceImpl _babyLocalDatasourceImpl =
      BabyLocalDatasourceImpl();
  final PremiumLocalDatasource _premiumLocalDatasource =
      PremiumLocalDatasourceImpl();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => HomeCubit(
        babyLocalDatasourceImpl: _babyLocalDatasourceImpl,
        premiumLocalDatasource: _premiumLocalDatasource,
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          if (state.status != HomeStatus.success) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return OrientationBuilder(builder: (context, orientation) {
            return Scaffold(
              backgroundColor: ColorConstant.backgroundColor,
              body: SafeArea(
                child: orientation == Orientation.portrait
                    ? _portraitViewBuilder(context, state, cubit, sizeOf)
                    : _landspaceViewBuilder(context, state, cubit, sizeOf),
              ),
            );
          });
        },
      ),
    );
  }

  Column _portraitViewBuilder(
      BuildContext context, HomeState state, HomeCubit cubit, Size sizeOf) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 23,
            right: 23,
            bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SettingsView(),
                      ));
                },
                child: const Icon(Icons.settings_outlined),
              ),
              ProfilePhotoWidgets(state: state),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CalenderView(),
                      ));
                },
                child: const Icon(Icons.calendar_today_outlined),
              ),
            ],
          ),
        ),
        _editProfileBuilder(context, cubit),
        const SizedBox(height: 5),
        _fullnameBuilder(state),
        _ageBuilder(cubit),
        const SizedBox(height: 14),
        Expanded(
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
            child: Column(
              children: [
                const SizedBox(height: 18),
                FeedingButtonWidget(sizeOf: sizeOf, state: state),
                const SizedBox(height: 18),
                DiaperChangeButtonWidget(sizeOf: sizeOf, state: state),
                const SizedBox(height: 18),
                SleepButtonWidget(sizeOf: sizeOf, state: state),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _landspaceViewBuilder(
      BuildContext context, HomeState state, HomeCubit cubit, Size sizeOf) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 23,
                right: 23,
                bottom: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SettingsView(),
                          ));
                    },
                    child: const Icon(Icons.settings_outlined),
                  ),
                  SizedBox(width: sizeOf.width * 0.1),
                  ProfilePhotoWidgets(state: state),
                  SizedBox(width: sizeOf.width * 0.1),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CalenderView(),
                          ));
                    },
                    child: const Icon(Icons.calendar_today_outlined),
                  ),
                ],
              ),
            ),
            _editProfileBuilder(context, cubit),
            const SizedBox(height: 5),
            _fullnameBuilder(state),
            _ageBuilder(cubit),
          ],
        ),
        Expanded(
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
            child: Column(
              children: [
                const SizedBox(height: 18),
                FeedingButtonWidget(sizeOf: sizeOf, state: state),
                const SizedBox(height: 18),
                DiaperChangeButtonWidget(sizeOf: sizeOf, state: state),
                const SizedBox(height: 18),
                SleepButtonWidget(sizeOf: sizeOf, state: state),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text _ageBuilder(HomeCubit cubit) {
    return Text(
      cubit.ageAsString,
      style: const TextStyle(
        color: ColorConstant.black,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Padding _fullnameBuilder(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Text(
        state.babyModel.fullName!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorConstant.primaryColor,
          fontSize: 25,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  GestureDetector _editProfileBuilder(BuildContext context, HomeCubit cubit) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditView(),
          ),
        ).whenComplete(cubit.init);
      },
      child: const Text(
        TextConstant.editProfile,
        style: TextStyle(
          color: Color(0xFF2C74FF),
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationColor: ColorConstant.clickedText,
        ),
      ),
    );
  }
}
