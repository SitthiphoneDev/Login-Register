import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/screen/new_password.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _keyform = GlobalKey<FormState>();
  String? code1, code2, code3, code4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/OTPverification.jpeg"),
              const Text(
                "OTP Verification?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                  "Enter the verification code we just sent on your email address."),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _keyform,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 64,
                      height: 60,
                      child: TextFormField(
                        onSaved: (pin1) {
                          code1 = pin1;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10)),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, //input number only
                          LengthLimitingTextInputFormatter(1)
                        ],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      height: 60,
                      child: TextFormField(
                        onSaved: (pin2) {
                          code2 = pin2;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10)),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, //input number only
                          LengthLimitingTextInputFormatter(1)
                        ],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      height: 60,
                      child: TextFormField(
                        onSaved: (pin3) {
                          code3 = pin3;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10)),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, //input number only
                          LengthLimitingTextInputFormatter(1)
                        ],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      height: 60,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (pin4) {
                          code4 = pin4;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10)),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, //input number only
                          LengthLimitingTextInputFormatter(1)
                        ],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_keyform.currentState!.validate()) {
                      _keyform.currentState!.save();
                      print(code1);
                      print(code2);
                      print(code3);
                      print(code4);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Newpassword()));
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  child: const Text(
                    "Send Code",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Don't received code? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(text: "Resend", style: TextStyle(color: Colors.blue))
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
