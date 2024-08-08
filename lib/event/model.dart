import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

class Event {
    int eventId;
    String building;
    String floor;
    String roomNo;
    String startTime;
    String endTime;
    String setup;
    String date;

    Event({
        required this.eventId,
        required this.building,
        required this.floor,
        required this.roomNo,
        required this.startTime,
        required this.endTime,
        required this.setup,
        required this.date,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["event_id"],
        building: json["building"],
        floor: json["floor"],
        roomNo: json["room_no"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        setup: json["setup"],
        date: json["date"],
    );
}
