import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../datatable/test.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {

  String? selectedBuilding;
  String? selectedFloor;
  String? selectedRoom;
  DateTime? startDateTime;
  DateTime? endDateTime;
  int? attendeeCapacity;

  @override
  Widget build(BuildContext context) {
    return Responsive(children: <Widget>[
      Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown('SELECT BUILDING', selectedBuilding, (value) {
                setState(() => selectedBuilding = value);
              }),
        ), 
        ),
        Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown('SELECT FLOOR', selectedFloor, (value) {
                setState(() => selectedFloor = value);
              }),
        ),
        ),
        Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown('SELECT ROOM', selectedRoom, (value) {
                setState(() => selectedRoom = value);
              }),
        ),
        ),
         Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown('ATTENDEE CAPACITY', selectedRoom, (value) {
                setState(() => selectedRoom = value);
              }),
        ),
        ),
        Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown('FACILITY STATUS', selectedRoom, (value) {
                setState(() => selectedRoom = value);
              }),
        ),
        ),
        Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown('FACILITY TYPE', selectedRoom, (value) {
                setState(() => selectedRoom = value);
              }),
        ),
        ),
        Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDateTimePicker('Start Date & Time', startDateTime, (value) {
                setState(() => startDateTime = value);
              }),
        ),
        ),
        Div(
        divison: const Division(
          colL: 3,
          colM: 4,
          colS: 12,
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle search
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              // padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), 
              ),
            ),
            child: const Text('SEARCH'),
          ),
        ),

      ),  
        
    ]);
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