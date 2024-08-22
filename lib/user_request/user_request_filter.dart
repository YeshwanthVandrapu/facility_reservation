// import 'package:facility_reservation/state_management/user_booking_state.dart';
import 'package:facility_reservation/state_management/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'user_request_table.dart';

class UserRequestFilter extends StatefulWidget {
  const UserRequestFilter({super.key});

  @override
  State<UserRequestFilter> createState() => _UserRequestFilterState();
}

class _UserRequestFilterState extends State<UserRequestFilter> {
  String? selectedBuilding;
  String? selectedFloor;
  String? selectedRoom;
  DateTime? startDateTime;
  DateTime? endDateTime;
  String? facilityStatus;

  final Map<String, List<String>> buildingFloors = {
    'JSW Academic Block': ['Ground Floor', 'First Floor', 'Second Floor', 'Third Floor'],
    'New Academic Block': ['Ground Floor', 'First Floor'],
    'Library': ['First Floor'],
  };

  final Map<String, List<String>> floorRooms = {
    'JSW Academic Block Ground Floor': ['Seminar Hall-1', 'Seminar Hall-2', 'Seminar Hall-3'],
    'JSW Academic Block First Floor': ['1A', '1B', '1C','1D','1E','Trading Floor','1G'],
    'JSW Academic Block Second Floor': ['Room 1', 'Room 2', 'Room 3'],
    'JSW Academic Block Third Floor': ['Room 1', 'Room 2', 'Room 3'],
    'New Academic Block Ground Floor': ['Room 1', 'Room 2', 'Room 3'],
    'New Academic Block First Floor': ['Room 1', 'Room 2', 'Room 3'],
    'Library First Floor': ['M-1', 'M-2', 'M-3'],
  };

  @override
  Widget build(BuildContext context) {
    
    return Consumer<MyState>(
      builder: (context, myState,child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Reservations"),
            leading: IconButton(
          icon: const Icon(Icons.home), 
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Provider.of<MyState>(context, listen: false).toggleVisibility();
          },
        ),
          ),
          body: SingleChildScrollView(
            
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 1600,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
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
                              }, buildingFloors.keys.toList()),
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
                              }, _getAvailableFloors()),
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
                              });
                            }, _getAvailableRooms()),
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
                                ['Available', 'Not Available', 'Both'],
                              ),
                            ),
                          ),
                          MediaQuery.of(context).size.width >900? Div(
                            divison: const Division(
                              colL: 3,
                              colM: 6,
                              colS: 12,
                            ),
                            child: Container(),
                            ):const SizedBox.shrink(),
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
                              child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<MyState>(context, listen: false).toggleUserReq();
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
                           MediaQuery.of(context).size.width >900
                      ? Div(
                          divison: const Division(
                            colL: 3,
                            colM: 6,
                            colS: 12,
                          ),
                          child: Container(
                          ),
                        )
                      : const SizedBox.shrink()
                        ]),
                      ),
                    ),
                        myState.userReqVisible?
                        Container(
                          color: Colors.white,
                          // width: 1200,
                          child: const UserRequestTable(),
                          ):Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
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

  Widget _buildDropdown(String hint, String? value, ValueChanged<String?> onChanged, List<String> options,
      {bool isEnabled = true}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        border: const OutlineInputBorder(),
      ),
      value: value,
      onChanged: isEnabled ? onChanged : null,
      items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
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