import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: RoomAvailability(),
//     );
//   }
// }

class RoomAvailability extends StatefulWidget {
  const RoomAvailability({super.key});

  @override
  _RoomAvailabilityState createState() => _RoomAvailabilityState();
}

class _RoomAvailabilityState extends State<RoomAvailability> {
  // Example booked slots for multiple rooms
  List<RoomBooking> roomBookings = [
    RoomBooking(
      'Room 101',
      DateTime(2024, 8, 8, 3, 15),
      DateTime(2024, 8, 8, 8, 0),
    ),
    RoomBooking(
      'Room 101',
      DateTime(2024, 8, 9, 5, 45),
      DateTime(2024, 8, 9, 10, 15),
    ),
    RoomBooking(
      'Room 202',
      DateTime(2024, 8, 10, 2, 0),
      DateTime(2024, 8, 10, 4, 30),
    ),
    RoomBooking(
      'Room 202',
      DateTime(2024, 8, 12, 2, 45),
      DateTime(2024, 8, 12, 7, 30),
    ),
  ];

  String selectedRoom = 'Room 101'; // Default room selection
  final CalendarController _calendarController = CalendarController(); // Controller for calendar navigation

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRoom = 'Room 101';
                  });
                },
                child: const Text('Room 101'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRoom = 'Room 202';
                  });
                },
                child: const Text('Room 202'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _calendarController.backward!();
                },
              ),
              const Text(
                'Week View',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  _calendarController.forward!();
                },
              ),
            ],
          ),
          SizedBox(
            height: 540,
            child: SfCalendar(
              view: CalendarView.week,
              controller: _calendarController,
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeFormat: 'HH:mm',
                timeInterval: Duration(hours: 1),
                startHour: 0,
                endHour: 24,
              ),
              dataSource: MeetingDataSource(_getDataSourceForRoom(selectedRoom)),
              firstDayOfWeek: 1,
              appointmentBuilder: (context, calendarAppointmentDetails) {
                final Meeting meeting =
                    calendarAppointmentDetails.appointments.first;
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: meeting.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start: ${meeting.from.hour}:${meeting.from.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'End: ${meeting.to.hour}:${meeting.to.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
  }

  List<Meeting> _getDataSourceForRoom(String roomName) {
    List<Meeting> meetings = <Meeting>[];
    for (var booking in roomBookings) {
      if (booking.roomName == roomName) {
        meetings.add(
          Meeting(
            eventName: booking.roomName,
            from: booking.startTime,
            to: booking.endTime,
            background: Colors.blue,
            isAllDay: false,
          ),
        );
      }
    }
    return meetings;
  }
}

class RoomBooking {
  String roomName;
  DateTime startTime;
  DateTime endTime;

  RoomBooking(this.roomName, this.startTime, this.endTime);
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });
}
