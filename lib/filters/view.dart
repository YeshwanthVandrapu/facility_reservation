//TO DO : Handle error when user select room

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../state_management/state_provider.dart';

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

  void applyFilters() {
  final filters = {
    'building': selectedBuilding,
    'floor': selectedFloor,
    'room': selectedRoom,
    'attendeeCapacity': attendeeCapacity,
    'facilityStatus': facilityStatus,
    'facilityType': facilityType,
    'startDateTime': startDateTime,
  };
  Provider.of<MyState>(context, listen: false).setFilters(filters);
  Provider.of<MyState>(context, listen: false).toggleVisibility();
}

  final Map<String, List<String>> buildingFloors = {
    'JSW ACADEMIC BLOCK': ['Ground Floor', 'First Floor', 'Second Floor', 'Third Floor'],
    'New Academic Block': ['Ground Floor', 'First Floor'],
    'Library': ['First Floor'],
  };

  final Map<String, List<String>> floorRooms = {
    'JSW ACADEMIC BLOCK Ground Floor': ['Seminar Hall 1', 'Seminar Hall 2', 'Seminar Hall 3','Atrium L','Atrium R'],
    'JSW ACADEMIC BLOCK First Floor': ['Classroom 1A', 'Classroom 1B', 'Classroom 1C','Classroom 1D','Classroom 1E','Trading Floor','1G'],
    'JSW ACADEMIC BLOCK Second Floor': ['Room 1', 'Room 2', 'Room 3'],
    'JSW ACADEMIC BLOCK Third Floor': ['Room 1', 'Room 2', 'Room 3'],
    'New Academic Block Ground Floor': ['Room 1', 'Room 2', 'Room 3'],
    'New Academic Block First Floor': ['Room 1', 'Room 2', 'Room 3'],
    'Library First Floor': ['M-1', 'M-2', 'M-3'],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 8),
        child: Responsive(children: <Widget>[
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDropdown('SELECT BUILDING', selectedBuilding, (value) {
                setState(() {
                  selectedBuilding = value;
                  selectedFloor = null;
                  selectedRoom = null;
                });
              }, 
              Icons.location_city,
              buildingFloors.keys.toList()),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDropdown('SELECT FLOOR', selectedFloor, (value) {
                setState(() {
                  selectedFloor = value;
                  selectedRoom = null;
                });
              }, 
              Icons.stairs,
              _getAvailableFloors()),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDropdown('SELECT ROOM', selectedRoom, (value) {
                setState(() {
                  selectedRoom = value;
                  if (selectedRoom != null) {
                    attendeeCapacity = null;
                    facilityType = null;
                  }
                });
              }, 
              Icons.meeting_room,
              _getAvailableRooms()),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDropdown(
                'ATTENDEE CAPACITY',
                attendeeCapacity,
                (value) {
                  setState(() => attendeeCapacity = value);
                },
                Icons.people_alt_outlined,
                ['30', '60', '>60'],
                isEnabled: selectedRoom == null,
              ),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDropdown(
                'FACILITY STATUS',
                facilityStatus,
                (value) {
                  setState(() => facilityStatus = value);
                },
                Icons.event_available_outlined,
                ['Available', 'Not Available', 'Both'],
              ),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDropdown(
                'FACILITY TYPE',
                facilityType,
                (value) {
                  setState(() => facilityType = value);
                },
                Icons.border_all_outlined,
                ['Seminar Hall', 'Class Room'],
                isEnabled: selectedRoom == null,
              ),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDateTimePicker('Start Date & Time', startDateTime, (value) {
                setState(() => startDateTime = value);
              }),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildDateTimePicker('End Date & Time', startDateTime, (value) {
                setState(() => startDateTime = value);
              }),
            ),
          ),
          Div(
            divison: const Division(
              colL: 3,
              colM: 6,
              colS: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  applyFilters();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1E88E5),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(style: TextStyle(color: Colors.white), 'SEARCH'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, top: 16, bottom: 6),
            child: const Text(
              style: TextStyle(
                color: Color(0xFF92929D),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 0.09,
              ),
              "Note: Booking priority will be given to academic uses first.",
            ),
          ),
        ]),
      ),
    );
  }

  List<String> _getAvailableFloors() {
    if (selectedBuilding != null) {
      return buildingFloors[selectedBuilding!]!;
    }
    return buildingFloors.values.expand((floors) => floors).toList();
  }

  List<String> _getAvailableRooms() {
    if (selectedBuilding != null && selectedFloor != null) {
      return floorRooms['$selectedBuilding $selectedFloor']!;
    } else if (selectedBuilding != null) {
      return floorRooms.entries
          .where((entry) => entry.key.startsWith(selectedBuilding!))
          .expand((entry) => entry.value)
          .toList();
    } else if (selectedFloor != null) {
      return floorRooms.entries
          .where((entry) => entry.key.endsWith(selectedFloor!))
          .expand((entry) => entry.value)
          .toList();
    }
    return floorRooms.values.expand((rooms) => rooms).toList();
  }

  Widget _buildDropdown(String hint, String? value,
      ValueChanged<String?> onChanged, IconData icon, List<String> options,
      {bool isEnabled = true}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      value: value,
      onChanged: isEnabled ? onChanged : null,
      items: options
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
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
