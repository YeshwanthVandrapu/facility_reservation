import 'package:facility_reservation/finalSubmit/view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class TimeSlotPopup extends StatelessWidget {
  final DateTime date;
  final List<String> timeSlots;
  final List<String> bookedSlots;

  const TimeSlotPopup({super.key, 
    required this.date,
    required this.timeSlots,
    required this.bookedSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                    child: Image.asset(
                      'res/img/popupPic.png', 
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black, weight: 600,),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Seminar Hall 1',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
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
                          const DateSelectorWithIcon(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Available Time Slots',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 36,
                        runSpacing: 24,
                        children: timeSlots.map((slot) {
                          bool isBooked = bookedSlots.contains(slot);
                          return OutlinedButton(
                            onPressed: () {
                              // Handle slot selection logic here
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isBooked ? Colors.grey : Colors.green,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              slot,
                              style: TextStyle(
                                color: isBooked ? Colors.grey : Colors.green,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const BookingDetailsPage())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D5CA4),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.12, 50),
                  ),
                  child: const Text(
                    'Proceed to select time',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showConfirmationDialog(BuildContext context, String slot) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirm Booking'),
  //         content: Text('Are you sure you want to book this slot: $slot?'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               // Implement booking logic here
  //               Navigator.of(context).pop();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

class DateSelectorWithIcon extends StatefulWidget {
  const DateSelectorWithIcon({super.key});

  @override
  _DateSelectorWithIconState createState() => _DateSelectorWithIconState();
}

class _DateSelectorWithIconState extends State<DateSelectorWithIcon> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.calendar_today, color: Colors.grey),
            const SizedBox(width: 10.0),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
