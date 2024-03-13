import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/EventModel.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyEventTimeline extends StatefulWidget {
  const MyEventTimeline({Key? key}) : super(key: key);

  @override
  _MyEventTimelineState createState() => _MyEventTimelineState();
}

class _MyEventTimelineState extends State<MyEventTimeline> {
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("My Events Timeline"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<EventModel>>(
        future: dbHelper!.getAllEvents(),
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
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1, // Adjust this value as needed for proper alignment
                  isFirst: index == 0,
                  isLast: index == snapshot.data!.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    height: 20,
                    indicator: _buildEventIndicator(event),
                  ),
                  startChild: Container(), // Empty container for the timeline line
                  endChild: _buildEventCard(event),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildEventIndicator(EventModel event) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Card(
      elevation: 1.5,

      surfaceTintColor: ColorConstants.listViewSurfaceTintColor,
      margin: EdgeInsets.fromLTRB(30.0, 5.0, 80.0, 5.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(15.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.eventType ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Start Date: ${DateFormat("dd-MM-yyyy").format(event.startDate!)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'End Date: ${DateFormat("dd-MM-yyyy").format(event.endDate!)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            Text(
              event.notes ?? '',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
