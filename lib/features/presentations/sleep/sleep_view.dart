// ignore_for_file: use_build_context_synchronously

import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/widgets/custom_button.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/sleep_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/sleep_local_datasource.dart';
import 'package:baby_tracker_app/features/presentations/sleep/cubit/Sleep_cubit.dart';
import 'package:baby_tracker_app/features/presentations/sleep/widgets/fellsleep_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/sleep/widgets/note_textfield_widget.dart';
import 'package:baby_tracker_app/features/presentations/sleep/widgets/wakeup_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SleepView extends StatelessWidget {
  final SleepLocalDatasource _sleepLocalDatasource = SleepLocalDatasourceImpl();
  SleepView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewInsetsOf = MediaQuery.viewInsetsOf(context);
    return BlocProvider(
      create: (context) => SleepCubit(
        sleepLocalDatasource: _sleepLocalDatasource,
      ),
      child: BlocBuilder<SleepCubit, SleepState>(
        builder: (context, state) {
          var cubit = context.read<SleepCubit>();
          return Scaffold(
            backgroundColor: ColorConstant.backgroundColor,
            appBar: AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const Text(
                'Sleep',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: 27,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      FellSleepTextFieldWidget(cubit: cubit),
                      const SizedBox(height: 29),
                      WakeUpTextFieldWidget(cubit: cubit),
                      const SizedBox(height: 29),
                      NoteTextFieldWidget(cubit: cubit),
                    ],
                  ),
                ),
                state.buttonIsNull
                    ? const SizedBox.shrink()
                    : viewInsetsOf.bottom > 0
                        ? const SizedBox.shrink()
                        : Positioned(
                            bottom: 24,
                            right: 24,
                            left: 24,
                            child: CustomButton(
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
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                Navigator.pop(context);
                                await cubit.createSleep();
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
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                TextConstant.save,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
