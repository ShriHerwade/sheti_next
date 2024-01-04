import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/EventModel.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
        centerTitle: true,
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
                          event.startDate?.toLocal().toString() ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      DataCell(
                        Text(
                          event.endDate?.toLocal().toString() ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      DataCell(
                        Text(
                          event.details ?? '',
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
    );
  }
}
