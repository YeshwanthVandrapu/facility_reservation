
import 'package:flutter/material.dart';
import 'admin_filter.dart';
import 'test_table.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 1600,
            child: Column(
              children: [
                Container(
                  decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                          side: const BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFE6E6EC),
                          ),
                          borderRadius: BorderRadius.circular(4),
                          ),
                          ),
                          margin: const EdgeInsets.only(top: 16),
                          child: const AdminFilter(),  
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 16)), // Adjust padding as needed
                        minimumSize: WidgetStateProperty.all(const Size(150, 48)), // Adjust size as needed
                      ),
                      onPressed: () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            WidgetSpan(child: Text("Reject Request")),
                            WidgetSpan(
                              child: SizedBox(width: 8), // Add spacing between the icon and the text
                            ),
                            WidgetSpan(
                              child: Icon(Icons.key_off_outlined, color: Colors.white, size: 20,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add spacing between buttons
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.green),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 16)), // Adjust padding as needed
                        minimumSize: WidgetStateProperty.all(const Size(150, 48)), // Adjust size as needed
                      ),
                      onPressed: () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            WidgetSpan(child: Text("Accept Request")),
                            WidgetSpan(
                              child: SizedBox(width: 8), // Add spacing between the icon and the text
                            ),
                            WidgetSpan(
                              child: Icon(Icons.verified, color: Colors.white, size: 20,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const AdminTable()
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}