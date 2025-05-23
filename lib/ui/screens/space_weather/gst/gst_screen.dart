import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cosmospedia/utils/app_colors.dart';

import '../../../../blocs/space_weather/gst/gst_bloc.dart';
import '../../../../data/models/space_weather/gst_model.dart';
import '../../../../data/repositories/space_weather/gst_repository.dart';

class GstScreen extends StatefulWidget {
  const GstScreen({super.key});

  @override
  State<GstScreen> createState() => _GstScreenState();
}

class _GstScreenState extends State<GstScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: isStartDate ? 'SELECT START DATE' : 'SELECT END DATE',
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          _endDate = picked;
          _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  void _fetchData() {
    if (_formKey.currentState!.validate()) {
      if (_startDate != null && _endDate != null) {
        if (_endDate!.isBefore(_startDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('End date must be after start date')),
          );
          return;
        }

        final dateDifference = _endDate!.difference(_startDate!).inDays;
        if (dateDifference > 30) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Date range should not exceed 30 days'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        context.read<GstBloc>().add(
          FetchGstEvents(
            startDate: _startDateController.text,
            endDate: _endDateController.text,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparentColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.png"),
            opacity: 0.4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => GstBloc(
              gstRepository: context.read<GstRepository>(),
            ),
            child: Column(
              children: [
                _buildDateInputForm(),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<GstBloc, GstState>(
                    builder: (context, state) {
                      if (state is GstInitial) {
                        return const Center(
                          child: Text(
                            'Please select date range to view geomagnetic storms',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is GstLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GstError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _fetchData,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else if (state is GstLoaded) {
                        return _buildGstList(state.gstEvents);
                      }
                      return const Center(child: Text('Unknown state'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateInputForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Date Range',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'For best results, choose a date range of 7-30 days. '
                    'Data is available from 2000 to present.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  labelStyle: const TextStyle(color: Colors.white70),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: () => _selectDate(context, true),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select start date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  labelStyle: const TextStyle(color: Colors.white70),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: () => _selectDate(context, false),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select end date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _fetchData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Fetch Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGstList(List<GstModel> gstEvents) {
    if (gstEvents.isEmpty) {
      return const Center(
        child: Text(
          'No geomagnetic storm events found for the selected date range',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      itemCount: gstEvents.length,
      itemBuilder: (context, index) {
        final event = gstEvents[index];
        return _buildGstCard(event);
      },
    );
  }

  Widget _buildGstCard(GstModel event) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final kpValues = event.allKpIndex.map((e) => e.kpIndex).toList();
    final maxKp = kpValues.reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.1),
      child: ExpansionTile(
        title: Text(
          'GST Event: ${dateFormat.format(event.startTime)}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Max Kp: $maxKp',
          style: const TextStyle(color: Colors.white70),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('GST ID:', event.gstID),
                _buildInfoRow('Start Time:', dateFormat.format(event.startTime)),
                _buildInfoRow('Submission Time:', dateFormat.format(event.submissionTime)),
                _buildInfoRow('Version ID:', event.versionId.toString()),
                const SizedBox(height: 8),
                const Text(
                  'Kp Index Values:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...event.allKpIndex.map((kp) => _buildKpIndexRow(kp)).toList(),
                if (event.linkedEvents != null && event.linkedEvents!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Linked Events:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...event.linkedEvents!.map((e) => _buildLinkedEventRow(e)).toList(),
                ],
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    // You can implement a webview or browser launch here
                  },
                  child: Text(
                    'More Info: ${event.link}',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpIndexRow(KpIndex kp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            DateFormat('HH:mm').format(kp.observedTime),
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(width: 16),
          Text(
            'Kp: ${kp.kpIndex}',
            style: TextStyle(
              color: _getKpColor(kp.kpIndex),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Source: ${kp.source}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedEventRow(LinkedEvent event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        event.activityID,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  Color _getKpColor(double kp) {
    if (kp >= 8) return Colors.red;
    if (kp >= 7) return Colors.orange;
    if (kp >= 6) return Colors.yellow;
    if (kp >= 5) return Colors.green;
    return Colors.white;
  }
}