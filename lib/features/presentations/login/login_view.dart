// ignore_for_file: use_build_context_synchronously

import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/widgets/custom_button.dart';
import 'package:baby_tracker_app/features/data/datasources/local/baby_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/baby_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/onboarding_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/onboarding_local_datasource.dart';
import 'package:baby_tracker_app/features/presentations/inapp/inapp_view.dart';
import 'package:baby_tracker_app/features/presentations/login/widgets/birthdate_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/login/widgets/duedate_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/login/widgets/fullname_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/login/widgets/gender_widget.dart';
import 'package:baby_tracker_app/features/presentations/login/widgets/select_image_widget.dart';
import 'package:baby_tracker_app/features/presentations/login/widgets/timeofbirth_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final BabyLocalDatasource _babyLocalDatasource = BabyLocalDatasourceImpl();
  final OnboardingLocalDatasource _onboardingLocalDatasource =
      OnboardingLocalDatasourceImpl();
  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => LoginCubit(
        babyLocalDatasource: _babyLocalDatasource,
        onboardingLocalDatasource: _onboardingLocalDatasource,
      ),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return OrientationBuilder(builder: (context, orientation) {
            return Scaffold(
              backgroundColor: ColorConstant.backgroundColor,
              body: SafeArea(
                child: Center(
                  child: orientation == Orientation.portrait
                      ? _portraitViewBuilder(cubit, state, sizeOf, context)
                      : _landspaceViewBuilder(cubit, state, sizeOf, context),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Column _portraitViewBuilder(
      LoginCubit cubit, LoginState state, Size sizeOf, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 38),
        SelectImageWidget(cubit: cubit, state: state),
        const SizedBox(height: 45),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  GenderWidget(cubit: cubit, gender: state.gender),
                  const SizedBox(height: 25),
                  FullnameTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  BirthDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  TimeOfBirthTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  DueDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  CustomButton(
                    isEnabled: !state.buttonIsNull,
                    onPressed: () async {
                      await cubit.createBaby();
                      await cubit.updateOnboarding();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InAppView(openedFromOnboarding: false),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      TextConstant.continues,
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
        ),
      ],
    );
  }

  Row _landspaceViewBuilder(
      LoginCubit cubit, LoginState state, Size sizeOf, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: sizeOf.width * .2,
          child: SelectImageWidget(cubit: cubit, state: state),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  GenderWidget(cubit: cubit, gender: state.gender),
                  const SizedBox(height: 25),
                  FullnameTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  BirthDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  TimeOfBirthTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  DueDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  CustomButton(
                    isEnabled: !state.buttonIsNull,
                    onPressed: () async {
                      await cubit.createBaby();
                      await cubit.updateOnboarding();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InAppView(openedFromOnboarding: false),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      TextConstant.continues,
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
        ),
      ],
    );
  }
}
