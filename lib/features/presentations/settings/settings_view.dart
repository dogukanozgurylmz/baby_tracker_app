import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/premium_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:baby_tracker_app/features/presentations/settings/cubit/settings_cubit.dart';
import 'package:baby_tracker_app/features/presentations/settings/widgets/contact_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/settings/widgets/premium_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/settings/widgets/privacy_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/settings/widgets/rate_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/settings/widgets/restore_button_widget.dart';
import 'package:baby_tracker_app/features/presentations/settings/widgets/term_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  final PremiumLocalDatasource _premiumLocalDatasource =
      PremiumLocalDatasourceImpl();
  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => SettingsCubit(
        premiumLocalDatasource: _premiumLocalDatasource,
      ),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorConstant.backgroundColor,
            appBar: AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const Text(
                TextConstant.settings,
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    state.isPremium
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 20),
                    state.isPremium
                        ? const SizedBox.shrink()
                        : PremiumButtonWidget(sizeOf: sizeOf),
                    const SizedBox(height: 20),
                    RateButtonWidget(sizeOf: sizeOf),
                    const SizedBox(height: 20),
                    TermsButtonWidget(sizeOf: sizeOf),
                    const SizedBox(height: 20),
                    PrivacyButtonWidget(sizeOf: sizeOf),
                    const SizedBox(height: 20),
                    ContactButtonWidget(sizeOf: sizeOf),
                    const SizedBox(height: 20),
                    RestoreButtonWidget(sizeOf: sizeOf),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
