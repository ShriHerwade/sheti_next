import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        // Check if the swipe is a right swipe and not ambiguous or left swipe
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          // Right swipe
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
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 26.0,
                  headingRowHeight: 60,
                  dataRowHeight: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        "Event Type",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Start Date",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "End Date",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Details",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                  rows: snapshot.data!.map((event) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            event.eventType ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(DateTime.parse(event.startDate.toString())),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(DateTime.parse(event.endDate.toString())),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(
                            event.notes ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
