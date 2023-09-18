// ignore_for_file: use_build_context_synchronously

import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/widgets/custom_button.dart';
import 'package:baby_tracker_app/features/data/datasources/local/baby_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/baby_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/presentations/edit/cubit/edit_cubit.dart';
import 'package:baby_tracker_app/features/presentations/edit/widgets/birthdate_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/edit/widgets/duedate_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/edit/widgets/fullname_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/edit/widgets/gender_widget.dart';
import 'package:baby_tracker_app/features/presentations/edit/widgets/select_image_widget.dart';
import 'package:baby_tracker_app/features/presentations/edit/widgets/timeofbirth_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditView extends StatelessWidget {
  final BabyLocalDatasource _babyLocalDatasource = BabyLocalDatasourceImpl();
  EditView({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => EditCubit(
        babyLocalDatasource: _babyLocalDatasource,
      ),
      child: BlocBuilder<EditCubit, EditState>(
        builder: (context, state) {
          var cubit = context.read<EditCubit>();
          return OrientationBuilder(builder: (context, orientation) {
            return Scaffold(
              backgroundColor: ColorConstant.backgroundColor,
              body: SafeArea(
                child: Center(
                  child: orientation == Orientation.portrait
                      ? _portraitViewBuilder(context, cubit, state, sizeOf)
                      : _landspaceViewBuilder(context, cubit, state, sizeOf),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Column _portraitViewBuilder(
      BuildContext context, EditCubit cubit, EditState state, Size sizeOf) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        //for change profile photo
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
                  //for change gender
                  GenderWidget(cubit: cubit, gender: state.gender),
                  const SizedBox(height: 25),
                  //for change full name
                  FullnameTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  //for change birth date
                  BirthDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  //for change time of birth
                  TimeOfBirthTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  //for change due date
                  DueDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  CustomButton(
                    isEnabled: true,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      await Future.delayed(const Duration(milliseconds: 1000));
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            alignment: Alignment.center,
                            content: Text(
                              TextConstant.saved,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.backgroundColor,
                                fontSize: 26,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      );
                      await Future.delayed(const Duration(milliseconds: 1000));
                      await cubit.updateBaby();
                      if (cubit.message.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(cubit.message),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      TextConstant.save,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
      BuildContext context, EditCubit cubit, EditState state, Size sizeOf) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: sizeOf.width * .2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              const Spacer(),
              //for change profile photo
              SelectImageWidget(cubit: cubit, state: state),
              const Spacer(),
              const Spacer(),
            ],
          ),
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
                  //for change gender
                  GenderWidget(cubit: cubit, gender: state.gender),
                  const SizedBox(height: 25),
                  //for change full name
                  FullnameTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  //for change birth date
                  BirthDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  //for change time of birth
                  TimeOfBirthTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  //for change due date
                  DueDateTextFieldWidget(cubit: cubit),
                  const SizedBox(height: 48),
                  CustomButton(
                    isEnabled: true,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      await Future.delayed(const Duration(milliseconds: 1000));
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            alignment: Alignment.center,
                            content: Text(
                              TextConstant.saved,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.backgroundColor,
                                fontSize: 26,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      );
                      await Future.delayed(const Duration(milliseconds: 1000));
                      await cubit.updateBaby();
                      if (cubit.message.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(cubit.message),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      TextConstant.save,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
