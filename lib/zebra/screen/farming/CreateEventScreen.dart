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
  final _unit = ["Guntha", "Acre", "Hectare"];
  final _cropNames = [
    "Sugarcane - Other",
    "Sugarcane - 80011",
    "Jwari - Shalu",
    "Jwari - Other"
  ];
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
    final dropdownStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/top_create-life-cycle-event-2.png",
                  height: 120,
                  width: 150,
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                  color: Colors.lightGreen.shade400)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          fillColor: Colors.white,
                          filled: true),
                      value: selectedFarm,
                      hint: Text(LocaleKeys.selectFarm.tr(),
                        style: dropdownStyle,
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
                          child: Text(farm),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                  color: Colors.lightGreen.shade400)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          fillColor: Colors.white,
                          filled: true),
                      value: selectedCrop,
                      hint: Text(LocaleKeys.selectCrop.tr()),
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
                          child: Text(farm),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                  color: Colors.lightGreen.shade400)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          fillColor: Colors.white,
                          filled: true),
                      value: selectedEvent,
                      hint: Text(LocaleKeys.selectEvent.tr()),
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
                          child: Text('farmEvents.$event'.tr()),
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
    );
  }

  Widget buildDateField(
      String label, DateTime? selectedDate, bool isStartDate) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context, isStartDate),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                      color: Colors.lightGreen.shade400)),
              disabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              errorBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              fillColor: Colors.white,
              filled: true,
          hintText: selectedDate != null ? formatDate(selectedDate) : '$label',

          suffixIcon: Icon(Icons.calendar_today),
          border: InputBorder.none,
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }
}
