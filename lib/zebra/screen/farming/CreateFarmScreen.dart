import 'package:flutter/material.dart';
//import 'package:sheti_next/zebra/common/widgets/NxDropDownFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';

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
                        const SizedBox(height: 50),
                        Image.asset(
                          "assets/images/W1.png",
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  NxTextFormField(
                    controller: _confarmName,
                    hintName: "Farm Name",
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 10.0),
                  NxTextFormField(
                    controller: _confarmAddress,
                    hintName: "Address",
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 10.0),
                  NxTextFormField(
                    controller: _confarmArea,
                    hintName: "Area",
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[200],
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
                  SizedBox(height: 10.0),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[200],
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
