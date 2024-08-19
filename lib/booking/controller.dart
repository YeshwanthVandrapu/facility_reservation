import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'model.dart';

class BookingController extends GetxController{
  List<Booking> bookings = [];
  @override
  void onInit() async{
    super.onInit();
    bookings.clear();
    String rawJson = await rootBundle.loadString("res/data/bookings.json");
    for(Map<String,dynamic> i in jsonDecode(rawJson)){
      bookings.add(Booking.fromJson(i));
    }
    update();
    
    print(bookings.first);
  }

  List<String> getBookedSlots(String roomId, DateTime date) {
    print("getBookedSlots Called");
    return bookings
        .where((booking) => 
            booking.roomId == roomId && 
            booking.date.year == date.year && 
            booking.date.month == date.month && 
            booking.date.day == date.day)
        .map((booking) => booking.timeSlot)
        .toList();
  }
}