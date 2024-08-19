import 'package:facility_reservation/booking/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../finalSubmit/view.dart';


class TimeSlotPopup extends StatelessWidget {
  // final DateTime date;
  // final List<String> timeSlots;
  // final List<String> bookedSlots;
  final DateTime initialDate;
  final String roomId;
  final List<String> timeSlots;

  const TimeSlotPopup({
    super.key,
    required this.initialDate,
    required this.roomId,
    required this.timeSlots,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.8,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                DateTime selectedDate = initialDate;
                List<String> bookedSlots = controller.getBookedSlots(roomId, selectedDate);
        
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
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
                            icon: const Icon(Icons.close, color: Colors.black, weight: 600),
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
                                  DateSelectorWithIcon(
                                    initialDate: selectedDate,
                                    onDateSelected: (newDate) {
                                      setState(() {
                                        selectedDate = newDate;
                                        bookedSlots = controller.getBookedSlots(roomId, newDate);
                                      });
                                    },
                                  ),
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
                                    onPressed: isBooked ? null : () {
                                      // Handle slot booking logic
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
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookingDetailsPage())),
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
                );
              },
            ),
          ),
        );
      }
    );
  }
}

class DateSelectorWithIcon extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DateSelectorWithIcon({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelectorWithIcon> createState() => _DateSelectorWithIconState();
}

class _DateSelectorWithIconState extends State<DateSelectorWithIcon> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(widget.initialDate);

    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != widget.initialDate) {
          widget.onDateSelected(pickedDate);
        }
      },
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
