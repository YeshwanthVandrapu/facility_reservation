import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

    Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/res/data/test.json');
    final data = await json.decode(response);
    setState(() {
      var items = data["items"];
      print("..number of items ${items.length}");
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}