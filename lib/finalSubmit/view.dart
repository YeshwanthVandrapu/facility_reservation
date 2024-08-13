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
        title: const Text("Final Submit Page"),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 1600,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.amber,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    child: Image.asset(
                      'res/img/popupPic.png', 
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seminar Hall 1',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Ground Floor | JSW Academic Block | 100',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Selected Date',
                                  suffixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
                                ),
                                readOnly: true,
                                controller: TextEditingController(text: '12/02/2024'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
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
                        const SizedBox(height: 16),
                        TextField(
                          controller: bookingPurposeController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Please explain the purpose of this booking',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Note: Booking priority will be given to academic uses first.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text('Any Special Needs?'),
                            const SizedBox(width: 16),
                            DropdownButton<bool>(
                              value: hasSpecialNeeds,
                              onChanged: (value) {
                                setState(() {
                                  hasSpecialNeeds = value!;
                                });
                              },
                              items: const [
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
                ],
              ),
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
          title: Center(child: const Text('Request Submitted')),
          content: const Text("Your Reservation request (Reservation Number)  has been sent to the approver for review and further processing. \nYou can check the status of your request here or you can go to \"Manage Reservations\" under 'Facility Reservation' module"),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('Cancel'),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            Center(
              child: TextButton(
                child: const Text('Back to home'),
                onPressed: () {
                  // Implement booking logic here
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}