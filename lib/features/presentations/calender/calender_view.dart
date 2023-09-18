import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:baby_tracker_app/features/core/constants/text_constant.dart';
import 'package:baby_tracker_app/features/data/datasources/local/diaper_change_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/feeding_local_datasource.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/diaper_change_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/feeding_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/datasources/local/impl/sleep_local_datasource_impl.dart';
import 'package:baby_tracker_app/features/data/models/diaper_change_model.dart';
import 'package:baby_tracker_app/features/data/models/feeding_model.dart';
import 'package:baby_tracker_app/features/data/models/sleep_model.dart';
import 'package:baby_tracker_app/features/presentations/calender/cubit/calender_cubit.dart';
import 'package:baby_tracker_app/features/presentations/calender/widgets/calender_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/datasources/local/sleep_local_datasource.dart';

class CalenderView extends StatelessWidget {
  final SleepLocalDatasource _sleepLocalDatasource = SleepLocalDatasourceImpl();
  final DiaperChangeLocalDatasource _diaperChangeLocalDatasource =
      DiaperChangeLocalDatasourceImpl();
  final FeedingLocalDatasource _feedingLocalDatasource =
      FeedingLocalDatasourceImpl();
  CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    var sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => CalenderCubit(
        sleepLocalDatasource: _sleepLocalDatasource,
        diaperChangeLocalDatasource: _diaperChangeLocalDatasource,
        feedingLocalDatasource: _feedingLocalDatasource,
      ),
      child: BlocBuilder<CalenderCubit, CalenderState>(
        builder: (context, state) {
          var cubit = context.read<CalenderCubit>();
          return DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              backgroundColor: ColorConstant.backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  TextConstant.calender,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 10),
                  TodayDateWidget(dateTime: dateTime),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          labelColor: ColorConstant.primaryColor,
                          unselectedLabelColor: ColorConstant.grey2,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          onTap: (value) {
                            //change index when to click
                            cubit.changeIndex(value);
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          tabs: [
                            const Tab(
                              child: Text(
                                TextConstant.all,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.74,
                                  letterSpacing: -0.50,
                                ),
                              ),
                            ),
                            Tab(
                              //feeding
                              child: Image.asset(state.tabIndex == 1
                                  ? "assets/app_icon/calender/calenderselected1.png"
                                  : "assets/app_icon/calender/calenderunselected1.png"),
                            ),
                            Tab(
                              //diaper change
                              child: Image.asset(state.tabIndex == 2
                                  ? "assets/app_icon/calender/calenderselected2.png"
                                  : "assets/app_icon/calender/calenderunselected2.png"),
                            ),
                            Tab(
                              //sleep
                              child: Image.asset(state.tabIndex == 3
                                  ? "assets/app_icon/calender/calenderselected3.png"
                                  : "assets/app_icon/calender/calenderunselected3.png"),
                            ),
                          ],
                        ),
                        _tabContentBuilder(sizeOf, state, cubit),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _tabContentBuilder(
      Size sizeOf, CalenderState state, CalenderCubit cubit) {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          _allListViewBuilder(state, cubit, sizeOf),
          _feedingListViewBuilder(state, cubit, sizeOf),
          _diaperChangeListViewBuilder(state, cubit, sizeOf),
          _sleepListViewBuilder(state, cubit, sizeOf),
        ],
      ),
    );
  }

  ListView _sleepListViewBuilder(
      CalenderState state, CalenderCubit cubit, Size sizeOf) {
    return ListView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: state.sleeps.length,
      itemBuilder: (context, index) {
        var sleep = state.sleeps[index];
        cubit.changeIndex(3);
        return CalenderCard(
          sizeOf: sizeOf,
          icon: Image.asset(
            "assets/app_icon/calender/calendersleep.png",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          category: TextConstant.sleep,
          date: DateFormat('E, MMM d').format(sleep.wakeUp!),
          time: DateFormat('hh:mm a').format(sleep.wakeUp!),
        );
      },
    );
  }

  ListView _diaperChangeListViewBuilder(
      CalenderState state, CalenderCubit cubit, Size sizeOf) {
    return ListView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: state.diaperChanges.length,
      itemBuilder: (context, index) {
        var diaperChange = state.diaperChanges[index];
        cubit.changeIndex(2);
        return CalenderCard(
          sizeOf: sizeOf,
          icon: Image.asset(
            "assets/app_icon/calender/calenderdiaper.png",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          category: TextConstant.diaperChange,
          date: DateFormat('E, MMM d').format(diaperChange.time!),
          time: DateFormat('hh:mm a').format(diaperChange.time!),
        );
      },
    );
  }

  ListView _feedingListViewBuilder(
      CalenderState state, CalenderCubit cubit, Size sizeOf) {
    return ListView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: state.feedings.length,
      itemBuilder: (context, index) {
        var feeding = state.feedings[index];
        cubit.changeIndex(1);
        return CalenderCard(
          sizeOf: sizeOf,
          icon: Image.asset(
            "assets/app_icon/calender/calenderfeeding.png",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          category: TextConstant.feeding,
          date: DateFormat('E, MMM d').format(feeding.time!),
          time: DateFormat('hh:mm a').format(feeding.time!),
        );
      },
    );
  }

  ListView _allListViewBuilder(
      CalenderState state, CalenderCubit cubit, Size sizeOf) {
    return ListView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: state.all.length,
      itemBuilder: (context, index) {
        var item = state.all[index];
        cubit.changeIndex(0);
        if (item is SleepModel) {
          return CalenderCard(
            sizeOf: sizeOf,
            icon: Image.asset(
              "assets/app_icon/calender/calendersleep.png",
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
            category: TextConstant.sleep,
            date: DateFormat('E, MMM d').format(item.wakeUp!),
            time: DateFormat('hh:mm a').format(item.wakeUp!),
          );
        }
        if (item is FeedingModel) {
          return CalenderCard(
            sizeOf: sizeOf,
            icon: Image.asset(
              "assets/app_icon/calender/calenderfeeding.png",
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
            category: TextConstant.feeding,
            date: DateFormat('E, MMM d').format(item.time!),
            time: DateFormat('hh:mm a').format(item.time!),
          );
        }
        if (item is DiaperChangeModel) {
          return CalenderCard(
            sizeOf: sizeOf,
            icon: Image.asset(
              "assets/app_icon/calender/calenderdiaper.png",
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
            category: TextConstant.diaperChange,
            date: DateFormat('E, MMM d').format(item.time!),
            time: DateFormat('hh:mm a').format(item.time!),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class TodayDateWidget extends StatelessWidget {
  const TodayDateWidget({
    super.key,
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('E, MMM d').format(dateTime),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ColorConstant.black,
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: -0.50,
      ),
    );
  }
}
