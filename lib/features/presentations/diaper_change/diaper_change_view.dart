// ignore_for_file: use_build_context_synchronously

import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/widgets/custom_button.dart';
import 'package:baby_tracker_app/features/data/datasources/local/diaper_change_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/diaper_change_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/presentations/diaper_change/cubit/diaper_change_cubit.dart';
import 'package:baby_tracker_app/features/presentations/diaper_change/widgets/text_field_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaperChangeView extends StatelessWidget {
  final DiaperChangeLocalDatasource _diaperChangeLocalDatasource =
      DiaperChangeLocalDatasourceImpl();
  DiaperChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    // var sizeOf = MediaQuery.sizeOf(context);
    var viewInsetsOf = MediaQuery.viewInsetsOf(context);
    return BlocProvider(
      create: (context) => DiaperChangeCubit(
        diaperChangeLocalDatasource: _diaperChangeLocalDatasource,
      ),
      child: BlocBuilder<DiaperChangeCubit, DiaperChangeState>(
        builder: (context, state) {
          var cubit = context.read<DiaperChangeCubit>();
          return Scaffold(
            backgroundColor: ColorConstant.backgroundColor,
            appBar: AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const Text(
                TextConstant.diaperChange,
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
                TextFieldWidgets(cubit: cubit, state: state),
                state.buttonIsNull
                    ? const SizedBox.shrink()
                    : viewInsetsOf.bottom > 0
                        ? const SizedBox.shrink()
                        : Positioned(
                            bottom: 24,
                            left: 24,
                            right: 24,
                            child: CustomButton(
                              isEnabled: true,
                              onPressed: () async {
                                await _createDiaperChange(
                                    cubit: cubit, context: context);
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

  Future<void> _createDiaperChange({
    required DiaperChangeCubit cubit,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.pop(context);
    await cubit.createDiaperChange();
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
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
