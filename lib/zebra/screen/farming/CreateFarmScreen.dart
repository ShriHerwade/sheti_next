import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxDropDownFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';

class CreateFarms extends StatefulWidget {
  const CreateFarms({super.key});

  @override
  State<CreateFarms> createState() => _CreateFarmsState();
}

class _CreateFarmsState extends State<CreateFarms> {
  final _formKey = new GlobalKey<FormState>();
  final _confarmName = TextEditingController();
  final _confarmAddress = TextEditingController();
  final _confarmArea = TextEditingController();
  final _farmType=["Owned","Leased","Joint Venture"];
  final _unit=["Acres","Hecters"];
  //final _comArea = selectedText;
  //final _comType =
  DbHelper? dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
  }
  /*saveFarm() async {

    String farm_Name = _confarmName.text;
    String farm_Address = _confarmAddress.text;
    String farm_Area = _confarmArea.text;
    String farm_Unit = _conpin.text;
    String farm_Type = _conpin.text;

    //DateTime createdDate= _createdDate;
    //DateTime updatedDate = _updatedDate;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      UserModel uModel = UserModel(user_id, user_name, email, mobileNo, pin); //,createdDate,updatedDate);
      await dbHelper.saveData(uModel).then((userData) {
        alertDialog(context, "Successfully Saved");
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Data Save Failed");
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Farm"),
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
                        /* Text("Create your account",
                          style:TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black12,
                              fontSize: 40.0),
                        ),*/
                        const SizedBox(height: 10),
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
                    hintName: "Farm Address",
                    inputType: TextInputType.name,

                  ),
                  SizedBox(height: 10.0),
                  NxTextFormField(
                    controller: _confarmArea,
                    hintName: "Area",
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  NxDDFormField(
                    selectOptionText: "Choose Farm Unit",
                      options: _unit,
                      value: '',
                      onChanged: (New){},
                      ),
                  const SizedBox(height: 10),
                  NxDDFormField(
                      selectOptionText: "Choose Farm Type",
                      options: _farmType,
                      value: "",
                      onChanged: (New){},
                      ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      onPressed:(){} ,//saveFarm,
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
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
