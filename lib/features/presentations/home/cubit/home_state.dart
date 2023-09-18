part of 'home_cubit.dart';

enum HomeStatus {
  init,
  loading,
  success,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final BabyModel babyModel;
  final String afterBirthDay;
  final bool isPremium;

  const HomeState({
    required this.status,
    required this.babyModel,
    required this.afterBirthDay,
    required this.isPremium,
  });

  HomeState copyWith({
    HomeStatus? status,
    BabyModel? babyModel,
    String? afterBirthDay,
    bool? isPremium,
  }) {
    return HomeState(
      status: status ?? this.status,
      babyModel: babyModel ?? this.babyModel,
      afterBirthDay: afterBirthDay ?? this.afterBirthDay,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  List<Object> get props => [
        status,
        babyModel,
        afterBirthDay,
        isPremium,
      ];
}
