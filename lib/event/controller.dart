import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'model.dart';

class EventController extends GetxController{

  List<Event> events = [];
    @override
  void onInit() async {
    super.onInit();
    events.clear();
    String rawJson = await rootBundle.loadString("res/data/event.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      events.add(Event.fromJson(i));
    }
    update();
  }

}