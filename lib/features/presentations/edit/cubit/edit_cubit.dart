import 'dart:typed_data';

import 'package:baby_tracker_app/features/core/enums/gender_enum.dart';
import 'package:baby_tracker_app/features/data/datasources/local/baby_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/baby_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit({
    required BabyLocalDatasource babyLocalDatasource,
  })  : _babyLocalDatasource = babyLocalDatasource,
        super(
          EditState(
            status: EditStatus.init,
            selectedDate: DateTime.now(),
            selectedTime: "",
            selectedDueTime: "",
            buttonIsNull: true,
            gender: Gender.empty,
            image: Uint8List(0),
            fullname: "",
          ),
        ) {
    init();
  }

  //for initialize when first opened
  Future<void> init() async {
    emit(state.copyWith(status: EditStatus.loading));
    await getBaby();
    emit(state.copyWith(status: EditStatus.success));
  }

  final BabyLocalDatasource _babyLocalDatasource;

  //controllers
  final TextEditingController birthDateTextController = TextEditingController();
  final TextEditingController fullNameTextController = TextEditingController();
  final TextEditingController timeOfBirthTextController =
      TextEditingController();
  final TextEditingController dueDateTextController = TextEditingController();
  final picker = ImagePicker();
  String _id = "";
  String message = "";

  void selectGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      emit(state.copyWith(image: imageBytes));
    }
  }

  void selectTime(DateTime date) {
    var format = DateFormat("hh:mm a");
    var dateString = format.format(date);
    timeOfBirthTextController.text = dateString;
    emit(state.copyWith(selectedTime: dateString));
  }

  void selectDueTime(DateTime date) {
    var format = DateFormat("hh:mm a");
    var dateString = format.format(date);
    dueDateTextController.text = dateString;
    emit(state.copyWith(selectedDueTime: dateString));
  }

  void selectDate(DateTime date) {
    var format = DateFormat("dd.MM.y");
    var dateString = format.format(date);
    birthDateTextController.text = dateString;
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> getBaby() async {
    var result = await _babyLocalDatasource.getBaby();
    if (result.success) {
      var data = result.data;
      _id = data!.id!;
      var format = DateFormat("dd.MM.y");
      var dateString = format.format(data.birthDate!);
      fullNameTextController.text = data.fullName!;
      birthDateTextController.text = dateString;
      dueDateTextController.text = data.dueDate!;
      timeOfBirthTextController.text = data.timeOfBirth!;

      emit(
        state.copyWith(
          gender: Gender.values.firstWhere((e) => e.name == data.gender),
          image: data.image,
          selectedDate: data.birthDate,
          selectedTime: data.timeOfBirth,
          selectedDueTime: data.dueDate,
          fullname: data.fullName,
        ),
      );
    }
  }

  Future<void> updateBaby() async {
    BabyModel babyModel = BabyModel(
      id: _id,
      fullName: fullNameTextController.text.trim(),
      birthDate: state.selectedDate,
      timeOfBirth: state.selectedTime,
      dueDate: state.selectedDueTime,
      image: state.image,
      gender: state.gender.name,
    );
    var result = await _babyLocalDatasource.update(babyModel);
    if (!result.success) {
      message = result.message!;
    }
    // emit(state.copyWith(message: result.message));
  }
}
