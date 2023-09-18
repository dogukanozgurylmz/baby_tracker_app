part of 'diaper_change_cubit.dart';

enum DiaperChangeStatus {
  init,
  loading,
  success,
  error,
}

class DiaperChangeState extends Equatable {
  final DiaperChangeStatus status;
  final DateTime selectedTime;
  final bool buttonIsNull;
  final DiaperStatus selectedDiaper;

  const DiaperChangeState({
    required this.status,
    required this.selectedTime,
    required this.buttonIsNull,
    required this.selectedDiaper,
  });

  DiaperChangeState copyWith({
    DiaperChangeStatus? status,
    DateTime? selectedTime,
    bool? buttonIsNull,
    DiaperStatus? selectedDiaper,
  }) {
    return DiaperChangeState(
      status: status ?? this.status,
      selectedTime: selectedTime ?? this.selectedTime,
      buttonIsNull: buttonIsNull ?? this.buttonIsNull,
      selectedDiaper: selectedDiaper ?? this.selectedDiaper,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedTime,
        buttonIsNull,
        selectedDiaper,
      ];
}
