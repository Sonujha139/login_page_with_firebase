//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:s_kart/screens/home_screen.dart';
import 'package:s_kart/screens/signup_screen.dart';
import 'package:s_kart/services/firebase_services.dart';
import 'package:s_kart/utils/styles.dart';
import 'package:s_kart/widgets/Sbutton.dart';
import 'package:s_kart/widgets/stextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordC = TextEditingController();

  TextEditingController emailC = TextEditingController();

  Future<void> SDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              SButton(
                title: "CLOSE",
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      String? accountstatus =
          await FirebaseServices.signInAccount(emailC.text, passwordC.text);
      if (accountstatus != null) {
        SDialogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "WELCOME \n Please Login First",
                textAlign: TextAlign.center,
                style: SStyle.boldStyle,
              ),
              Column(
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Stextfield(
                            controller: emailC,
                            hintText: "Enter Email",
                             validate: (v) {
                                if (v!.isEmpty) {
                                   return "email is badly formated";
                                }
                                return null;
                              },
                          ),
                          Stextfield(
                            controller: passwordC,
                            hintText: "Enter Password",
                             validate: (v) {
                                if (v!.isEmpty) {
                                  return "password should note be empty";
                                }
                                return null;
                              },
                          ),
                          SButton(
                            title: "LOGIN",
                            isLoading: formStateLoading,
                            isLoginButton: true,
                            onPress: () {
                              submit();
                            },
                          ),
                        ],
                      )),
                ],
              ),
              SButton(
                title: "CREATE NEW ACCOUNT",
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                isLoginButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
