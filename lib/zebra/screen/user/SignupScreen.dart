import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/screen/user/LoginScreen.dart';
import 'package:sheti_next/zebra/common/widgets//NxAlert.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/UserModel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _confirstName = TextEditingController();
  final _conlastName = TextEditingController();
  final _conemail = TextEditingController();
  final _conmobileNo = TextEditingController();
  final _conpin = TextEditingController();
  final _createdDate = DateTime.now();
  final _updatedDate = DateTime.now();
  final _lastAccessedDate = DateTime.now();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String firstName = _confirstName.text;
    String lastName = _conlastName.text;
    String email = _conemail.text;
    String mobileNo = _conmobileNo.text;
    String pin = _conpin.text;

    DateTime createdDate= _createdDate;
    DateTime lastAccessedDate = _updatedDate;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      UserModel uModel = UserModel(accountId: 1, firstName: firstName, lastName: lastName, email: email, mobileNo: mobileNo, role: "Admin",pin: "123456");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create your account"),
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
                    controller: _confirstName,
                    hintName: "Enter First Name",
                    icon: Icons.person,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 10.0),
                  NxTextFormField(
                    controller: _conlastName,
                    hintName: "Enter Last Name",
                    inputType: TextInputType.name,
                    icon: Icons.person_2_outlined,
                  ),
                  SizedBox(height: 10.0),
                  NxTextFormField(
                    controller: _conemail,
                    hintName: "Enter Email",
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10.0),
                  NxTextFormField(
                    controller: _conmobileNo,
                    hintName: "Enter Mobile No",
                    icon: Icons.phone,
                    inputType: TextInputType.number,
                    setmaxLength: 10,
                  ),
                  NxTextFormField(
                    controller: _conpin,
                    hintName: "Enter PIN",
                    icon: Icons.lock,
                    isObsecureText: true,
                    setmaxLength: 4,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: signUp,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do you have an account ?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.green),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
