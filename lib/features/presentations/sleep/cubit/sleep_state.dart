part of 'Sleep_cubit.dart';

enum SleepStatus {
  init,
  loading,
  success,
  error,
}

class SleepState extends Equatable {
  final SleepStatus status;
  final DateTime selectedFellSleep;
  final DateTime selectedWakeUp;
  final bool buttonIsNull;

  const SleepState({
    required this.status,
    required this.selectedFellSleep,
    required this.selectedWakeUp,
    required this.buttonIsNull,
  });

  SleepState copyWith({
    SleepStatus? status,
    DateTime? selectedFellSleep,
    DateTime? selectedWakeUp,
    bool? buttonIsNull,
  }) {
    return SleepState(
      status: status ?? this.status,
      selectedFellSleep: selectedFellSleep ?? this.selectedFellSleep,
      selectedWakeUp: selectedWakeUp ?? this.selectedWakeUp,
      buttonIsNull: buttonIsNull ?? this.buttonIsNull,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedFellSleep,
        selectedWakeUp,
        buttonIsNull,
      ];
}
