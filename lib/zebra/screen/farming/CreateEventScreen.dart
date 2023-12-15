// create_events.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import '../../dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({Key? key}) : super(key: key);

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  final _formKey = GlobalKey<FormState>();

  String? selectedFarm;
  String? selectedCrop;
  String? multiHint;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<String> crops = [];
  List<String> farmEvents = [];
  List<String> selectedFarmEvents = [];

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

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == 'mr') {
      crops = CustomTranslationList.crops_mr;
      farmEvents = CustomTranslationList.farmEvents_mr;
    } else if (context.locale.languageCode == 'en') {
      crops = CustomTranslationList.crops_en;
      farmEvents = CustomTranslationList.farmEvents_en;
    }

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
                NxDDFormField(
                  value: selectedFarm,
                  label: LocaleKeys.selectFarm,
                  items: farms.map((farm) => farm.farmName ?? 'Unknown Farm').toList(),
                  onChanged: (String? farmName) {
                    setState(() {
                      selectedFarm = farmName;
                      if (farmName != null) {
                        print('Selected Farm: $farmName');
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedCrop,
                  label: LocaleKeys.selectCrop,
                  items: crops,
                  onChanged: (String? cropName) {
                    setState(() {
                      selectedCrop = cropName;
                      if (cropName != null) {
                        print('Selected Crop: $cropName');
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropDownMultiSelect(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.selectEvent.tr(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.lightGreen.shade400),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      //label:Text(widget.label.tr())
                    ),
                    onChanged: (List<String> ev) {
                      setState(() {
                        selectedFarmEvents = ev;
                      });
                    },
                    options: farmEvents,
                    selectedValues: selectedFarmEvents,
                    hint: Text(LocaleKeys.selectEvent.tr()),
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

  Widget buildDateField(String label, DateTime? selectedDate, bool isStartDate) {
    return NxDateField(
      label: label,
      labelText: label,
      selectedDate: selectedDate,
      isStartDate: isStartDate,
      onTap: (DateTime? picked) {
        setState(() {
          if (isStartDate) {
            startDate = picked;
          } else {
            endDate = picked;
          }
        });
      },
    );
  }
}
