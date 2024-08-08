import 'package:flutter/material.dart';
import '../calender/view.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class ResultData extends StatefulWidget {
  const ResultData({super.key});

  @override
  State<ResultData> createState() => _ResultDataState();
}

class _ResultDataState extends State<ResultData> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final List<int> _availableRowsPerPage = [5, 10, 20];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: const [
          DataColumn(label: Text("Building/Block")),
          DataColumn(label: Text("Floor")),
          DataColumn(label: Text("Room Number/Name")),
          DataColumn(label: Text("Attendance Capacity")),
          DataColumn(label: Text("Availability")),
          DataColumn(label: Text("Select")),
          DataColumn(label: Text("Event ID"))
        ],
        source: MyData(context),
        horizontalMargin: 30,
        showFirstLastButtons: true,
        rowsPerPage: _rowsPerPage,
        columnSpacing: 150,
        availableRowsPerPage: _availableRowsPerPage,
        onRowsPerPageChanged: (value) {
          setState(() {
            _rowsPerPage = value ?? PaginatedDataTable.defaultRowsPerPage;
          });
        },
      ),
    );
  }
}

class MyData extends DataTableSource {
  final BuildContext context;
  MyData(this.context);

  List<Map<String, String>> data = [
    {
      "Building": "JSW Academic Building",
      "Floor": "Ground Floor",
      "Room Number": "1",
      "Attendance Capacity": "60", // Corrected key
      "Availability": "Yes", // Corrected key
      "Select": "Select",
      "Event_id": "E00251"
    },
    {
      "Building": "JSW Academic Building",
      "Floor": "Ground Floor",
      "Room Number": "2",
      "Attendance Capacity": "30", // Corrected key
      "Availability": "Yes", // Corrected key
      "Select": "Select",
      "Event_id": "E00252"
    }
  ];

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['Building'] ?? '')),
        DataCell(Text(data[index]['Floor'] ?? '')),
        DataCell(Text(data[index]['Room Number'] ?? '')), // Updated key
        DataCell(Text(data[index]['Attendance Capacity'] ?? '')), // Updated key
        DataCell(Text(data[index]['Availability'] ?? '')), // Updated key
        DataCell(TextButton(
          onPressed: () => _showSelectDialog(index),
          child: Text(data[index]['Select'] ?? ''))),
        DataCell(Text(data[index]['Event_id'] ?? ''))
      ]
    );
  }

  void _showSelectDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
            height: MediaQuery.of(context).size.height * 0.8, // Adjust height as needed
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Select Room",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: BookingCalendarDemoApp(), // Embed the calendar widget here
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({Key? key}) : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );
  }

  Stream<dynamic>? getBookingStreamMock({required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock({required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(start: fourth, end: fourth.add(const Duration(minutes: 50))));

    converted.add(DateTimeRange(
      start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
      end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0),
    ));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 12, 0),
        end: DateTime(now.year, now.month, now.day, 13, 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BookingCalendar(
      bookingService: mockBookingService,
      convertStreamResultToDateTimeRanges: convertStreamResultMock,
      getBookingStream: getBookingStreamMock,
      uploadBooking: uploadBookingMock,
      pauseSlots: generatePauseSlots(),
      pauseSlotText: 'LUNCH',
      hideBreakTime: false,
      loadingWidget: const Text('Fetching data...'),
      uploadingWidget: const CircularProgressIndicator(),
      locale: 'hu_HU',
      startingDayOfWeek: StartingDayOfWeek.tuesday,
      wholeDayIsBookedWidget: const Text('Sorry, for this day everything is booked'),
    );
  }
}
