import 'package:http/http.dart' as http;
import 'package:memorize/models/event.dart';

import 'dart:convert';

class EventService {
  Stream<Event> fetchEvents() async* {
    try {
      final response =
          await http.get(Uri.parse("https://v0j97.mocklab.io/events"));

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch event');
      }
      for (var element in jsonDecode(response.body)) {
        yield Event.fromJson(element);
      }
    } catch (e) {
      throw Exception('Failed to fetch event');
    }
  }
}
