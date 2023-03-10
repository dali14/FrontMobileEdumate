import '../../../../event/domain/entities/event.dart';
import '../../pages/event_detail_page.dart';
import 'package:flutter/material.dart';


class EventListWidget extends StatelessWidget {
  final List<Event> events;
  const EventListWidget({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(events[index].id.toString()),
          title: Text(events[index].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(events[index].name, style: TextStyle(fontSize: 16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EventDetailPage(event: events[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}
