import 'package:baby_tracker_app/features/core/enums/diaper_status.dart';
import 'package:baby_tracker_app/features/data/datasources/local/diaper_change_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/diaper_change_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'diaper_change_state.dart';

class DiaperChangeCubit extends Cubit<DiaperChangeState> {
  DiaperChangeCubit(
      {required DiaperChangeLocalDatasource diaperChangeLocalDatasource})
      : _diaperChangeLocalDatasource = diaperChangeLocalDatasource,
        super(
          DiaperChangeState(
            status: DiaperChangeStatus.init,
            selectedTime: DateTime.now(),
            buttonIsNull: true,
            selectedDiaper: DiaperStatus.empty,
          ),
        );

  final DiaperChangeLocalDatasource _diaperChangeLocalDatasource;

  //controllers
  TextEditingController timeTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  ///for choose time
  ///DateFormat("hh:mm a")
  void selectTime(DateTime date) {
    var format = DateFormat("hh:mm a");
    var dateString = format.format(date);
    timeTextController.text = dateString;
    emit(state.copyWith(selectedTime: date));
  }

  ///for choose diaper status
  void selectDiaper(DiaperStatus diaperStatus) {
    emit(state.copyWith(selectedDiaper: diaperStatus));
  }

  Future<void> createDiaperChange() async {
    var uuid = const Uuid();
    DiaperChangeModel diaperChangeModel = DiaperChangeModel(
      id: uuid.v4(),
      diaperStatus: state.selectedDiaper.name,
      time: state.selectedTime,
    );
    await _diaperChangeLocalDatasource.create(diaperChangeModel);
  }

  ///null control for button
  void nullControle() {
    var result1 =
        timeTextController.text.isEmpty || noteTextController.text.isEmpty;
    var result2 =
        timeTextController.text == "" || noteTextController.text == "";
    if (result1 || result2 || state.selectedDiaper == DiaperStatus.empty) {
      emit(state.copyWith(buttonIsNull: true));
    } else {
      emit(state.copyWith(buttonIsNull: false));
    }
  }
}
