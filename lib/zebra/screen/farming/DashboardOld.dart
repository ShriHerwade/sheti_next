import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreenOld extends StatefulWidget {
  @override
  _DashboardScreenOldState createState() => _DashboardScreenOldState();
}

class _DashboardScreenOldState extends State<DashboardScreenOld> {
  String temperature = '';
  String airFlow = '';
  String humidity = '';
  String rain = '';

  List<ExpenseModel> expenses = [
   /* ExpenseModel(
        farmId: 1,
        farmName: 'Riverside Farm',
        cropName: 'Jwari',
        expenseType: 'Sowing',
        amount: 10000,
        expenseDate: DateTime.now()),
    ExpenseModel(
        farmId: 2,
        farmName: 'Mala Farm',
        cropName: 'Sugercane',
        expenseType: 'Irigation',
        amount: 20000,
        expenseDate: DateTime.now()),
    ExpenseModel(
        farmId: 3,
        farmName: 'Mala Farm',
        cropName: 'Mango',
        expenseType: 'Cultivation',
        amount: 15000,
        expenseDate: DateTime.now()),*/
    // Add more expense data
  ];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for illustration purposes
    List<ExpenseModel> expenses = [
     /* ExpenseModel(
          farmName: 'Riverside Farm',
          cropName: 'Sugarcane',
          expenseType: 'Seeds',
          amount: 200,
          expenseDate: DateTime.now()),*/
      // Add more expense records
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting message
            Text(_getGreetingMessage(), style: TextStyle(fontSize: 18)),

            // Scrollable cards
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildWeatherCard(),
                    _buildTasksCard(),
                    _buildThisWeekCard(),
                    _buildCropWiseExpenseCard(),
                    // Add more cards as needed
                  ],
                ),
              ),
            ),

            // Latest expenses list
            SizedBox(
              height: 150,
              child: _buildLatestExpensesList(expenses),
            ),

            // Pie chart
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildExpensePieChart(expenses),
              ),
            ),
          ],
        ),
      ),

      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the floating action button click
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _getGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String greetingMessage;
    if (hour >= 5 && hour < 12) {
      greetingMessage = 'Good Morning !';
    } else if (hour >= 12 && hour < 17) {
      greetingMessage = 'Good Afternoon !';
    } else {
      greetingMessage = 'Good Evening !';
    }
    return greetingMessage;
  }

  Widget _buildWeatherCard() {
    // Dummy weather data
    double temperature = 25.0;
    double airFlow = 15.0;
    double humidity = 60.0;
    double rain = 5.0;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weather',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherInfo('Temp', '$temperature°C'),
                _buildWeatherInfo('Air Flow', '$airFlow m/s'),
                _buildWeatherInfo('Humidity', '$humidity%'),
                _buildWeatherInfo('Rain', '$rain mm'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text(value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTasksCard() {
    // Dummy task data
    int completedTasks = 8;
    int totalTasks = 10;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressCircle(completedTasks, totalTasks),
                SizedBox(width: 16),
                Text('$completedTasks / $totalTasks Tasks Completed',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCircle(int completed, int total) {
    double progress = completed / total;
    return SizedBox(
      width: 100,
      height: 100,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 8,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  Widget _buildThisWeekCard() {
    // Dummy expense data for this week
    double totalExpense = 2000.0;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This Week',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildCircularExpenseIndicator(totalExpense),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularExpenseIndicator(double totalExpense) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightGreen,
      ),
      child: Center(
        child: Text(
          '\$$totalExpense',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // alpha (opacity), 255 for fully opaque
      random.nextInt(256), // red
      random.nextInt(256), // green
      random.nextInt(256), // blue
    );
  }

  Widget _buildBarChart(Map<String, double> data) {
    List<BarChartGroupData> barChartGroupData = List.generate(
      data.length,
      (index) {
        return BarChartGroupData(
          x: index + 1,
          barsSpace: 4,
          barRods: [
            BarChartRodData(
              toY: data.values.elementAt(index),
              color: _getRandomColor(),
            ),
          ],
        );
      },
    );

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: data.values
                .reduce((value, element) => value > element ? value : element) +
            500, // Adjust maxY as per your data
        barGroups: barChartGroupData,
      ),
    );
  }

  Widget _buildCropWiseExpenseCard() {
    Map<String, double> cropWiseExpenses = {
      'Jwari': 1000.0,
      'Sugercane': 2000.0,
      'Rice': 6400,
      // Add more data
    };

    // Calculate total expenses for each crop
    for (var expense in expenses) {
      /*String cropKey = '${expense.farmName}-${expense.cropName}';
      if (cropWiseExpenses.containsKey(cropKey)) {
        cropWiseExpenses[cropKey] ??= 0; // Initialize to 0 if null
        cropWiseExpenses[cropKey] = cropWiseExpenses[cropKey]! + expense.amount;
      }*/
      return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Crop Wise Expenses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildBarChart(cropWiseExpenses),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildExpenseListItem(ExpenseModel expense) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*Text('${expense.farmName} - ${expense.cropName}'),*/
        Text('${expense.expenseType} - \$${expense.amount.toString()}'),
      ],
    );
  }

  Widget _buildLatestExpensesList(List<ExpenseModel> expenses) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latest Expenses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: expenses.take(5).map((expense) {
                return _buildExpenseListItem(expense);
              }).toList(),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                // Handle "Show More" click
              },
              child: Text('Show More', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchWeatherData() async {
    final apiKey = 'YOUR_API_KEY'; // Replace with your OpenWeatherMap API key
    final city = 'YOUR_CITY'; // Replace with the desired city

    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);

        setState(() {
          temperature = (weatherData['main']['temp'] - 273.15)
              .toStringAsFixed(1); // Convert to Celsius
          airFlow = weatherData['wind']['speed'].toString();
          humidity = weatherData['main']['humidity'].toString();
          rain = weatherData.containsKey('rain')
              ? weatherData['rain']['1h'].toString()
              : '0';
        });
      } else {
        // Handle error
        print(
            'Failed to load weather data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error fetching weather data: $e');
    }
  }

  Widget _buildExpensePieChart(List<ExpenseModel> expenses) {
    // Extract data for the pie chart
    Map<String, double> expenseCategories = {};

    for (var expense in expenses) {
      expenseCategories[expense.expenseType] ??= 0;
      expenseCategories[expense.expenseType] =
          expenseCategories[expense.expenseType]! + expense.amount;
    }

    // Build the pie chart
    return PieChart(
      PieChartData(
        sections: expenseCategories.entries.map((entry) {
          return PieChartSectionData(
            value: entry.value,
            title: '${entry.key}\n${entry.value.toString()}',
            color: _getRandomColor(),
          );
        }).toList(),
        // Other configurations for the pie chart
      ),
    );
  }
}
