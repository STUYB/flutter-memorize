import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memorize/models/event.dart';
import 'package:memorize/services/event_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> _events = [];
  final EventService _eventService = EventService();
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          try {
            final stream = _eventService.fetchEvents();
            final events = await stream.toList();
            setState(() {
              _events = events;
            });
          } catch (e) {
            Fluttertoast.showToast(
                msg: localizer.networkError,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: const Color.fromARGB(255, 222, 133, 127),
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.calendar_month),
                        title: Text(_events[index].title),
                        subtitle: Text(
                          _events[index].date,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _events[index].description,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Image.network(_events[index].image),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () async {
            try {
              final stream = _eventService.fetchEvents();
              final events = await stream.toList();
              setState(() {
                _events = events;
              });
            } catch (e) {
              Fluttertoast.showToast(
                  msg: localizer.networkError,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color.fromARGB(255, 222, 133, 127),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }),
    );
  }
}
