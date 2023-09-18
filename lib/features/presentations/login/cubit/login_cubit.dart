import 'dart:typed_data';

import 'package:baby_tracker_app/features/core/enums/gender_enum.dart';
import 'package:baby_tracker_app/features/data/datasources/local/baby_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/onboarding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/models/baby_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/onboarding_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required BabyLocalDatasource babyLocalDatasource,
    required OnboardingLocalDatasource onboardingLocalDatasource,
  })  : _babyLocalDatasource = babyLocalDatasource,
        _onboardingLocalDatasource = onboardingLocalDatasource,
        super(
          LoginState(
            status: LoginStatus.init,
            selectedDate: DateTime.now(),
            selectedTime: "",
            selectedDueTime: "",
            buttonIsNull: true,
            gender: Gender.empty,
            image: Uint8List(0),
            message: "",
          ),
        );

  final BabyLocalDatasource _babyLocalDatasource;
  final OnboardingLocalDatasource _onboardingLocalDatasource;

  TextEditingController birthDateTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController timeOfBirthTextController = TextEditingController();
  TextEditingController dueDateTextController = TextEditingController();
  final picker = ImagePicker();

  void selectDate(DateTime date) {
    var format = DateFormat("dd.MM.y");
    var dateString = format.format(date);
    birthDateTextController.text = dateString;
    emit(state.copyWith(selectedDate: date));
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

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      emit(state.copyWith(image: imageBytes));
    }
  }

  void nullControle() {
    var result1 = birthDateTextController.text.isEmpty ||
        fullNameTextController.text.isEmpty ||
        timeOfBirthTextController.text.isEmpty ||
        dueDateTextController.text.isEmpty;
    var result2 = birthDateTextController.text == "" ||
        fullNameTextController.text == "" ||
        timeOfBirthTextController.text == "" ||
        dueDateTextController.text == "";

    var result3 = state.selectedTime == "" || state.selectedDueTime == "";
    if (result1 ||
        result2 ||
        result3 ||
        state.gender == Gender.empty ||
        state.image.isEmpty) {
      emit(state.copyWith(buttonIsNull: true));
    } else {
      emit(state.copyWith(buttonIsNull: false));
    }
  }

  void selectGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  Future<void> createBaby() async {
    var uuid = const Uuid();
    BabyModel babyModel = BabyModel(
      id: uuid.v4(),
      fullName: fullNameTextController.text.trim(),
      birthDate: state.selectedDate,
      timeOfBirth: timeOfBirthTextController.text,
      dueDate: dueDateTextController.text,
      image: state.image,
      gender: state.gender.name,
    );
    var result = await _babyLocalDatasource.create(babyModel);
    emit(state.copyWith(message: result.message));
  }

  Future<void> updateOnboarding() async {
    await _onboardingLocalDatasource.update(OnboardingModel(isSee: true));
  }
}
