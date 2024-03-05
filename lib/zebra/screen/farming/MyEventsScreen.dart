import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/EventModel.dart';
import 'package:sheti_next/zebra/screen/farming/CreateEventScreen.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    initializeDbHelper();
  }

  Future<void> initializeDbHelper() async {
    dbHelper = DbHelper();
    //await dbHelper.initDatabase();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (dbHelper == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CreateEvents()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Events"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<EventModel>>(
          future: dbHelper.getAllEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text("No events available."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  EventModel event = snapshot.data![index];

                  return Card(
                    elevation: 5.0,
                    margin: EdgeInsets.all(10.0),
                    color: Colors.lightBlueAccent,
                    child: ListTile(
                      title: Text(
                        event.eventType ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            'Start Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(event.startDate.toString()))}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'End Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(event.endDate.toString()))}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            event.notes ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
