import 'dart:typed_data';

import 'package:baby_tracker_app/features/core/hive/hive_box.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/baby_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/models/baby_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/local/premium_local_datasource.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required BabyLocalDatasourceImpl babyLocalDatasourceImpl,
    required PremiumLocalDatasource premiumLocalDatasource,
  })  : _babyLocalDatasourceImpl = babyLocalDatasourceImpl,
        _premiumLocalDatasource = premiumLocalDatasource,
        super(
          HomeState(
            status: HomeStatus.init,
            babyModel: BabyModel(
              id: "id",
              fullName: "fullName",
              birthDate: DateTime.now(),
              timeOfBirth: "timeOfBirth",
              dueDate: "dueDate",
              image: Uint8List(0),
              gender: "",
            ),
            afterBirthDay: "",
            isPremium: false,
          ),
        ) {
    init();
  }

  //for initialize when first opened
  Future<void> init() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await getBaby();
    afterBirthDate();
    await getPremium();
    emit(state.copyWith(status: HomeStatus.success));
  }

  final BabyLocalDatasourceImpl _babyLocalDatasourceImpl;
  final PremiumLocalDatasource _premiumLocalDatasource;

  String ageAsString = "";

  Future<void> getBaby() async {
    var result = await _babyLocalDatasourceImpl.getBaby();
    emit(state.copyWith(babyModel: result.data));
  }

  Future<void> getPremium() async {
    if (premiumBox.isNotEmpty) {
      var result = await _premiumLocalDatasource.get();
      if (result.success) {
        var data = result.data;
        emit(state.copyWith(isPremium: data!.isPremium));
      }
    }
  }

  //for calculate the age
  String calculateAgeAsString(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;
    if (days < 0) {
      months--;
      days += 30;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    List<String> parts = [];
    if (years > 0) {
      parts.add('$years years');
    }
    if (months > 0) {
      parts.add('$months months');
    }
    if (days > 0) {
      parts.add('$days days');
    }
    return parts.join(' ');
  }

  void afterBirthDate() {
    ageAsString = calculateAgeAsString(state.babyModel.birthDate!);
  }
}
