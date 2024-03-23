import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../constant/ColorConstants.dart';
import '../../dao/models/ExpensePieChartModel.dart';
import '../../dao/DbHelper.dart';
import '../../dao/models/ViewExpenseModel.dart';

Future<List<ExpensePieChartModel>> getExpenseForPieChartByCrop() async {
  List<ExpensePieChartModel> expenses = await DbHelper().getExpenseForPieChartByCrop();
  return expenses ?? [];

}

class MyPieChartWidget extends StatefulWidget {
  @override
  _MyPieChartWidgetState createState() => _MyPieChartWidgetState();
}

class _MyPieChartWidgetState extends State<MyPieChartWidget> {
  List<ExpensePieChartModel> _expenses = [];
  List<ViewExpenseModel> _latestExpenses = [];
  int touchedIndex = -1;
  // Index to keep track of the current color
  int colorIndex = 0;
  // Convert the hexadecimal colors to Color objects
  List<Color> pieChartColors = ColorConstants.pieChartHexColors.map((hexColor) => Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000)).toList();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<ExpensePieChartModel> expenses = await getExpenseForPieChartByCrop();
    List<ViewExpenseModel> latestExpenses = await DbHelper().getLatestExpenses();
    setState(() {
      _expenses = expenses;
      _latestExpenses = latestExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: _expenses.isEmpty
                  ? (_expenses == null
                  ? Center(child: Text('No records to show'))
                  : Center(child: CircularProgressIndicator()))
                  : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        sections: _expenses.map((expense) {
                          // Get the color from the list based on the current index
                          Color selectedColor = pieChartColors[colorIndex];

                          // Increment the index for the next section
                          colorIndex = (colorIndex + 1) % pieChartColors.length;

                          return PieChartSectionData(
                            radius: 99.0,
                            title: expense.cropName,
                            value: expense.totalAmountSpent.toDouble(),
                            color: selectedColor,
                            titleStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),

                          );
                        }).toList(),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 5.0,
                        centerSpaceRadius: 40,
                        //sections: showingSections(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Latest Expenses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: _latestExpenses.isEmpty
                        ? Center(child: Text('No latest expenses'))
                        : ListView.builder(
                      itemCount: _latestExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = _latestExpenses[index];
                        return ListTile(
                          title: Text(
                            '${_latestExpenses[index].cropName} - (${_latestExpenses[index].farmName})',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_latestExpenses[index].expenseType}',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '${_latestExpenses[index].expenseDate.day}.${_latestExpenses[index].expenseDate.month}.${_latestExpenses[index].expenseDate.year}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '\₹${_latestExpenses[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


