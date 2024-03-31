import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/screen/otp_verification.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final emailcontroller = TextEditingController();
  final _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyform,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/forget_password.jpg"),
                const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                    "Don't worry! it accurs Please enter the email address linked with your account."),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailcontroller,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "ກະລຸນາໃສ່ອີເມລ"),
                    EmailValidator(errorText: "ກະລຸນາໃສ່ອີເມລໃຫ້ຖືກຕ້ອງ")
                  ]).call,
                  decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      fillColor: const Color.fromARGB(255, 229, 229, 229),
                      filled: true),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_keyform.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailcontroller.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Verification(),
                            ),
                          );
                        } catch (e) {
                          if (e is FirebaseAuthException) {
                            print('Firebase Auth Error: ${e.message}');
                          } else {
                            print('Error: $e');
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: const Text(
                      "ສົ່ງລະຫັດ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
