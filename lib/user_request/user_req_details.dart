import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../state_management/state_provider.dart';
import '../time_selector/view.dart';
import 'user_request_filter.dart';

class UserReqDetails extends StatefulWidget {
  const UserReqDetails({super.key});

  @override
  _UserReqDetailsState createState() => _UserReqDetailsState();
}

class _UserReqDetailsState extends State<UserReqDetails> {
  bool hasSpecialNeeds = false;
  TextEditingController bookingPurposeController = TextEditingController();
  Map<String, String> dropdownValues = {};
  Map<String, TextEditingController> numberControllers = {};

  // Controllers for the additional fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController reservationNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f7f7),
      appBar: AppBar(
        title: const Text("My Reservation Details"),
        leading: IconButton(
          icon: const Icon(Icons.home), // Replace with any icon you prefer
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Provider.of<MyState>(context, listen: false).toggleVisibility();
          },
        ),
      ),
      
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 1600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.asset(
                      'res/img/popupPic.png',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seminar Hall 1',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 32,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0.04,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'Ground Floor | JSW Academic Block | '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.people,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const TextSpan(text: ' 100'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Add Time and Date Selector
                        const Text(
                          'Select Date and Time',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const SeminarHallScreen(isEditable: false),
                        const SizedBox(height: 24),

                        // Requester Information section
                        const Text(
                          'Requester Information',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Responsive(children: <Widget>[
                          Div(
                            divison: const Division(
                              colL: 3,
                              colM: 6,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  _buildInfoBox('Name', 'John Doe'),
                            ),
                            ),
                            Div(
                            divison: const Division(
                              colL: 3,
                              colM: 6,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  _buildInfoBox('Email ID', 'admin_test@krea.edu.in'),
                            ),
                            ),
                            
                            Div(
                            divison: const Division(
                              colL: 3,
                              colM: 6,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  _buildInfoBox('Department & Role', 'Staff'),
                            ),
                            ),
                            Div(
                            divison: const Division(
                              colL: 3,
                              colM: 6,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  _buildInfoBox('Reservation Number', 'SRCVK-87623'),
                            ),
                            ),
                        ]),
                        const SizedBox(height: 16),
                        const Text("Reason for Booking", style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(height: 8),
                        TextField(
                          readOnly: true,
                          controller: bookingPurposeController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            // labelText:
                            //     'I want to book this Hall for an Event.',
                            hintText: "I want to book this Hall for an Event.",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text("Special Needs (If Any)", style: TextStyle(fontWeight: FontWeight.w600),),
                        Responsive(children: <Widget>[
                          Div(
                            divison: const Division(
                              colL: 2,
                              colM: 4,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  _buildInfoBox('Mics', '0'),
                            ),
                            ),
                            Div(
                            divison: const Division(
                              colL: 2,
                              colM: 4,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  _buildInfoBox('Speakers', '2'),
                            ),
                            ),
                            Div(
                            divison: const Division(
                              colL: 2,
                              colM: 4,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildInfoBox('Projectors', '1'),
                            ),
                            ),
                            Div(
                            divison: const Division(
                              colL: 2,
                              colM: 4,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:_buildInfoBox('Chairs', '0'),
                            ),
                            ),
                            Div(
                            divison: const Division(
                              colL: 2,
                              colM: 4,
                              colS: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:_buildInfoBox('Tables', '0'),
                            ),
                            ),
                        ],),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserRequestFilter()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D5CA4),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            ),
                            child: const Text('Return Back', style: TextStyle(color: Colors.white),),
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

  Widget _buildInfoBox(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Container(
            constraints: const BoxConstraints(minWidth: 300),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

}

class ResponsiveFormFields extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveFormFields({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          // For larger screens, show fields in two columns
          return Column(
            children: [
              for (int i = 0; i < children.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(child: children[i]),
                      const SizedBox(width: 16),
                      Expanded(
                        child: i + 1 < children.length
                            ? children[i + 1]
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else {
          // For smaller screens, show fields in a single column
          return Column(
            children: children
                .map((child) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: child,
                    ))
                .toList(),
          );
        }
      },
    );
  }
}