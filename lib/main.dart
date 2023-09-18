import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/onboarding_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/premium_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/premium_model.dart';
import 'package:baby_tracker_app/features/presentations/inapp/inapp_view.dart';
import 'package:baby_tracker_app/features/presentations/onboarding/onboarding_view.dart';
import 'package:baby_tracker_app/features/presentations/webview_page/webview_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'features/data/datasources/local/onboarding_local_datasource.dart';
import 'features/data/models/onboarding_model.dart';
import 'features/presentations/home/home_view.dart';

Future<void> main() async {
  await initializeDateFormatting('en_US', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  hiveRegisterAdapter();
  await hiveBox();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => WebViewProvider(),
    ),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
        ),
        home: const MainView(),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final OnboardingLocalDatasource _onboardingLocalDatasource =
      OnboardingLocalDatasourceImpl();
  final PremiumLocalDatasource _premiumLocalDatasource =
      PremiumLocalDatasourceImpl();
  bool onboardingSaw = false;
  bool isPremium = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    changeLoading();
    await getOnboarding();
    await createOnboarding();
    await getPremium();
    await createPremium();
    changeLoading();
  }

  Future<void> createOnboarding() async {
    if (onboardingBox.isEmpty) {
      await _onboardingLocalDatasource.create(OnboardingModel(isSee: false));
    }
  }

  Future<void> createPremium() async {
    if (premiumBox.isEmpty) {
      await _premiumLocalDatasource.create(PremiumModel(isPremium: false));
    }
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getOnboarding() async {
    if (onboardingBox.isNotEmpty) {
      var result = await _onboardingLocalDatasource.get();
      if (result.success) {
        var data = result.data;
        setState(() {
          onboardingSaw = data!.isSee!;
        });
      }
    }
  }

  Future<void> getPremium() async {
    if (premiumBox.isNotEmpty) {
      var result = await _premiumLocalDatasource.get();
      if (result.success) {
        var data = result.data;
        isPremium = data!.isPremium!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox.expand()
        : onboardingSaw
            ? isPremium
                ? HomeView()
                : InAppView(openedFromOnboarding: false)
            : const OnboardingView();
  }
}
