import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/constant/SizeConstants.dart';
import '../../dao/DbHelper.dart';
import '../../dao/models/ViewExpenseModel.dart';

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
 /*final PageController _pageController = PageController(
    viewportFraction: 1,
    initialPage: 0,
  );*/

//  int _currentPage = 0;
  List<ViewExpenseModel> latestExpenses = [];
  bool showAll = false;
  bool isLoading = true;

  // Define your actual data for the pie chart
 /* Map<String, double> dataMap = {
    'Category1': 30,
    'Category2': 20,
    'Category3': 10,
    'Category4': 40,
  };*/

  /*List<Color> colorList = [Colors.blue, Colors.green,Colors.yellowAccent, Colors.cyan];*/

  @override
  void initState() {
    super.initState();
    fetchLatestExpenses();
  }

  Future<void> fetchLatestExpenses() async {
    try {
      List<ViewExpenseModel> expenses = await DbHelper().getLatestExpenses();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
       /* appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: false,
        ),*/
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Container(
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
              SizedBox(height: 8),*/
             /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: CircleAvatar(
                      radius: 4.0,
                      backgroundColor: _currentPage == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Latest Expenses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),*/
              SingleChildScrollView(

                scrollDirection: Axis.vertical,
                child: ListView.builder(

                  padding: EdgeInsets.all(15.0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: showAll
                      ? latestExpenses.length
                      : latestExpenses.length > 5
                      ? 5
                      : latestExpenses.length,
                  itemBuilder: (context, index) {
                    if (index < latestExpenses.length) {
                      return ListTile(

                        tileColor: ColorConstants.listViewBackgroundColor,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${latestExpenses[index].cropName}',
                                style: TextStyle(
                                  fontSize: SizeConstants.listViewTitleFontSize,
                                  fontWeight: SizeConstants.listViewDataFontSemiBold,
                                  color: Colors.black, // Adjust as needed
                                ),
                              ),
                              TextSpan(
                                text: ', ${latestExpenses[index].farmName}',
                                style: TextStyle(
                                  fontSize: SizeConstants.listViewData15FontSize,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Adjust as needed
                                ),
                              ),
                            ],
                          ),
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
                            fontSize: SizeConstants.listViewData16FontSize,
                            fontWeight: SizeConstants.listViewDataFontSemiBold,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      );
                    } else {
                      return ListTile(
                        title: Text(
                          'No more records !',
                          style: TextStyle(
                            fontSize: SizeConstants.listViewData16FontSize,
                            fontWeight: SizeConstants.listViewDataFontSemiBold,
                          ),
                        ),
                      );
                    }
                  },
                ),
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
              SizedBox(height: 16),
      
            ],
          ),
        ),
      ),
    );
  }

  /*Widget _buildCard(int index) {
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
  }*/
}

/*class WeatherCard extends StatelessWidget {
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
            Text(
              'Today\'s Weather',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('Temperature: 28°C', style: TextStyle(color: Colors.white)),
            Text('Humidity: 60%', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}*/

/*class TaskCard extends StatelessWidget {
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
            Text(
              'Tasks Overview',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('Total Tasks: 10', style: TextStyle(color: Colors.black)),
            Text('Completed: 7', style: TextStyle(color: Colors.black)),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*class ExpenditureCard extends StatelessWidget {
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
            Text(
              'This Week\'s Expenditure',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('Amount: \$5000', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}*/

/*class PlannedEventsCard extends StatelessWidget {
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
            Text(
              'Planned Events',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('This Week: 3', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}*/

/*class OffersCard extends StatelessWidget {
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
            Text(
              'Special Offers',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Get 20% off on fertilizers',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*class CustomPieChart extends StatelessWidget {
  final Map<String, double> dataMap;
  final List<Color> colorList;

  CustomPieChart({required this.dataMap, required this.colorList});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: getSections(),
        sectionsSpace: 5,
        centerSpaceRadius: 20,
        centerSpaceColor: Colors.white,
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return List.generate(
      dataMap.length,
          (index) {
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;

        return PieChartSectionData(
          color: colorList[index],
          value: dataMap.values.elementAt(index),
          title: '${dataMap.keys.elementAt(index)}',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
      },
    );
  }

  int touchedIndex = -1;
}*/
