import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/model/profile_register.dart.dart';
import 'package:login/screen/forgetpasswd.dart';
import 'package:login/screen/homescreen.dart';
import 'package:login/screen/signup.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formkey = GlobalKey<FormState>();
  Future<FirebaseApp> firebase = Firebase.initializeApp();

  Profileregister profileregister = Profileregister("", '', '', '');

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
            return Form(
              key: _formkey,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 5,
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              alignment: Alignment.topCenter,
                              height: 150,
                              width: 100,
                              // decoration: const BoxDecoration(color: Colors.grey),
                              child: Image.asset(
                                "assets/images/login.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const Text("Login to continue using the app"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            onSaved: (String? email) {
                              profileregister.email = email!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "ກະລຸນາໃສ່ອີເມລ"),
                              EmailValidator(errorText: "ຮູບແບບອີເມລບໍ່ຖືກຕ້ອງ")
                            ]).call,
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 203, 203, 203),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.greenAccent)),
                              // enabledBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(60),
                              //   borderSide: BorderSide(color: Colors.blue),
                              // ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            onSaved: (String? password) {
                              profileregister.password = password!;
                            },
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: RequiredValidator(
                                    errorText: "ກະລຸນາໃສ່ລະຫັດຜ່ານ")
                                .call,
                            decoration: InputDecoration(
                                hintText: "Enter your password",
                                fillColor:
                                    const Color.fromARGB(255, 203, 203, 203),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ignore: sized_box_for_whitespace
                          Container(
                            width: double.infinity,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Forget Password ?",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Forgetpassword()));
                                        }),
                                ],
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();

                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profileregister.email,
                                            password: profileregister.password)
                                        .then((value) {
                                      _formkey.currentState!.reset();
                                      Fluttertoast.showToast(
                                          msg: "ເຂົ້າສູ່ລະບົບສຳເລັດ",
                                          gravity: ToastGravity.TOP);

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Homescreen(),
                                        ),
                                      );
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.message);
                                  } catch (e) {
                                    print(e); // แสดงข้อผิดพลาดทั่วไปถ้ามี
                                  }
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 0, 4, 255))),
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                              child: Text(
                                  "----------- Or Login with ----------- ")),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                // color: Colors.red,
                                height: 40,
                                width: 40,
                                child: Image.asset("assets/icons/facebook.png"),
                              ),
                              SizedBox(
                                // color: Colors.red,
                                height: 40,
                                width: 40,
                                child: Image.asset("assets/icons/google.png"),
                              ),
                              SizedBox(
                                // color: Colors.red,
                                height: 40,
                                width: 40,
                                child: Image.asset("assets/icons/apple.png"),
                              ),
                            ],
                          ),

                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text.rich(
                                  TextSpan(children: [
                                    const TextSpan(
                                        text: "Don't have an aaccount? ",
                                        style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: "Register",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const Register())));
                                          }),
                                  ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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
