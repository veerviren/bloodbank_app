import 'package:bloodbank_app/constants/colors.dart';
import 'package:bloodbank_app/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  // variable

  // static Map<String, String> userData = {
  //   "name": "",
  //   "dateOfBirth": "",
  //   "age": "",
  //   "healthConditions": "",
  //   "bloodGroup": "",
  // };

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    onInit();
    super.initState();
  }

  // declaring a function so that the initState can call it without asynchrony
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: MyColors.redPrimary,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textFieldWithLabel(
                  "Your Name",
                  userDataFieldKey: "name",
                ),
                textFieldWithLabel(
                  "Date of Birth",
                  userDataFieldKey: "dateOfBirth",
                ),
                textFieldWithLabel(
                  "Age",
                  userDataFieldKey: "age",
                ),
                textFieldWithLabel(
                  "Prevailing Health Conditions",
                  userDataFieldKey: "healthConditions",
                ),
                textFieldWithLabel(
                  "Blood Group",
                  userDataFieldKey: "bloodGroup",
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      print("Valid");
                      _formKey.currentState!.save();
                      // prefs.setString(key, value)

                      // Navigator.pushNamed(context, Routes.home);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldWithLabel(String title, {required String userDataFieldKey}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            onSaved: (newValue) => {
              newValue != null && newValue.isNotEmpty
                  ? prefs.setString(
                      userDataFieldKey,
                      newValue,
                    )
                  : prefs.setString(userDataFieldKey, ""),
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
