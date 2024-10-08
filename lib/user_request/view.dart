import 'dart:convert';
import 'package:facility_reservation/booking/controller.dart';
import 'package:facility_reservation/event/controller.dart';
import 'package:facility_reservation/filters/view.dart';
import 'package:facility_reservation/state_management/user_booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../datatable/view.dart';




void main() {
  Get.put(EventController());
  Get.put(BookingController());
  runApp(
    ChangeNotifierProvider(
      create: (context) =>UserBookingState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Facility Management'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, List<dynamic>> _items = {};

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

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBookingState>(
      builder: (context, myState, child) {
        return MaterialApp(
          home: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xfff8f7f7),
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,   
                  child: SizedBox(
                    // color:Colors.white, 
                    width:  1600, 
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
                          child: const Filters() 
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        myState.isVisible?
                        Container(
                          color: Colors.white,
                          // width: 1200,
                          child: const ResultData()
                          ):Container(),
                        
                        // Container(
                        //   color: Colors.white,
                        //   // width: 1200,
                        //   child: const ResultData()
                        //   )
                      ],
                    ),
                    ),
                  ),
                ),
              // Column(
              //   children: [
              //     TextButton(
              //       onPressed: readJson,
              //       child: const Text("Get data"),
              //     ),
              //     Expanded(
              //       child: ListView.builder(
              //         itemCount: _items.length,
              //         itemBuilder: (context, index) {
              //           String key = _items.keys.elementAt(index);
              //           return ExpansionTile(
              //             title: Text(key),
              //             children: _items[key]!
              //                 .map((item) => ListTile(title: Text(item.toString())))
              //                 .toList(),
              //           );
              //         },
              //       ),
              //     ),
          
              //   ],
              // ),
            ),
            ),
        );
      }
    );
  }
}
