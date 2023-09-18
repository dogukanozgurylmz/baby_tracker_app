part of 'feeding_cubit.dart';

enum FeedingStatus {
  init,
  loading,
  success,
  error,
}

class FeedingState extends Equatable {
  final FeedingStatus status;
  final DateTime selectedTime;
  final bool buttonIsNull;

  const FeedingState({
    required this.status,
    required this.selectedTime,
    required this.buttonIsNull,
  });

  FeedingState copyWith({
    FeedingStatus? status,
    DateTime? selectedTime,
    bool? buttonIsNull,
  }) {
    return FeedingState(
      status: status ?? this.status,
      selectedTime: selectedTime ?? this.selectedTime,
      buttonIsNull: buttonIsNull ?? this.buttonIsNull,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedTime,
        buttonIsNull,
      ];
}
