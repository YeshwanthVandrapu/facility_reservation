import 'package:facility_reservation/user_request/user_req_details.dart';
import 'package:flutter/material.dart';

class UserRequestTable extends StatefulWidget {
  const UserRequestTable({super.key});

  @override
  State<UserRequestTable> createState() => _UserRequestTableState();
}

class _UserRequestTableState extends State<UserRequestTable> {
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
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("Reservation Number")),
              DataColumn(label: Text("Room")),
              DataColumn(label: Text("Building")),
              DataColumn(label: Text("Date")),
              DataColumn(label: Text("Time")),
              DataColumn(label: Text("Special Needs")),
              DataColumn(label: Text("Select")),
            ],
            source: MyData(context),
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
  MyData(this.context);

  List<Map<String, String>> data = [
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-87623",
    "Room": "Seminar Hall 1",
    "Building": "JSW Academic Block",
    "Date": "28/06/2020",
    "Time": "11:30 AM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-45347",
    "Room": "Seminar Hall 2",
    "Building": "JSW Academic Block",
    "Date": "27/02/2020",
    "Time": "10:25 AM",
    "Special Needs": "No",
  },
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-46784",
    "Room": "Seminar Hall 2",
    "Building": "JSW Academic Block",
    "Date": "03/03/2020",
    "Time": "11:30 AM",
    "Special Needs": "No",
  },
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-09689",
    "Room": "Seminar Hall 3",
    "Building": "JSW Academic Block",
    "Date": "30/04/2020",
    "Time": "07:15 PM",
    "Special Needs": "No",
  },
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-00344",
    "Room": "Classroom 1A",
    "Building": "JSW Academic Block",
    "Date": "29/05/2020",
    "Time": "10:25 AM",
    "Special Needs": "No",
  },
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-99456",
    "Room": "Classroom 1B",
    "Building": "JSW Academic Block",
    "Date": "23/03/2020",
    "Time": "11:30 AM",
    "Special Needs": "No",
  },
  {
    "Status": "Pending",
    "Reservation Number": "SRCVK-23411",
    "Room": "Classroom 1A",
    "Building": "JSW Academic Block",
    "Date": "09/04/2020",
    "Time": "07:15 PM",
    "Special Needs": "No",
  },
  {
    "Status": "Rejected",
    "Reservation Number": "SRCVK-12123",
    "Room": "Classroom 1C",
    "Building": "JSW Academic Block",
    "Date": "31/03/2020",
    "Time": "10:25 AM",
    "Special Needs": "No",
  },
  {
    "Status": "Rejected",
    "Reservation Number": "SRCVK-12344",
    "Room": "Classroom 1C",
    "Building": "JSW Academic Block",
    "Date": "15/05/2020",
    "Time": "08:00 PM",
    "Special Needs": "No",
  },
  {
    "Status": "Rejected",
    "Reservation Number": "SRCVK-56785",
    "Room": "Classroom 1D",
    "Building": "JSW Academic Block",
    "Date": "19/07/2020",
    "Time": "08:00 PM",
    "Special Needs": "No",
  },
  {
    "Status": "Rejected",
    "Reservation Number": "SRCVK-56783",
    "Room": "Classroom 1C",
    "Building": "JSW Academic Block",
    "Date": "25/01/2020",
    "Time": "08:00 PM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Rejected",
    "Reservation Number": "SRCVK-13444",
    "Room": "Classroom 1A",
    "Building": "JSW Academic Block",
    "Date": "30/07/2020",
    "Time": "10:25 AM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Rejected",
    "Reservation Number": "SRCVK-10987",
    "Room": "Classroom 2C",
    "Building": "JSW Academic Block",
    "Date": "26/04/2020",
    "Time": "07:15 PM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Approved",
    "Reservation Number": "SRCVK-04677",
    "Room": "Classroom 2A",
    "Building": "JSW Academic Block",
    "Date": "30/01/2020",
    "Time": "07:15 PM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Approved",
    "Reservation Number": "SRCVK-63452",
    "Room": "Classroom 3A",
    "Building": "JSW Academic Block",
    "Date": "12/06/2020",
    "Time": "08:00 PM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Approved",
    "Reservation Number": "SRCVK-23412",
    "Room": "Classroom 3D",
    "Building": "JSW Academic Block",
    "Date": "11/07/2020",
    "Time": "11:30 AM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Approved",
    "Reservation Number": "SRCVK-94563",
    "Room": "Classroom 3B",
    "Building": "JSW Academic Block",
    "Date": "24/03/2020",
    "Time": "08:00 PM",
    "Special Needs": "Yes",
  },
  {
    "Status": "Approved",
    "Reservation Number": "SRCVK-34561",
    "Room": "Classroom 3F",
    "Building": "JSW Academic Block",
    "Date": "16/06/2020",
    "Time": "07:15 PM",
    "Special Needs": "Yes",
  },
];
  

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['Status'] ?? '')),
        DataCell(Text(data[index]['Reservation Number'] ?? '')),
        DataCell(Text(data[index]['Room'] ?? '')),
        DataCell(Text(data[index]['Building'] ?? '')),
        DataCell(Text(data[index]['Date'] ?? '')),
        DataCell(Text(data[index]['Time'] ?? '')),
        DataCell(Text(data[index]['Special Needs'] ?? '')),
        DataCell(Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserReqDetails()));
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

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}