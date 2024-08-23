// import 'package:facility_reservation/finalSubmit/Responsive_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../finalSubmit/view.dart';
// import '../finalSubmit/Responsive_test.dart';
import '../finalSubmit/Responsive_test.dart';
import '../state_management/state_provider.dart';
// import '../timeSlotPopup/view.dart';

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
    final filters = Provider.of<MyState>(context).filters;
    
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(
            cardColor: Colors.white,
            dividerColor: Colors.grey.shade300,
            dataTableTheme: DataTableThemeData(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F6F6)),
              dataRowColor: WidgetStateProperty.all(Colors.white),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.white),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          child: PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("Building/Block")),
              DataColumn(label: Text("Floor")),
              DataColumn(label: Text("Room Number/Name")),
              DataColumn(label: Text("Attendee Capacity")),
              DataColumn(label: Text("Does it include a projector and AV setup?")),
              DataColumn(label: Text("Availability")),
              DataColumn(label: Text("Select")),
            ],
            source: MyData(context, filters),
            horizontalMargin: 30,
            showFirstLastButtons: true,
            rowsPerPage: _rowsPerPage,
            columnSpacing: 120,
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
  final Map<String, dynamic> filters;
  MyData(this.context, this.filters);

    List<Map<String, String>> get filteredData {
    return data.where((row) {
      if (filters['building'] != null && row['Building/Block'] != filters['building']) return false;
      if (filters['floor'] != null && row['Floor'] != filters['floor']) return false;
      if (filters['room'] != null && row['Room Number/Name'] != filters['room']) return false;
      if (filters['attendeeCapacity'] != null) {
        int capacity = int.tryParse(row['Attendee Capacity'] ?? '') ?? 0;
        int filterCapacity = int.tryParse(filters['attendeeCapacity']) ?? 0;
        if (filterCapacity > 60 && capacity <= 60) return false;
        if (filterCapacity <= 60 && capacity != filterCapacity) return false;
      }
      if (filters['facilityStatus'] != null && filters['facilityStatus'] != 'Both') {
        if (filters['facilityStatus'] == 'Available' && row['Availability'] != 'Yes') return false;
        if (filters['facilityStatus'] == 'Not Available' && row['Availability'] != 'Not Available') return false;
      }
      if (filters['facilityType'] != null) {
        bool isSeminarHall = row['Room Number/Name']?.toLowerCase().contains('seminar') ?? false;
        if (filters['facilityType'] == 'Seminar Hall' && !isSeminarHall) return false;
        if (filters['facilityType'] == 'Class Room' && isSeminarHall) return false;
      }
      return true;
    }).toList();
  }

  List<Map<String, String>> data = [
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "Ground Floor",
      "Room Number/Name": "Seminar Hall 1",
      "Attendee Capacity": "100",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Yes",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "Ground Floor",
      "Room Number/Name": "Seminar Hall 2",
      "Attendee Capacity": "100",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Yes",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "Ground Floor",
      "Room Number/Name": "Seminar Hall 3",
      "Attendee Capacity": "100",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Yes",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "Ground Floor",
      "Room Number/Name": "Atrium L",
      "Attendee Capacity": "50",
      "Does it include a projector and AV setup?": "No",
      "Availability": "Yes",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "Ground Floor",
      "Room Number/Name": "Atrium R",
      "Attendee Capacity": "50",
      "Does it include a projector and AV setup?": "No",
      "Availability": "Yes",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "First Floor",
      "Room Number/Name": "Classroom 1A",
      "Attendee Capacity": "35",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Not Available",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "First Floor",
      "Room Number/Name": "Classroom 1B",
      "Attendee Capacity": "35",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Not Available",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "First Floor",
      "Room Number/Name": "Classroom 1C",
      "Attendee Capacity": "40",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Not Available",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "First Floor",
      "Room Number/Name": "Classroom 1D",
      "Attendee Capacity": "35",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Not Available",
    },
    {
      "Building/Block": "JSW ACADEMIC BLOCK",
      "Floor": "First Floor",
      "Room Number/Name": "Classroom 1E",
      "Attendee Capacity": "35",
      "Does it include a projector and AV setup?": "Yes",
      "Availability": "Not Available",
    },
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= filteredData.length) return null;
    final row = filteredData[index];
    return DataRow(
      
      cells: [
        DataCell(Text(data[index]['Building/Block'] ?? '')),
        DataCell(Text(data[index]['Floor'] ?? '')),
        DataCell(Text(data[index]['Room Number/Name'] ?? '')),
        DataCell(Text(data[index]['Attendee Capacity'] ?? '')),
        DataCell(Text(data[index]['Does it include a projector and AV setup?'] ?? '')),
        DataCell(Text(data[index]['Availability'] ?? '')),
        DataCell(Center(
          child: TextButton(
            // onPressed: () => _showSelectDialog(index),
            onPressed: () {
              // Pass the room number to BookingDetailsPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetailsPage(
                    roomNumber: row['Room Number/Name'] ?? '',
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 20),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Select'),
          ),
        )),
      ],
      color: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return Colors.white;
      }),
    );
  }

  // void _showSelectDialog(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return TimeSlotPopup(
  //         date: DateTime.now(),
  //         timeSlots: const [
  //           '08:30 AM', '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM', '11:00 AM',
  //           '11:30 AM', '12:00 PM', '12:30 PM', '01:00 PM', '01:30 PM', '02:00 PM',
  //           '02:30 PM', '03:00 PM', '03:30 PM', '04:00 PM', '04:30 PM', '05:00 PM',
  //           '05:30 PM', '06:00 PM', '06:30 PM', '07:00 PM', '07:30 PM', '08:00 PM',
  //           '08:30 PM', '09:00 PM', '09:30 PM', '10:00 PM', '10:30 PM', '11:00 PM',
  //         ],
  //         bookedSlots: const ['08:30 AM', '09:00 AM', '09:30 AM','05:30 PM', '06:00 PM'], 
  //       );
  //     },
  //   );
  // }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

