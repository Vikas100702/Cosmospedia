import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../blocs/rover/rover_bloc.dart';
import '../../../../blocs/rover_manifest/rover_manifest_bloc.dart';
import '../../../../data/models/mars/rover_manifest.dart';
import '../../../../data/repositories/mars/rover_repositories.dart';
import '../../../../utils/app_colors.dart';
import '../rover_photos_grid/rover_photos_grid.dart';

class RoverCalendar extends StatefulWidget {
  final String roverName;
  final RoverManifestModel? initialManifest;

  const RoverCalendar({
    super.key,
    required this.roverName,
    this.initialManifest,
  });

  @override
  State<RoverCalendar> createState() => _RoverCalendarState();
}

class _RoverCalendarState extends State<RoverCalendar> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final maxDate = widget.initialManifest != null
        ? DateTime.parse(widget.initialManifest!.maxDate)
        : null;

    _focusedDay = maxDate != null && now.isAfter(maxDate) ? maxDate : now;
  }

  @override
  Widget build(BuildContext context) {
    final manifest = widget.initialManifest ??
        context.select<RoverManifestBloc, RoverManifestModel?>(
              (bloc) => bloc.state.roverName == widget.roverName
              ? bloc.state.roverManifestModel
              : null,
        );

    final isLoading = widget.initialManifest == null &&
        context.select<RoverManifestBloc, bool>(
              (bloc) =>
          bloc.state.roverName == widget.roverName &&
              bloc.state.status == RoverManifestStatus.loading,
        );

    final error = widget.initialManifest == null
        ? context.select<RoverManifestBloc, String?>(
          (bloc) => bloc.state.roverName == widget.roverName
          ? bloc.state.error
          : null,
    )
        : null;

    if (isLoading) {
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
          ],
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (manifest == null) {
      return const Center(
        child: Text(
          'No manifest data available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final landingDate = DateTime.parse(manifest.landingDate);
    final maxDate = DateTime.parse(manifest.maxDate);

    if (_focusedDay.isAfter(maxDate)) {
      _focusedDay = maxDate;
    }

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
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(color: Colors.white),
              weekendTextStyle: const TextStyle(color: Colors.white),
              outsideTextStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.white),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              _showPhotosForDate(selectedDay, context);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Available from ${DateFormat.yMMMd().format(landingDate)} '
                'to ${DateFormat.yMMMd().format(maxDate)}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  void _showPhotosForDate(DateTime selectedDate, BuildContext context) {
    // Format the date correctly as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    /*// Close the calendar dialog first
    Navigator.pop(context);*/

    // Then open the photos grid with the selected date
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => RoverBloc(
            roverRepository: context.read<RoverRepository>(),
          )..add(LoadRoverData(
            roverName: widget.roverName.toLowerCase(),
            earthDate: formattedDate, // Pass the formatted date here
          )),
          child: RoverPhotosGrid(
            roverName: widget.roverName,
            selectedDate: selectedDate,
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> showRoverCalendarDialog({
  required BuildContext context,
  required String roverName,
  RoverManifestModel? manifest,
}) async {
  return await showDialog<DateTime>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: RoverCalendar(
          roverName: roverName,
          initialManifest: manifest,
        ),
      );
    },
  );
}