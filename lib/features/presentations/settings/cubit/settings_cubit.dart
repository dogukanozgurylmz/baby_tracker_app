import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required PremiumLocalDatasource premiumLocalDatasource,
  })  : _premiumLocalDatasource = premiumLocalDatasource,
        super(
          const SettingsState(
            status: SettingsStatus.init,
            isPremium: false,
          ),
        ) {
    getPremium();
  }

  final PremiumLocalDatasource _premiumLocalDatasource;

  Future<void> getPremium() async {
    if (premiumBox.isNotEmpty) {
      var result = await _premiumLocalDatasource.get();
      if (result.success) {
        var data = result.data;
        emit(state.copyWith(isPremium: data!.isPremium));
      }
    }
  }
}
