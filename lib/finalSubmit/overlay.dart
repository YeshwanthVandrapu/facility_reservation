import 'package:flutter/material.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool hasSpecialNeeds = false;
  TextEditingController bookingPurposeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f7f7),
      appBar: AppBar(
        title: Text("Final Submit Page"),
      ),
      body: SingleChildScrollView(
  child: Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: 1600,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'res/img/popupPic.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 40), // Add space for the overlapping content
            ],
          ),
          Positioned(
            top: 180, // Adjust this value to control how much the content overlaps
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seminar Hall 1',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ground Floor | JSW Academic Block | 100',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Selected Date',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          controller: TextEditingController(text: '12/02/2024'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Time',
                            suffixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          controller: TextEditingController(text: '09:45 PM - 10:45 PM'),
                        ),
                      ),
                    ],
                  ),
                      SizedBox(height: 16),
                      TextField(
                        controller: bookingPurposeController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Please explain the purpose of this booking',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Note: Booking priority will be given to academic uses first.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Any Special Needs?'),
                          SizedBox(width: 16),
                          DropdownButton<bool>(
                            value: hasSpecialNeeds,
                            onChanged: (value) {
                              setState(() {
                                hasSpecialNeeds = value!;
                              });
                            },
                            items: [
                              DropdownMenuItem(value: true, child: Text('Yes')),
                              DropdownMenuItem(value: false, child: Text('No')),
                            ],
                          ),
                        ],
                      ),
                      if (hasSpecialNeeds) ...[
                        const SizedBox(height: 16),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(children: [
                              const Text('MIC'),
                              DropdownButton(items: const [], onChanged: null, hint: const Text('Select')),
                              const TextField(decoration: InputDecoration(hintText: 'Enter Number')),
                            ]),
                            TableRow(children: [
                              const Text('Speaker'),
                              DropdownButton(items: const [], onChanged: null, hint: const Text('Select')),
                              const TextField(decoration: InputDecoration(hintText: 'Enter Number')),
                            ]),
                            TableRow(children: [
                              const Text('Projector'),
                              DropdownButton(items: const [], onChanged: null, hint: const Text('Select')),
                              const TextField(decoration: InputDecoration(hintText: 'Enter Number')),
                            ]),
                            TableRow(children: [
                              const Text('Chairs'),
                              DropdownButton(items: const [], onChanged: null, hint: const Text('Select')),
                              const TextField(decoration: InputDecoration(hintText: 'Enter Number')),
                            ]),
                            TableRow(children: [
                              const Text('Tables'),
                              DropdownButton(items: const [], onChanged: null, hint: const Text('Select')),
                              const TextField(decoration: InputDecoration(hintText: 'Enter Number')),
                            ]),
                          ],
                        ),
                      ],
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                          child: const Text('Submit Request'),
                        ),
                      ),
                    ],
                  ),
                ),
          ),],
            ),
          ),
        ),
      ),
    );
  }


  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text("Your Reservation request (Reservation Number)  has been sent to the approver for review and further processing. You can check the status of your request here or you can go to \"Manage Reservations\" under 'Facility Reservation' module"),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Implement booking logic here
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}