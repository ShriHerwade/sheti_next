import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/EventModel.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyEventTimeline extends StatefulWidget {
  final int cropId; // Add cropId parameter
  const MyEventTimeline({Key? key, required this.cropId}) : super(key: key);

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

  Future<List<EventModel>> _fetchEventsByCropId() async {
    return dbHelper!.getEventsByCropId(widget.cropId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("My Task Timeline"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when back arrow is clicked
          },
        ),
      ),
      body: FutureBuilder<List<EventModel>>(
        future: _fetchEventsByCropId(),
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
              child: Text("No Task available."),
            );
          } else {
            // Reverse the order of events
            List<EventModel> reversedEvents = snapshot.data!.reversed.toList();
            return ListView.builder(
              itemCount: reversedEvents.length,
              itemBuilder: (context, index) {
                EventModel event = reversedEvents[index];
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1, // Adjust this value as needed for proper alignment
                  isFirst: index == 0,
                  isLast: index == reversedEvents.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 40,
                    indicator: _buildEventIndicator(),
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.green, // Set the color of the timeline line to green
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

  Widget _buildEventIndicator() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Card(
      elevation: 1.5,
      surfaceTintColor: ColorConstants.listViewSurfaceTintColor,
      margin: EdgeInsets.fromLTRB(30.0, 20.0, 80.0, 20.0),
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
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'End Date: ${DateFormat("dd-MM-yyyy").format(event.endDate!)}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              event.notes ?? '',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
