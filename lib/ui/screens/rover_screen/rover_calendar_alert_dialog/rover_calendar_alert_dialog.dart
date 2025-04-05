// lib/ui/components/rover/rover_calendar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../../../utils/app_colors.dart';

class RoverCalendar extends StatefulWidget {
  final String roverName;

  const RoverCalendar({super.key, required this.roverName});

  @override
  State<RoverCalendar> createState() => _RoverCalendarState();
}

class _RoverCalendarState extends State<RoverCalendar> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    //Load manifest data if not already loaded
    context
        .read<RoverManifestBloc>()
        .add(LoadRoverManifest(roverName: widget.roverName));
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoverManifestBloc, RoverManifestState>(
      builder: (context, state) {
        // Check if we have the correct manifest data
        final hasCorrectManifest = state.roverManifestModel != null &&
            state.roverName == widget.roverName;
        if (!hasCorrectManifest ||
            state.status != RoverManifestStatus.success) {
          debugPrint(
              "state.status != RoverManifestStatus.success || state.roverManifestModel == null || state.roverName != widget.roverName");
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Loading ${widget.roverName} data...',
                  style: const TextStyle(color: Colors.white),
                ),
                if (state.status == RoverManifestStatus.failure)
                  Text(
                    'Error : ${state.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );
        }

        final manifest = state.roverManifestModel!;
        final landingDate = DateTime.parse(manifest.landingDate);
        final maxDate = DateTime.parse(manifest.maxDate);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                firstDay: landingDate,
                lastDay: maxDate,
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: const TextStyle(color: Colors.white),
                  weekendTextStyle: const TextStyle(color: Colors.white),
                  outsideTextStyle:
                      TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  leftChevronIcon:
                      const Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.white),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  Navigator.pop(context, selectedDay);
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Available from ${DateFormat.yMMMd().format(landingDate)} to ${DateFormat.yMMMd().format(maxDate)}',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        );
      },
    );
  }

  // Add this to the same file or a separate helper file
  Future<DateTime?> showRoverCalendarDialog({
    required BuildContext context,
    required String roverName,
  }) async {
    return await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: RoverCalendar(roverName: roverName),
        );
      },
    );
  }
}

// Add this to the same file or a separate helper file
Future<DateTime?> showRoverCalendarDialog({
  required BuildContext context,
  required String roverName,
}) async {
  return await showDialog<DateTime>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: RoverCalendar(roverName: roverName),
      );
    },
  );
}
