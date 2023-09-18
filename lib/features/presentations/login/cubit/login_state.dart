part of 'login_cubit.dart';

enum LoginStatus {
  init,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedDueTime;
  final bool buttonIsNull;
  final Gender gender;
  final Uint8List image;
  final String message;

  const LoginState({
    required this.status,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedDueTime,
    required this.buttonIsNull,
    required this.gender,
    required this.image,
    required this.message,
  });

  LoginState copyWith({
    LoginStatus? status,
    DateTime? selectedDate,
    String? selectedTime,
    String? selectedDueTime,
    bool? buttonIsNull,
    Gender? gender,
    Uint8List? image,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDueTime: selectedDueTime ?? this.selectedDueTime,
      buttonIsNull: buttonIsNull ?? this.buttonIsNull,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedDate,
        selectedTime,
        selectedDueTime,
        buttonIsNull,
        gender,
        image,
        message,
      ];
}
