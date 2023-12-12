import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';


class CreateExpenses extends StatefulWidget {
  const CreateExpenses({Key? key});

  @override
  State<CreateExpenses> createState() => _CreateExpensesState();
}

class _CreateExpensesState extends State<CreateExpenses> {
  final _formKey = GlobalKey<FormState>();
  final _confamount = TextEditingController();
  //final _farmName = ["Nadikadil", "Mala", "Vhanda"];
  final _cropNames = ["Sugarcane - Other", "Sugarcane - 80011", "Jwari - Shalu", "Jwari - Other"];
  final _farmEvents = [
    "Rotavator",
    "Ploughing",
    "Sowing",
    "Irrigation",
    "Compost",
    "Fertilizers",
    "Pesticides",
    "Harvesting",
    "Storage",
    "Transport"
  ];
  String? selectedFarm;
  String? selectedCrop;
  String? selectedEvent;
  DateTime? selectedDate;
  DbHelper? dbHelper;
  List<FarmModel> farms = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadFarms(); // Load farms when the widget initializes
  }

  // Load farms from the database
  Future<void> loadFarms() async {
    farms = await dbHelper!.getAllFarms();
    setState(() {});
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(LocaleKeys.createExpense.tr()),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Image.asset(
                          "assets/images/top_create-life-cycle-event-2.png",
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedFarm,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(LocaleKeys.selectFarm.tr()),
                        ),
                        onChanged: (String? farmName) {
                          setState(() {
                            selectedFarm = farmName;
                            if (farmName != null) {
                              print('Selected Farm: $farmName');
                            }
                          });
                        },
                        items: farms.map((FarmModel farm) {
                          return DropdownMenuItem<String>(
                            value: farm.farmName,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(farm.farmName ?? 'Unknown Farm'),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCrop,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(LocaleKeys.selectCrop.tr()),
                        ),
                        onChanged: (String? cropName) {
                          setState(() {
                            selectedCrop = cropName;
                          });
                        },
                        items: _cropNames.map((String farm) {
                          return DropdownMenuItem<String>(
                            value: farm,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(farm),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedEvent,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(LocaleKeys.selectEvent.tr()),
                        ),
                        onChanged: (String? eventName) {
                          setState(() {
                            selectedEvent = eventName;
                          });
                        },
                        items: _farmEvents.map((String event) {
                          return DropdownMenuItem<String>(
                            value: event,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text('farmEvents.$event'.tr()),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  buildDateField(LocaleKeys.expenseDate.tr()),
                  SizedBox(height: 20.0),
                  NxTextFormField(
                    controller: _confamount,
                    hintName: LocaleKeys.expenseAmount.tr(),
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: isSaveButtonEnabled() ? () => saveExpenseData(context) : null,
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: isSaveButtonEnabled() ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(String label) {
    return Container(
      width: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          hintText: selectedDate != null ? formatDate(selectedDate) : label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          suffixIcon: Icon(Icons.calendar_today),
          border: InputBorder.none,
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }

  bool isSaveButtonEnabled() {
    return selectedFarm != null &&
        selectedCrop != null &&
        selectedEvent != null &&
        selectedDate != null &&
        _confamount.text.isNotEmpty;
  }

  void saveExpenseData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Handle save logic using selected values (selectedFarm, selectedCrop, selectedEvent, selectedDate, _confamount.text)

      _confamount.clear();
      selectedFarm = null;
      selectedCrop = null;
      selectedEvent = null;
      selectedDate = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Expense data saved successfully!"),
        ),
      );
    }
  }
}
