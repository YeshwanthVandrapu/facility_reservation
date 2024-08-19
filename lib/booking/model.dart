import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
    String roomId;
    DateTime date;
    String timeSlot;

    Booking({
        required this.roomId,
        required this.date,
        required this.timeSlot,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        roomId: json["room_id"],
        date: DateTime.parse(json["date"]),
        timeSlot: json["time_slot"],
    );

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time_slot": timeSlot,
    };
}
