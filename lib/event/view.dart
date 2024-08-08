import 'package:facility_reservation/event/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventResult extends StatelessWidget {
  final Map<String, String?> userChoices;

  const EventResult({super.key, required this.userChoices});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(builder: (controller) {
      if (controller.events.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        // Filter events based on user choices
        var filteredEvents = controller.events.where((event) {
          return (userChoices['building'] == null || event.building == userChoices['building']) &&
                 (userChoices['floor'] == null || event.floor == userChoices['floor']) &&
                 (userChoices['room'] == null || event.roomNo == userChoices['room']);
        }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true, // Ensures the ListView takes only the space it needs
                physics: const NeverScrollableScrollPhysics(), // Prevents inner scrolling conflict
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Event ID: ${filteredEvents[index].eventId}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Building: ${filteredEvents[index].building}'),
                        Text('Floor: ${filteredEvents[index].floor}'),
                        Text('Room: ${filteredEvents[index].roomNo}'),
                        Text('Time: ${filteredEvents[index].startTime} - ${filteredEvents[index].endTime}'),
                        Text('Setup: ${filteredEvents[index].setup}'),
                        Text('Date: ${filteredEvents[index].date}'),
                      ],
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ],
          ),
        );
      }
    });
  }
}
