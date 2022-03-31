import 'package:flutter/material.dart';
import 'package:s_kart/screens/login_screen.dart';
import 'package:s_kart/services/firebase_services.dart';
import 'package:s_kart/utils/styles.dart';
import 'package:s_kart/widgets/Sbutton.dart';
import 'package:s_kart/widgets/stextfield.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // const SignupScreen({Key? key}) : super(key: key);
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController retypasswordC = TextEditingController();
  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final formkey = GlobalKey<FormState>();

  bool ispassword = true;
  bool isretypepassword = true;
  bool formStateLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailC.dispose();
    passwordC.dispose();
    retypasswordC.dispose();
    super.dispose();
  }

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
        if (passwordC.text == retypasswordC.text) {
          String? accountstatus =
              await FirebaseServices.createAccount(emailC.text, passwordC.text);
          if (accountstatus != null) {
            SDialogue(accountstatus);
            setState(() {
              formStateLoading = false;
            });
          } else {
            Navigator.pop(context);
          }
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => LoginScreen()));
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "WELCOME \n Please Create Your Account",
                  textAlign: TextAlign.center,
                  style: SStyle.boldStyle,
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Stextfield(
                              check: true,
                              validate: (v) {
                                if (v!.isEmpty ||
                                    !v.contains("@") ||
                                    !v.contains(".com")) {
                                  return "email is badly formated";
                                }
                                return null;
                              },
                              inputAction: TextInputAction.next,
                              controller: emailC,
                              hintText: "Enter Email",
                              icon: const Icon(Icons.email),
                            ),
                            Stextfield(
                              validate: (v) {
                                if (v!.isEmpty) {
                                  return "password should note be empty";
                                }
                                return null;
                              },
                              focusNode: passwordfocus,
                              isPassword: ispassword,
                              controller: passwordC,
                              inputAction: TextInputAction.next,
                              hintText: "Password",
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      ispassword = !ispassword;
                                    });
                                  },
                                  icon: ispassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                            ),
                            Stextfield(
                              isPassword: isretypepassword,
                              controller: retypasswordC,
                              validate: (v) {
                                if (v!.isEmpty) {
                                  return "password should note be empty";
                                }
                                return null;
                              },
                              hintText: "Retype Password",
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isretypepassword = !isretypepassword;
                                    });
                                  },
                                  icon: isretypepassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                            ),
                            SButton(
                              title: "SIGNUP",
                              isLoginButton: true,
                              onPress: () {
                                submit();
                              },
                              isLoading: formStateLoading,
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SButton(
                  title: "BACK TO LOGIN",
                  onPress: () {
                    Navigator.pop(context);
                  },
                  isLoginButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
