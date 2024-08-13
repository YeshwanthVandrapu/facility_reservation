import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

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
  String? attendeeCapacity;
  String? facilityStatus;
  String? facilityType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      child: Responsive(children: <Widget>[
        Div(
          divison: const Division(
            colL: 3,
            colM: 4,
            colS: 12,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 48, top: 24,right: 0,bottom: 0),
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
            padding: const EdgeInsets.only(left: 42, top: 24,right: 0,bottom: 0),
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
            padding: const EdgeInsets.only(left: 42, top: 24,right: 0,bottom: 0),
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
            padding: const EdgeInsets.only(left: 48, top: 24,right: 48,bottom: 0),
            child: _buildDropdown('ATTENDEE CAPACITY', attendeeCapacity, (value) {
                  setState(() => attendeeCapacity = value);
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
            padding: const EdgeInsets.only(left: 48, top: 32,right: 0,bottom: 0),
            child: _buildDropdown('FACILITY STATUS',  facilityStatus, (value) {
                  setState(() =>  facilityStatus = value);
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
            padding: const EdgeInsets.only(left: 42, top: 32,right: 0,bottom: 0),
            child: _buildDropdown('FACILITY TYPE', facilityType, (value) {
                  setState(() => facilityType = value);
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
            padding: const EdgeInsets.only(left: 42, top: 32,right: 0,bottom: 0),
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
            padding: const EdgeInsets.only(left: 48, top: 32,right: 48,bottom: 0),
            child: ElevatedButton(
              onPressed: () {
                // Handle search
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1E88E5),
                minimumSize: const Size.fromHeight(52),
                // padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), 
                ),
              ),
              child: const Text(style: TextStyle(color: Colors.white),'SEARCH'),
            ),
          ),
        ),  
        Container(
          margin: const EdgeInsets.only(left: 24,top: 16, bottom: 6),
          child: const Text(style: TextStyle(
            color: Color(0xFF92929D),
            fontSize: 12,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 0.09,
            ),"Note: Booking priority will be given to  academic uses first."),),    
      ],),
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