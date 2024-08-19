import 'package:flutter/material.dart';

import '../timeSlotPopup/view.dart';


class SeminarHallScreen extends StatefulWidget {

  final bool isEditable;
  const SeminarHallScreen({super.key, required this.isEditable});
  @override
  _SeminarHallScreenState createState() => _SeminarHallScreenState();
}

class _SeminarHallScreenState extends State<SeminarHallScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 45);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 45);

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
          if (_compareTime(startTime, endTime) >= 0) {
            endTime =
                TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
          }
        } else {
          if (_compareTime(startTime, picked) < 0) {
            endTime = picked;
          }
        }
      });
    }
  }

  int _compareTime(TimeOfDay startTime, TimeOfDay endTime) {
    final now = DateTime.now();
    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );
    final endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      endTime.hour,
      endTime.minute,
    );
    return startDateTime.compareTo(endDateTime);
  }

  double _calculateDuration() {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    final durationMinutes = endMinutes - startMinutes;
    return durationMinutes / 60.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Row(
          children: [
            Text('Selected Date:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DateSelectorWithIcon(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Text('Time:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => _selectTime(context, true),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                    ),
                    child: Text(
                      startTime.format(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const Text(' - '),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => _selectTime(context, false),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                    ),
                    child: Text(
                      endTime.format(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Text(
          'Duration: ${_calculateDuration().toStringAsFixed(1)} hrs',
          style: const TextStyle(fontSize: 16),
        ),
            )
          ],
        ),
      ],
    );
  }
}