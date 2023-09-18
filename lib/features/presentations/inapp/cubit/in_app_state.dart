part of 'in_app_cubit.dart';

enum InAppStatus {
  init,
  loading,
  success,
  error,
}

class InAppState extends Equatable {
  final InAppStatus status;
  final Premium selectedPremium;

  const InAppState({
    required this.status,
    required this.selectedPremium,
  });

  InAppState copyWith({
    InAppStatus? status,
    Premium? selectedPremium,
  }) {
    return InAppState(
      status: status ?? this.status,
      selectedPremium: selectedPremium ?? this.selectedPremium,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedPremium,
      ];
}
