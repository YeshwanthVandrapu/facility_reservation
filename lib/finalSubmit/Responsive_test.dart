import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../datePicker/view.dart';
import '../sfcalender/view.dart';
import '../time_selector/view.dart';
import '../user_request/user_request_filter.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  // bool hasSpecialNeeds = false;
  // TextEditingController bookingPurposeController = TextEditingController();
  String? selectedFloor;
  String? selectedRoom;
  String? selectedBuilding;
  DateTime? startDateTime;
  DateTime? endDateTime;
  bool hasSpecialNeeds = false;
  TextEditingController bookingPurposeController = TextEditingController();
  Map<String, String> dropdownValues = {};
  Map<String, TextEditingController> numberControllers = {};


  


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

  final List<String> dates =["21-08-2024","22-08-2024","23-08-2024","24-08-2024","25-08-2024","26-08-2024"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f7f7),
      appBar: AppBar(
        title: const Text("Final Submit Page"),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              width: 1600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    child: Image.asset(
                      'res/img/popupPic.png', 
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Responsive(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seminar Hall 1',
                          style: TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 32,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0.04,
                            ),
                        ),
                        const SizedBox(height: 16,),
                        Div(
                          divison: const Division(colS: 12),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Color(0xFF1E1E1E),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                  height: 1.5),
                              children: [
                                const TextSpan(text: 'Ground Floor | JSW Academic Block | '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.people,
                                    size: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const TextSpan(text: ' 100'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),  
                        const Div(
                          divison: Division(
                            colS: 12,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                           child:  RoomAvailability(),
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
                            child: _buildDateTimePicker('End Date & Time',endDateTime, (value) {
                              setState(() => endDateTime = value);
                            }),
                          ),
                        ),
                        const SizedBox(width: 16,),
                        TextField(
                          controller: bookingPurposeController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Please explain the purpose of this booking',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Note: Booking priority will be given to academic uses first.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text('Any Special Needs?'),
                            const SizedBox(width: 16),
                            DropdownButton<bool>(
                              value: hasSpecialNeeds,
                              onChanged: (value) {
                                setState(() {
                                  hasSpecialNeeds = value!;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: true, child: Text('Yes')),
                                DropdownMenuItem(value: false, child: Text('No')),
                              ],
                            ),
                          ],
                        ),
                        if (hasSpecialNeeds) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: Table(
                            border: TableBorder.all(color: Colors.grey[300]!),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                            },
                            children: [
                              _buildTableHeaderRow(),
                              _buildTableRow('MIC'),
                              _buildTableRow('Speaker'),
                              _buildTableRow('Projector'),
                              _buildTableRow('Chairs'),
                              _buildTableRow('Tables'),                      
                            ],
                          ),
                        ),
                      ],
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _showConfirmationDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D5CA4),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            ),
                            child: const Text('Submit Request', style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildDateTimePicker(String label, DateTime? dateTime, ValueChanged<DateTime?> onChanged) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: dateTime ?? DateTime.now(),
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

  Widget _buildDropdown1(String hint, String? value,
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

  TableRow _buildTableHeaderRow() {
  return TableRow(
    decoration: BoxDecoration(color: Colors.grey[200]),
    children: const [
      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold)))),
      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Select', style: TextStyle(fontWeight: FontWeight.bold)))),
      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)))),
    ],
  );
}

TableRow _buildTableRow(String label) {
  return TableRow(
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600),),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildDropdown(label),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildNumberField(label),
        ),
      ),
    ],
  );
}

 Widget _buildDropdown(String label) {
  return StatefulBuilder(
    builder: (context, setState) {
      return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _getDropdownValue(label),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _updateDropdownValue(label, newValue);
            });
            // Trigger a rebuild of the parent widget
            this.setState(() {});
          },
          items: ['Select', 'Yes', 'No']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );
    },
  );
}

  Widget _buildNumberField(String label) {
    return TextField(
      controller: _getNumberController(label),
      enabled: _getDropdownValue(label) == 'Yes',
      decoration: const InputDecoration(
        hintText: 'Enter Number',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  String _getDropdownValue(String label) {
    return dropdownValues[label] ?? 'Select';
  }

  void _updateDropdownValue(String label, String? value) {
    if (value != null) {
      dropdownValues[label] = value;
      if (value != 'Yes') {
        _getNumberController(label).clear();
      }
    }
  }

  TextEditingController _getNumberController(String label) {
    if (!numberControllers.containsKey(label)) {
      numberControllers[label] = TextEditingController();
    }
    return numberControllers[label]!;
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Request Submitted',
            style: TextStyle(
                color: Color(0xFF004B50),
                fontWeight: FontWeight.w700,
                fontFamily: 'Urbanist'),
          )),
          content: RichText(
            text: TextSpan(
              text: 'Your Reservation request SRCVK-87623 has been sent to the approver for review and further processing. \nYou can check the status of your request ',
              style: const TextStyle(color: Colors.black), // Set the default text color
              children: [
                TextSpan(
                  text: 'here',
                  style: const TextStyle(
                    color: Colors.blue, // Color for the clickable text
                    decoration: TextDecoration.underline, // Optional: underline for emphasis
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to the main page when "here" is clicked
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserRequestFilter())); // Update with your route name
                    },
                ),
                const TextSpan(
                  text: ' or you can go to "Manage Reservations" under \'Facility Reservation\' module.',
                ),
             ],
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('Cancel'),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            Center(
              child: Container(
                width: 160,
                height: 48,
                decoration: ShapeDecoration(
                    color: const Color(0xFF275C9D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Center(
                  child: TextButton(
                    child: const Text(
                      'Back to home',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Urbanist'),
                    ),
                    onPressed: () {
                      // Implement booking logic 
                      Navigator.popUntil(context, (route) => route.isFirst);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
