// To parse this JSON data, do
//
//     final facility = facilityFromJson(jsonString);

import 'dart:convert';

Facility facilityFromJson(String str) => Facility.fromJson(json.decode(str));

String facilityToJson(Facility data) => json.encode(data.toJson());

class Facility {
    List<String> building;
    List<String> floor;
    List<String> wing;
    List<String> rooms;

    Facility({
        required this.building,
        required this.floor,
        required this.wing,
        required this.rooms,
    });

    factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        building: List<String>.from(json["building"].map((x) => x)),
        floor: List<String>.from(json["floor"].map((x) => x)),
        wing: List<String>.from(json["wing"].map((x) => x)),
        rooms: List<String>.from(json["rooms"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "building": List<dynamic>.from(building.map((x) => x)),
        "floor": List<dynamic>.from(floor.map((x) => x)),
        "wing": List<dynamic>.from(wing.map((x) => x)),
        "rooms": List<dynamic>.from(rooms.map((x) => x)),
    };
}
