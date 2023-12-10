import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
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
  final _farmTypes = ["Owned", "Leased", "Joint Venture"];
  final _units = ["Guntha","Acre", "Hectare"];

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
        title: Text( LocaleKeys.createFarm.tr()),
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
                    hintName:  LocaleKeys.farmName.tr(),
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 20.0),
                  NxTextFormField(
                    controller: _confarmAddress,
                    hintName:  LocaleKeys.address.tr(),
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 20.0),
                  NxTextFormField(
                    controller: _confarmArea,
                    hintName:  LocaleKeys.farmAea.tr(),
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
                          child: Text(LocaleKeys.selectUnit.tr(),),
                        ),
                        onChanged: (String? unitValue) {
                          setState(() {
                            selectedUnit = unitValue;
                            if (unitValue != null) {
                              print('Selected Unit: $unitValue');
                            }
                          });
                        },
                        items: _units.map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child:  Text('units.$unit'.tr()),
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
                          child: Text(LocaleKeys.farmType.tr()),
                        ),
                        onChanged: (String? typeValue) {
                          setState(() {
                            selectedType = typeValue;
                            if (typeValue != null) {
                              print('Selected Type: $typeValue');
                            }
                          });
                        },
                        items: _farmTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text('farmTypes.$type'.tr()),
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
