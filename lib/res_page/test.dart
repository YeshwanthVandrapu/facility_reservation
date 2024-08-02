import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_ui/responsive_ui.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Map<String, List<dynamic>> _items = {};
  String? buildingValue;
  String? floorValue;
  String? wingValue;
  String? roomValue;

  Map<String, String?> userChoices = {};

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    try {
      final String response = await rootBundle.loadString('res/data/test.json');
      final data = json.decode(response);
      setState(() {
        if (data is Map<String, dynamic>) {
          _items = data.map((key, value) => MapEntry(key, List<dynamic>.from(value)));
          print("Data loaded successfully.");
        } else {
          print("Unexpected JSON structure: $data");
        }
      });
    } catch (e) {
      print("Error reading JSON: $e");
    }
  }

  void handleSubmit() {
    userChoices = {
      'building': buildingValue,
      'floor': floorValue,
      'wing': wingValue,
      'room': roomValue,
    };
    print('User choices: $userChoices');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Responsive Test")),
      body: SingleChildScrollView(
        child: Responsive(
          children: <Widget>[
            _buildDropdown(
              label: "Building",
              value: buildingValue,
              items: _items['building'],
              onChanged: (value) {
                setState(() {
                  buildingValue = value;
                });
              },
            ),
            _buildDropdown(
              label: "Floor",
              value: floorValue,
              items: _items['floor'],
              onChanged: (value) {
                setState(() {
                  floorValue = value;
                });
              },
            ),
            _buildDropdown(
              label: "Wing",
              value: wingValue,
              items: _items['wing'],
              onChanged: (value) {
                setState(() {
                  wingValue = value;
                });
              },
            ),
            _buildDropdown(
              label: "Room",
              value: roomValue,
              items: _items['rooms'],
              onChanged: (value) {
                setState(() {
                  roomValue = value;
                });
              },
            ),
            Div(
              divison: const Division(
                colXL: 12,
                colL: 12,
                colM: 12,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: handleSubmit,
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    String? value,
    List<dynamic>? items,
    required ValueChanged<String?> onChanged,
  }) {
    return Div(
      divison: const Division(
        colXL: 2,
        colL: 3,
        colM: 2,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          value: value,
          hint: Text(label),
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: onChanged,
          items: items?.map<DropdownMenuItem<String>>((dynamic item) {
            return DropdownMenuItem<String>(
              value: item.toString(),
              child: Text(item.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
