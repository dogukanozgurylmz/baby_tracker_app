import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../data/datasources/local/sleep_local_datasource.dart';
import '../../../data/models/sleep_model.dart';

part 'sleep_state.dart';

class SleepCubit extends Cubit<SleepState> {
  SleepCubit({required SleepLocalDatasource sleepLocalDatasource})
      : _sleepLocalDatasource = sleepLocalDatasource,
        super(
          SleepState(
            status: SleepStatus.init,
            selectedFellSleep: DateTime.now(),
            buttonIsNull: true,
            selectedWakeUp: DateTime.now(),
          ),
        );

  final SleepLocalDatasource _sleepLocalDatasource;

  TextEditingController fellSleepTextController = TextEditingController();
  TextEditingController wakeUpTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  void selectFellSleep(DateTime date) {
    var format = DateFormat("hh:mm a");
    var dateString = format.format(date);
    fellSleepTextController.text = dateString;
    emit(state.copyWith(selectedFellSleep: date));
  }

  void selectWakeUp(DateTime date) {
    var format = DateFormat("hh:mm a");
    var dateString = format.format(date);
    wakeUpTextController.text = dateString;
    emit(state.copyWith(selectedWakeUp: date));
  }

  Future<void> createSleep() async {
    var uuid = const Uuid();
    SleepModel sleepModel = SleepModel(
      id: uuid.v4(),
      wakeUp: state.selectedWakeUp,
      fellSleep: state.selectedFellSleep,
      note: noteTextController.text.trim(),
    );
    await _sleepLocalDatasource.create(sleepModel);
  }

  void nullControle() {
    var result1 = fellSleepTextController.text.isEmpty ||
        wakeUpTextController.text.isEmpty ||
        noteTextController.text.isEmpty;
    var result2 = fellSleepTextController.text == "" ||
        wakeUpTextController.text == "" ||
        noteTextController.text == "";
    if (result1 || result2) {
      emit(state.copyWith(buttonIsNull: true));
    } else {
      emit(state.copyWith(buttonIsNull: false));
    }
  }
}
