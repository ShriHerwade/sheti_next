import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({Key? key}) : super(key: key);

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  final _formKey = GlobalKey<FormState>();
  final _confarmName = TextEditingController();
  final _confarmAddress = TextEditingController();
  final _confarmArea = TextEditingController();
  final _farmName = ["Nadikadil", "Mala", "Vhanda"];
  final _unit = ["Guntha","Acre", "Hectare"];
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
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.createEvent.tr()),
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
                        items: _farmName.map((String farm) {
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
                        value: selectedCrop,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(LocaleKeys.selectCrop.tr()),
                        ),
                        onChanged: (String? cropName) {
                          setState(() {
                            selectedCrop = cropName;
                            if (cropName != null) {
                              print('Selected Crop: $cropName');
                            }
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
                            if (eventName != null) {
                              print('Selected Event: $eventName');
                            }
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
                  buildDateField(LocaleKeys.eventStartDate.tr(), startDate, true),
                  SizedBox(height: 20.0),
                  buildDateField(LocaleKeys.eventEndDate.tr(), endDate, false),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        // Handle save logic using selected dates (startDate and endDate)
                      },
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
                      color: Colors.green,
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

  Widget buildDateField(String label, DateTime? selectedDate, bool isStartDate) {
    return Container(
      width: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context, isStartDate),
        decoration: InputDecoration(
          hintText: selectedDate != null ? formatDate(selectedDate) : '$label',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }
}
