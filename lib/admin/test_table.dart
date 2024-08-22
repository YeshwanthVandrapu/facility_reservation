import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/state_provider.dart';

class MyData extends DataTableSource {
  final BuildContext context;
  final Map<String, dynamic> filters;
  MyData(this.context, this.filters);

  List<Map<String, dynamic>> get filteredData {
    //TODO: Implement filtering logic here
    return data;
  }
   List<Map<String, dynamic>> data = [
    {
      "Status": "Pending",
      "Reservation Number": "SRCVK-87623",
      "Name": "Srinivasan Reddy",
      "Requestor Department": "Student",
      "Room": "Seminar Hall 1",
      "Building": "JSW Academic Block",
      "Date": "28/06/2020",
      "Time": "11:30 AM",
      "Special Needs": "Yes",
      "isSelected": false,
    },
    // Add more data 
  ];
   
   void selectAll(bool? selected) {
    if (selected != null) {
      for (var row in data) {
        row['isSelected'] = selected;
      }
      notifyListeners();
    }
  }

  void selectRow(int index, bool? selected) {
    if (selected != null) {
      data[index]['isSelected'] = selected;
      notifyListeners();
    }
  }


  @override
  DataRow getRow(int index) {
    final row = filteredData[index];
    return DataRow(
      selected: row['isSelected'] ?? false,
      onSelectChanged: (selected) => selectRow(index, selected),
      cells: [
        DataCell(Checkbox(
          value: row['isSelected'] ?? false,
          onChanged: (selected) => selectRow(index, selected),
        )),
        DataCell(Text(row['Status'] ?? '')),
        DataCell(Text(row['Reservation Number'] ?? '')),
        DataCell(Text(row['Name'] ?? '')),
        DataCell(Text(row['Requestor Department'] ?? '')),
        DataCell(Text(row['Room'] ?? '')),
        DataCell(Text(row['Building'] ?? '')),
        DataCell(Text(row['Date'] ?? '')),
        DataCell(Text(row['Time'] ?? '')),
        DataCell(Text(row['Special Needs'] ?? '')),
        DataCell(IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Implement action for the last column
          },
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => filteredData.length;

  @override
  int get selectedRowCount => data.where((row) => row['isSelected'] == true).length;
}

class AdminTable extends StatefulWidget {
  const AdminTable({super.key});

  @override
  State<AdminTable> createState() => _AdminTableState();
}

class _AdminTableState extends State<AdminTable> {
    int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final List<int> _availableRowsPerPage = [5, 10, 20];
  bool _selectAll = false;


 @override
  Widget build(BuildContext context) {
    final filters = Provider.of<MyState>(context).filters;
    final dataSource = MyData(context, filters);
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(
            // ... (keep existing theme data)
          ),
          child: PaginatedDataTable(
            columns: [
              DataColumn(
                label: Checkbox(
                  value: _selectAll,
                  onChanged: (bool? value) {
                    setState(() {
                      _selectAll = value ?? false;
                      dataSource.selectAll(_selectAll);
                    });
                  },
                ),
              ),
              const DataColumn(label: Text("Status")),
              const DataColumn(label: Text("Reservation Number")),
              const DataColumn(label: Text("Name")),
              const DataColumn(label: Text("Requestor Department")),
              const DataColumn(label: Text("Room")),
              const DataColumn(label: Text("Building")),
              const DataColumn(label: Text("Date")),
              const DataColumn(label: Text("Time")),
              const DataColumn(label: Text("Special Needs")),
              const DataColumn(label: Text("")), // For the action column
            ],
            source: MyData(context, filters),
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