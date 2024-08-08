import 'package:flutter/material.dart';

class RoomBookingPage extends StatefulWidget {
  const RoomBookingPage({super.key});

  @override
  _RoomBookingPageState createState() => _RoomBookingPageState();
}

class _RoomBookingPageState extends State<RoomBookingPage> {
  String? selectedBuilding;
  String? selectedFloor;
  String? selectedRoom;
  DateTime? startDateTime;
  DateTime? endDateTime;
  int? attendeeCapacity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdown('SELECT BUILDING', selectedBuilding, (value) {
              setState(() => selectedBuilding = value);
            }),
            const SizedBox(height: 16),
            _buildDropdown('SELECT FLOOR', selectedFloor, (value) {
              setState(() => selectedFloor = value);
            }),
            const SizedBox(height: 16),
            _buildDropdown('SELECT ROOM', selectedRoom, (value) {
              setState(() => selectedRoom = value);
            }),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'ATTENDEE CAPACITY',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() => attendeeCapacity = int.tryParse(value));
              },
            ),
            const SizedBox(height: 16),
            _buildButton('FACILITY STATUS', () {
              // Handle facility status
            }),
            const SizedBox(height: 16),
            _buildButton('FACILITY TYPE', () {
              // Handle facility type
            }),
            const SizedBox(height: 16),
            _buildDateTimePicker('Start Date & Time', startDateTime, (value) {
              setState(() => startDateTime = value);
            }),
            const SizedBox(height: 16),
            _buildDateTimePicker('End Date & Time', endDateTime, (value) {
              setState(() => endDateTime = value);
            }),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle search
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('SEARCH'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, String? value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        border: const OutlineInputBorder(),
      ),
      value: value,
      onChanged: onChanged,
      items: const [
        DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
        DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
        // Add more options as needed
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(label),
    );
  }

  Widget _buildDateTimePicker(String label, DateTime? dateTime, ValueChanged<DateTime?> onChanged) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(dateTime ?? DateTime.now()),
          );
          if (time != null) {
            onChanged(DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            ));
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          dateTime != null
              ? '${dateTime.toLocal().toString().split(' ')[0]} ${TimeOfDay.fromDateTime(dateTime).format(context)}'
              : 'Select Date and Time',
        ),
      ),
    );
  }
}