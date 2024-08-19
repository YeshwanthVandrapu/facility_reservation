import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../time_selector/view.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  // bool hasSpecialNeeds = false;
  // TextEditingController bookingPurposeController = TextEditingController();

  bool hasSpecialNeeds = false;
  TextEditingController bookingPurposeController = TextEditingController();
  Map<String, String> dropdownValues = {};
  Map<String, TextEditingController> numberControllers = {};

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        RichText(
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
                         SeminarHallScreen(),
                        const SizedBox(height: 16),
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
              text: 'Your Reservation request (Reservation Number) has been sent to the approver for review and further processing. \nYou can check the status of your request ',
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
                      Navigator.pushNamed(context, '/'); // Update with your route name
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
                      // Implement booking logic here
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
