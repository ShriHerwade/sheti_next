import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/screen/farming/HomeScreen.dart';
import 'package:sheti_next/zebra/screen/user/SignupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheti_next/zebra/common/widgets//NxAlert.dart';
import 'package:sheti_next/zebra/common/util/InputValidator.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/UserModel.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final _formKey = new GlobalKey<FormState>();

  final _conPin = TextEditingController();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String pin = _conPin.text;
    if (pin.isEmpty) {
      alertDialog(context, "Please Enter Pin");
    } else {
      await dbHelper.getLoginUser(pin).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Invalid User or PIN.");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Login Failed.");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    sp.setString("user_id", user.firstName);
    sp.setString("user_ame", user.lastName);
    sp.setString("email", user.email);
    sp.setString("mobileNo", user.mobileNo);
    sp.setString("pin", user.pin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Secret PIN"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      /* Text("Login To ShetiNext",
              style:TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40.0),
            ),*/
                      const SizedBox(height: 10),
                      Image.asset(
                        "assets/images/W2.png",
                        height: 300,
                        width: 300,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                NxTextFormField(
                  controller: _conPin,
                  icon: Icons.lock,
                  hintName: "PIN",
                  isObsecureText: true,
                  inputType: TextInputType.number,
                  maxLength: 4,

                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: login,
                    child: Text(
                      "Login",
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
                      Text("Dont have account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupScreen()));
                          },
                          child: Text(
                            "SignUp",
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
    );
  }
}
