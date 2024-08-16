import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 


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

    return  GestureDetector(
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