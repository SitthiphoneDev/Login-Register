import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Newpassword extends StatefulWidget {
  const Newpassword({super.key});

  @override
  State<Newpassword> createState() => _NewpasswordState();
}

class _NewpasswordState extends State<Newpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Create new password",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
                "Your new password must be unique from those previously used."),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  fillColor: const Color.fromARGB(255, 229, 229, 229),
                  filled: true),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Confirm password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              validator:
                  RequiredValidator(errorText: "ກະລຸນາຢືນຢັນລະຫັດຜ່ານ").call,
              decoration: InputDecoration(
                hintText: "Enter confirm password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: const Color.fromARGB(255, 219, 218, 218),
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
