import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/core/widgets/custom_button.dart';
import 'package:baby_tracker_app/features/data/datasources/local/feeding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/feeding_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/presentations/feeding/cubit/feeding_cubit.dart';
import 'package:baby_tracker_app/features/presentations/feeding/widgets/text_field_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedingView extends StatelessWidget {
  final FeedingLocalDatasource _feedingLocalDatasource =
      FeedingLocalDatasourceImpl();
  FeedingView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewInsetsOf = MediaQuery.viewInsetsOf(context);
    return BlocProvider(
      create: (context) => FeedingCubit(
        feedingLocalDatasource: _feedingLocalDatasource,
      ),
      child: BlocBuilder<FeedingCubit, FeedingState>(
        builder: (context, state) {
          var cubit = context.read<FeedingCubit>();
          return Scaffold(
            backgroundColor: ColorConstant.backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              forceMaterialTransparency: true,
              title: const Text(
                TextConstant.feeding,
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
                TextFieldWidgets(cubit: cubit),
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
                                await _createFeeding(
                                    context: context, cubit: cubit);
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

  Future<void> _createFeeding({
    required BuildContext context,
    required FeedingCubit cubit,
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
    await cubit.createFeeding();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          alignment: Alignment.center,
          content: Text(
            'Saved',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFAFAFA),
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
