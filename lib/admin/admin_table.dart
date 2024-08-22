import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/state_provider.dart';


 List<Map<String, String>> data = [
    {
      "Status": "Pending",
      "Reservation Number": "SRCVK-87623",
      "Name": "Srinivasan Reddy",
      "Requester Department": "Student",
      "Room": "Seminar Hall 1",
      "Building": "JSW Academic Block",
      "Date": "28/06/2020",
      "Time": "11:30 AM",
      "Special Needs": "Yes",
    },
    {
      "Status": "Pending",
      "Reservation Number": "SRCVK-45347",
      "Name": "Arlene McCoy",
      "Requester Department": "Student",
      "Room": "Seminar Hall 2",
      "Building": "JSW Academic Block",
      "Date": "27/02/2020",
      "Time": "10:25 AM",
      "Special Needs": "No",
    },
    {
      "Status": "Confirmed",
      "Reservation Number": "SRCVK-87625",
      "Name": "Darrell Steward",
      "Requester Department": "Student",
      "Room": "Seminar Hall 1",
      "Building": "JSW Academic Block",
      "Date": "29/06/2020",
      "Time": "12:30 PM",
      "Special Needs": "Yes",
    },
    {
      "Status": "Pending",
      "Reservation Number": "SRCVK-45348",
      "Name": "Jane Cooper",
      "Requester Department": "Staff",
      "Room": "Seminar Hall 2",
      "Building": "JSW Academic Block",
      "Date": "27/02/2020",
      "Time": "02:25 PM",
      "Special Needs": "No",
    },
    {
      "Status": "Cancelled",
      "Reservation Number": "SRCVK-45349",
      "Name": "Courtney Henry",
      "Requester Department": "Student",
      "Room": "Seminar Hall 1",
      "Building": "JSW Academic Block",
      "Date": "28/06/2020",
      "Time": "09:00 AM",
      "Special Needs": "No",
    },
    {
      "Status": "Confirmed",
      "Reservation Number": "SRCVK-45350",
      "Name": "Wade Warren",
      "Requester Department": "Student",
      "Room": "Seminar Hall 3",
      "Building": "JSW Academic Block",
      "Date": "29/06/2020",
      "Time": "10:00 AM",
      "Special Needs": "No",
    },
    {
      "Status": "Pending",
      "Reservation Number": "SRCVK-45351",
      "Name": "Robert Fox",
      "Requester Department": "Staff",
      "Room": "Seminar Hall 4",
      "Building": "JSW Academic Block",
      "Date": "30/06/2020",
      "Time": "11:00 AM",
      "Special Needs": "Yes",
    },
  ];
// List<bool> _selectedRows = []; 

class AdminTable extends StatefulWidget {
  const AdminTable({super.key});

  @override
  State<AdminTable> createState() => _AdminTableState();
}

class _AdminTableState extends State<AdminTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final List<int> _availableRowsPerPage = [5, 10, 20];
  final List<bool> _selectedRows = List.generate(data.length, (_) => false);
  bool _selectAll = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedRows = List<bool>.generate(data.length, (index) => false);
  // }

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
            columns: [
              DataColumn(
                label: Checkbox(
                  value: _selectAll,
                  onChanged: (bool? value) {
                    setState(() {
                      _selectAll = value ?? false;
                      // You can update this to select/deselect all rows
                    });
                  },
                ),
              ),
              const DataColumn(label: Text("Status")),
              const DataColumn(label: Text("Reservation Number")),
              const DataColumn(label: Text("Name")),
              const DataColumn(label: Text("Requester Department")),
              const DataColumn(label: Text("Room")),
              const DataColumn(label: Text("Building")),
              const DataColumn(label: Text("Date")),
              const DataColumn(label: Text("Time")),
              const DataColumn(label: Text("Special Needs")),
              const DataColumn(label: Text("Select")),
            ],
           source: MyData(context, filters, _selectAll),
            horizontalMargin: 30,
            showFirstLastButtons: true,
            rowsPerPage: _rowsPerPage,
            columnSpacing: 100,
            availableRowsPerPage: const [5, 10, 20],
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
  // final List<bool> selectedRows;
  final bool selectAll;
  MyData(this.context, this.filters, this.selectAll);

  List<Map<String, String>> get filteredData {
    return data.where((row) {
      return true;
    }).toList();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= filteredData.length) return null;
    final row = filteredData[index];
    return DataRow(
      
      cells: [
        DataCell(Checkbox(
          value: selectAll, // This will check/uncheck all rows based on the "Select All" checkbox
          onChanged: (bool? value) {
            // handle individual checkbox logic here
          },
        )),
        DataCell(Text(row['Status'] ?? '')),
        DataCell(Text(row['Reservation Number'] ?? '')),
        DataCell(Text(row['Name'] ?? '')),
        DataCell(Text(row['Requester Department'] ?? '')),
        DataCell(Text(row['Room'] ?? '')),
        DataCell(Text(row['Building'] ?? '')),
        DataCell(Text(row['Date'] ?? '')),
        DataCell(Text(row['Time'] ?? '')),
        DataCell(Text(row['Special Needs'] ?? '')),
        DataCell(Center(
          child: TextButton(
            onPressed: () {

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
    int get selectedRowCount =>0;

  // int get selectedRowCount => selectedRows.where((isSelected) => isSelected).length;
}
