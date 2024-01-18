import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/LatestExpenseModel.dart';

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 1,
    initialPage: 0,
  );

  int _currentPage = 0;
  List<LatestExpenseModel> latestExpenses = [];
  bool showAll = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLatestExpenses();
  }

  Future<void> fetchLatestExpenses() async {
    try {
      List<LatestExpenseModel> expenses =
      await DbHelper().getLatestExpenses();
      setState(() {
        latestExpenses = expenses;
        isLoading = false;
      });
    } catch (e) {
      print('Error getting latest expenses: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
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
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildCard(index),
                  );
                },
                itemCount: 5,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: showAll
                  ? latestExpenses.length
                  : latestExpenses.length > 5
                  ? 5
                  : latestExpenses.length,
              itemBuilder: (context, index) {
                if (index < latestExpenses.length) {
                  return ListTile(
                    title: Text(
                      '${latestExpenses[index].farmName} - ${latestExpenses[index].cropName}',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(
                      'No more records !',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16),
            if (latestExpenses.length > 5)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!showAll)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showAll = true;
                          });
                        },
                        child: Text('Show All'),
                      ),
                    if (showAll)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showAll = false;
                          });
                        },
                        child: Text('Hide'),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    return Container(
      child: _getCardWidget(index),
    );
  }

  Widget _getCardWidget(int index) {
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
        return Container();
    }
  }
}

class WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
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
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, size: 40, color: Colors.black),
            SizedBox(height: 8),
            Text('Tasks Overview', style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text('Total Tasks: 10', style: TextStyle(color: Colors.black)),
            Text('Completed: 7', style: TextStyle(color: Colors.black)),
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
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
