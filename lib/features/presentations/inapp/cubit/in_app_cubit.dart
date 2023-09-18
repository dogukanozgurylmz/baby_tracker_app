import 'package:baby_tracker_app/features/core/enums/premium_enum.dart';
import 'package:baby_tracker_app/features/data/datasources/local/premium_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/premium_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'in_app_state.dart';

class InAppCubit extends Cubit<InAppState> {
  InAppCubit({
    required PremiumLocalDatasource premiumLocalDatasource,
  })  : _premiumLocalDatasource = premiumLocalDatasource,
        super(
          const InAppState(
            status: InAppStatus.init,
            selectedPremium: Premium.empty,
          ),
        );

  final PremiumLocalDatasource _premiumLocalDatasource;

  void selectPremium(Premium premium) {
    emit(state.copyWith(selectedPremium: premium));
  }

  Future<void> updatePremium() async {
    await _premiumLocalDatasource.update(PremiumModel(isPremium: true));
  }
}
