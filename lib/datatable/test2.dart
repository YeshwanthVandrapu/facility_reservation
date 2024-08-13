import 'package:flutter/material.dart';
import '../timeSlotPopup/view.dart';

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
      child: Container(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(
            cardColor: Colors.white,
            dividerColor: Colors.grey.shade300, // Light grey divider
            dataTableTheme: DataTableThemeData(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F6F6)),
              dataRowColor: WidgetStateProperty.all(Colors.white),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.white),
            // Add this to style the pagination controls
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
                backgroundColor: Colors.white, // Button background color
              ),
            ),
          ),
          child: PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("Building/Block")),
              DataColumn(label: Text("Floor")),
              DataColumn(label: Text("Room Number/Name")),
              DataColumn(label: Text("Attendance Capacity")),
              DataColumn(label: Text("Availability")),
              DataColumn(label: Text("Select")),
              DataColumn(label: Text("Event ID")),
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
        ),
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
      "Attendance Capacity": "60",
      "Availability": "Yes",
      "Select": "Select",
      "Event_id": "E00251",
    },
    {
      "Building": "JSW Academic Building",
      "Floor": "Ground Floor",
      "Room Number": "2",
      "Attendance Capacity": "30",
      "Availability": "Yes",
      "Select": "Select",
      "Event_id": "E00252",
    },
  ];

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['Building'] ?? '')),
        DataCell(Text(data[index]['Floor'] ?? '')),
        DataCell(Text(data[index]['Room Number'] ?? '')),
        DataCell(Text(data[index]['Attendance Capacity'] ?? '')),
        DataCell(Text(data[index]['Availability'] ?? '')),
        DataCell(TextButton(
          onPressed: () => _showSelectDialog(index),
          child: Text(data[index]['Select'] ?? ''),
        )),
        DataCell(Text(data[index]['Event_id'] ?? '')),
      ],
      color: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return Colors.white; // Set each row's background color to white
      }),
    );
  }

  void _showSelectDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TimeSlotPopup(
          date: DateTime.now(),
          timeSlots: const [
            '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM',
            '11:30 AM', '12:00 PM', '12:30 PM', '01:00 PM', '01:30 PM', '02:00 PM',
            '02:30 PM', '03:00 PM', '03:30 PM', '04:00 PM', '04:30 PM', '05:00 PM',
            '05:30 PM', '06:00 PM', '06:30 PM', '07:00 PM', '07:30 PM', '08:00 PM',
            '08:30 PM', '09:00 PM', '09:30 PM', '10:00 PM', '10:30 PM', '11:00 PM',
          ],
          bookedSlots: const [], // Actual booked slots need to be passed here
        );
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
