import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'FarmsListScreen.dart';

class CreateFarms extends StatefulWidget {
  const CreateFarms({Key? key}) : super(key: key);

  @override
  State<CreateFarms> createState() => _CreateFarmsState();
}

class _CreateFarmsState extends State<CreateFarms> {
  final _formKey = GlobalKey<FormState>();
  final _confarmName = TextEditingController();
  final _confarmAddress = TextEditingController();
  final _confarmArea = TextEditingController();
  final _farmType = ["Owned", "Leased", "Joint Venture"];
  final _unit = ["Acre", "Hectare","Guntha","Square Feet","Square Meter"];

  String? selectedUnit;
  String? selectedType;
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
        title: Text("Create New Farm"),
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
                        const SizedBox(height: 30),
                        Image.asset(
                          "assets/images/top_create-farm-1.png",
                          height: 120,
                          width: 150,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  NxTextFormField(
                    controller: _confarmName,
                    hintName: "Farm Name",
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 20.0),
                  NxTextFormField(
                    controller: _confarmAddress,
                    hintName: "Address",
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 20.0),
                  NxTextFormField(
                    controller: _confarmArea,
                    hintName: "Area",
                    inputType: TextInputType.number,
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
                        value: selectedUnit,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text('Select Unit'),
                        ),
                        onChanged: (String? unitValue) {
                          setState(() {
                            selectedUnit = unitValue;
                            if (unitValue != null) {
                              print('Selected Unit: $unitValue');
                            }
                          });
                        },
                        items: _unit.map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(unit),
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
                        value: selectedType,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text('Select Type'),
                        ),
                        onChanged: (String? typeValue) {
                          setState(() {
                            selectedType = typeValue;
                            if (typeValue != null) {
                              print('Selected Type: $typeValue');
                            }
                          });
                        },
                        items: _farmType.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(type),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Modified button width to 150
                      Container(
                        width: 150,
                        child: TextButton(
                          onPressed: () {
                            saveFarmData(context);
                          },
                          child: Text(
                            "Save",
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
                      // Modified button width to 150
                      Container(
                        width: 150,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FarmsListScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Show Farms",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveFarmData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FarmModel farm = FarmModel(
        farmName: _confarmName.text,
        farmAddress: _confarmAddress.text,
        farmArea: double.parse(_confarmArea.text),
        unit: selectedUnit!,
        farmType: selectedType!,
        isActive: true,
        createdDate: DateTime.now(),
      );

      await dbHelper!.saveFarmData(farm);

      _confarmName.clear();
      _confarmAddress.clear();
      _confarmArea.clear();
      selectedUnit = null;
      selectedType = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Farm data saved successfully!"),
        ),
      );
    }
  }
}
