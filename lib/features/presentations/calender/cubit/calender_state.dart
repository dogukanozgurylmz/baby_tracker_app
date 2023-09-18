part of 'calender_cubit.dart';

enum CalenderStatus {
  init,
  loading,
  success,
  error,
}

class CalenderState extends Equatable {
  final CalenderStatus status;
  final List<DiaperChangeModel> diaperChanges;
  final List<FeedingModel> feedings;
  final List<SleepModel> sleeps;
  final List<dynamic> all;
  final int tabIndex;

  const CalenderState({
    required this.status,
    required this.feedings,
    required this.sleeps,
    required this.diaperChanges,
    required this.all,
    required this.tabIndex,
  });

  CalenderState copyWith({
    CalenderStatus? status,
    List<DiaperChangeModel>? diaperChanges,
    List<FeedingModel>? feedings,
    List<SleepModel>? sleeps,
    List<dynamic>? all,
    int? tabIndex,
  }) {
    return CalenderState(
      status: status ?? this.status,
      sleeps: sleeps ?? this.sleeps,
      feedings: feedings ?? this.feedings,
      diaperChanges: diaperChanges ?? this.diaperChanges,
      all: all ?? this.all,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  @override
  List<Object> get props => [
        status,
        feedings,
        diaperChanges,
        sleeps,
        all,
        tabIndex,
      ];
}
