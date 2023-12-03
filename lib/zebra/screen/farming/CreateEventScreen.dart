import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({super.key});

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  final _formKey = GlobalKey<FormState>();
  final _confarmName = TextEditingController();
  final _confarmAddress = TextEditingController();
  final _confarmArea = TextEditingController();
  final _farmName = ["Nadikadil", "Mala", "Vhanda"];
  final _unit = ["Acre", "Hectare"];
  final  double _fixHeight = 20;

  final _cropNames = ["Sugarcane - Other", "Sugarcane - 80011", "Jwari - Shalu", "Jwari - Other"];
  final _eventNames = ["Ploughing", "Sowing","Fertilizers","Pesticides","Irrigation","Harvesting","Storage","Transport"];

  String? selectedFarm;
  String? selectedUnit;
  String? selectedCrop;
  String? selectedEvent;
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text("Create New Event"),
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
                          child: Text('Select Farm'),
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
                          child: Text('Select Crop'),
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
                  SizedBox(height: 20.0 ),
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
                          child: Text('Select Event'),
                        ),
                        onChanged: (String? eventName) {
                          setState(() {
                            selectedEvent = eventName;
                            if (eventName != null) {
                              print('Selected Event: $eventName');
                            }
                          });
                        },
                        items: _eventNames.map((String event) {
                          return DropdownMenuItem<String>(
                            value: event,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(event),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
