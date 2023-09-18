import 'package:baby_tracker_app/features/data/datasources/local/feeding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/feeding_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'feeding_state.dart';

class FeedingCubit extends Cubit<FeedingState> {
  FeedingCubit({required FeedingLocalDatasource feedingLocalDatasource})
      : _feedingLocalDatasource = feedingLocalDatasource,
        super(
          FeedingState(
            status: FeedingStatus.init,
            selectedTime: DateTime.now(),
            buttonIsNull: true,
          ),
        );

  final FeedingLocalDatasource _feedingLocalDatasource;

  //controllers
  final TextEditingController timeTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();

  ///for choose time
  ///DateFormat("hh:mm a")
  void selectTime(DateTime date) {
    var format = DateFormat("hh:mm a");
    var dateString = format.format(date);
    timeTextController.text = dateString;
    emit(state.copyWith(selectedTime: date));
  }

  Future<void> createFeeding() async {
    var uuid = const Uuid();
    FeedingModel feedingModel = FeedingModel(
      id: uuid.v4(),
      note: noteTextController.text.trim(),
      time: state.selectedTime,
      amount: int.parse(amountTextController.text),
    );
    await _feedingLocalDatasource.create(feedingModel);
  }

  ///null control for button
  void nullControl() {
    var result1 = timeTextController.text.isEmpty ||
        amountTextController.text.isEmpty ||
        noteTextController.text.isEmpty;
    var result2 = timeTextController.text == "" ||
        amountTextController.text == "" ||
        noteTextController.text == "";
    if (result1 || result2) {
      emit(state.copyWith(buttonIsNull: true));
    } else {
      emit(state.copyWith(buttonIsNull: false));
    }
  }
}
