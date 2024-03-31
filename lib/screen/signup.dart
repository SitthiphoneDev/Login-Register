import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/model/profile_register.dart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/screen/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _keyform = GlobalKey<FormState>();
  Profileregister profileregister = Profileregister("", "", "", "");
  Future<FirebaseApp> firebase = Firebase.initializeApp();
  String? password;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _keyform,
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        height: 100,
                        width: 100,
                        child: Image.asset("assets/images/login.png"),
                      ),
                      Container(
                        height: 20,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const Text(
                        "Enter Your Personal Information",
                        style: TextStyle(
                            color: Color.fromARGB(255, 58, 58, 58),
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Username",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "ກະລຸນາໃສ່ຊື່ຜູັໃຊ້")
                                .call,
                        decoration: InputDecoration(
                          hintText: "Enter Your username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 219, 218, 218),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onSaved: (String? username) {
                          profileregister.username = username!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ກະລຸນາໃສ່ອີເມລ"),
                          EmailValidator(errorText: "ກະລຸນາໃສ່ອີເມລໃຫ້ຖືກຕ້ອງ")
                        ]).call,
                        decoration: InputDecoration(
                          hintText: "Enter Your email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 219, 218, 218),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onSaved: (String? email) {
                          profileregister.email = email!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator:
                            RequiredValidator(errorText: "ກະລຸນາໃສ່ລະຫັດຜ່ານ")
                                .call,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 219, 218, 218),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onSaved: (password) {
                          profileregister.password = password!;
                        },
                        onChanged: (value) => password = value,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Confirm password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onSaved: (cfpassword) {
                          profileregister.cfpassword = cfpassword!;
                        },
                        obscureText: true,
                        validator: (cfpassword) {
                          if (cfpassword == null || cfpassword.isEmpty) {
                            return "ກະລຸນາໃສ່ລະຫັດຜ່ານ";
                          }
                          if (cfpassword != password) {
                            return "ລະຫັດຜ່ານບໍ່ຕົງກັນ";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter confirm password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 219, 218, 218),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_keyform.currentState!.validate()) {
                              _keyform.currentState!.save();
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: profileregister.email,
                                  password: profileregister.password,
                                )
                                    .then((value) {
                                  _keyform.currentState!.reset();
                                  Fluttertoast.showToast(
                                      msg: "ສ້າງບັນຊີສຳເລັດແລ້ວ",
                                      gravity: ToastGravity.BOTTOM);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Loginpage()));
                                });
                              } on FirebaseAuthException catch (e) {
                                String message = '';
                                if (e.code == 'weak-password') {
                                  message = 'ກະລຸນາໃສ່ລະຫັດ 6 ໂຕຂຶ້ນໄປ.';
                                } else if (e.code == 'email-already-in-use') {
                                  message = 'ອີເມລນີ້ມີໃນລະບົບແລ້ວ';
                                } else {
                                  message = e.message ?? 'error';
                                }

                                Fluttertoast.showToast(
                                    msg: message, gravity: ToastGravity.CENTER);
                              }
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 18, 65, 233))),
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: RefreshProgressIndicator(),
            ),
          );
        });
  }
}
