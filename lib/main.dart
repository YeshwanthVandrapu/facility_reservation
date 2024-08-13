import 'dart:convert';

import 'package:facility_reservation/event/controller.dart';
import 'package:facility_reservation/filters/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'datatable/test2.dart';



void main() {
  Get.put(EventController());
  runApp(const MyApp());
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
                      color: Colors.white,
                      child: const Filters() 
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      color: Colors.white,
                      // width: 1200,
                      child: const ResultData()
                      )
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
}
