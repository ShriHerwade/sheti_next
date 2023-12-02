import 'package:flutter/material.dart';


import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
class CreateCrop extends StatefulWidget {
  const CreateCrop({super.key});

  @override
  State<CreateCrop> createState() => _CreateCropState();
}

class _CreateCropState extends State<CreateCrop> {
  final _formKey = GlobalKey<FormState>();
  final _concropName = TextEditingController();

  final _confarmArea = TextEditingController();
  final _farmType = ["Owned", "Leased", "Joint Venture"];
  final _unit = ["Acre", "Hectare"];


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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Crops"),
      ),
      body:  Form(

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
                          "assets/images/top_create-farm-1.png",
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedUnit,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text('Select Farm Name'),
                        ),
                        onChanged: (String? farmName) {
                          setState(() {
                            selectedUnit = farmName;
                            if (farmName != null) {
                              print('Selected Farm: $farmName');
                            }
                          });
                        },
                        items: _unit.map((String farm) {
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
                  NxTextFormField(
                    controller: _concropName,
                    hintName: "Crop Name",
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 20.0 ),
                  NxTextFormField(
                    controller: _confarmArea,
                    hintName: "Area",
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.blueGrey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedType,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text('Select Unit'),
                        ),
                        onChanged: (String? unit) {
                          setState(() {
                            selectedType = unit;
                            if (unit != null) {
                              print('Selected Unit: $unit');
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
