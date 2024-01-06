import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/LatestExpenseModel.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.5, // deals with the width of the card
    initialPage: 0,
  );

  int _currentPage = 0;

  // Placeholder list for latest expenses
  List<LatestExpenseModel> latestExpenses = [];
  bool showAll = false;

  @override
  void initState() {
    super.initState();
    fetchLatestExpenses();
  }

  Future<void> fetchLatestExpenses() async {
    try {
      latestExpenses = await DbHelper().getLatestExpenses();
      setState(() {});
    } catch (e) {
      // Handle error
      print('Error fetching latest expenses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(left: index == 0 ? 0.0 : 4.0, right: 4.0),
                  child: _buildCard(index),
                );
              },
              itemCount:
                  5, // Change this number based on the total number of cards
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5, // Change this number based on the total number of cards
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                // gap between the dots
                child: CircleAvatar(
                  radius: 4.0,
                  backgroundColor:
                      _currentPage == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Latest Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: latestExpenses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${latestExpenses[index].farmName} - ${latestExpenses[index].cropName}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${latestExpenses[index].expenseType}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '${latestExpenses[index].expenseDate.day}.${latestExpenses[index].expenseDate.month}.${latestExpenses[index].expenseDate.year}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '\₹${latestExpenses[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          if (latestExpenses.length > 6 && !showAll)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    // Toggle the showAll flag
                    showAll = true;
                  });
                  fetchLatestExpenses();
                },
                child: Text('Show All'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard(int index) {
    switch (index) {
      case 0:
        return WeatherCard();
      case 1:
        return TaskCard();
      case 2:
        return ExpenditureCard();
      case 3:
        return PlannedEventsCard();
      case 4:
        return OffersCard();
      default:
        return Container(); // Return an empty container if index is out of bounds
    }
  }
}

// ... rest of the card classes remain unchanged

class WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25,
      shadowColor: Colors.black26,
      margin: EdgeInsets.only(left: 0.0, right: 4.0, top: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0), // inner text padding
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.wb_sunny, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text('Today\'s Weather',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text('Temperature: 28°C', style: TextStyle(color: Colors.white)),
            Text('Humidity: 60%', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text('Tasks Overview',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text('Total Tasks: 10', style: TextStyle(color: Colors.white)),
            Text('Completed: 7', style: TextStyle(color: Colors.white)),
            LinearProgressIndicator(
                value: 0.7, backgroundColor: Colors.white.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}

class ExpenditureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.monetization_on, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text('This Week\'s Expenditure',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text('Amount: \$5000', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class PlannedEventsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.event, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text('Planned Events',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text('This Week: 3', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class OffersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      margin: EdgeInsets.only(left: 4.0, right: 0.0, top: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.local_offer, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text('Special Offers',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text('Get 20% off on fertilizers',
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}
