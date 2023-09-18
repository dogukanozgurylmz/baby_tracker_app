part of 'edit_cubit.dart';

enum EditStatus {
  init,
  loading,
  success,
  error,
}

class EditState extends Equatable {
  final EditStatus status;
  final String fullname;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedDueTime;
  final bool buttonIsNull;
  final Gender gender;
  final Uint8List image;

  const EditState({
    required this.status,
    required this.fullname,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedDueTime,
    required this.buttonIsNull,
    required this.gender,
    required this.image,
  });

  EditState copyWith({
    EditStatus? status,
    String? fullname,
    DateTime? selectedDate,
    String? selectedTime,
    String? selectedDueTime,
    bool? buttonIsNull,
    Gender? gender,
    Uint8List? image,
  }) {
    return EditState(
      status: status ?? this.status,
      fullname: fullname ?? this.fullname,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDueTime: selectedDueTime ?? this.selectedDueTime,
      buttonIsNull: buttonIsNull ?? this.buttonIsNull,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props => [
        status,
        fullname,
        selectedDate,
        selectedTime,
        selectedDueTime,
        buttonIsNull,
        gender,
        image,
      ];
}
