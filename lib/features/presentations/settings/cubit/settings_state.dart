part of 'settings_cubit.dart';

enum SettingsStatus {
  init,
  loading,
  success,
  error,
}

class SettingsState extends Equatable {
  final SettingsStatus status;
  final bool isPremium;

  const SettingsState({
    required this.status,
    required this.isPremium,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    bool? isPremium,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  List<Object> get props => [
        status,
        isPremium,
      ];
}
