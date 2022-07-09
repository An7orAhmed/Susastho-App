import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/widgets/utilities.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  var email = TextEditingController();
  var pass = TextEditingController();
  var repass = TextEditingController();
  var name = TextEditingController();
  var address = TextEditingController();
  var phone = TextEditingController();
  var nid = TextEditingController();
  var age = TextEditingController();
  var blood = TextEditingController();

  Future<void> _signup(context) async {
    if (email.text.isEmpty) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Please enter your email first!'));
      return;
    }
    if (pass.text.isEmpty) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Please enter your password!'));
      return;
    }
    if (pass.text != repass.text) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Password not matched!'));
      return;
    }
    if (name.text.isEmpty ||
        address.text.isEmpty ||
        phone.text.isEmpty ||
        nid.text.isEmpty ||
        age.text.isEmpty ||
        blood.text.isEmpty) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'There is a empty field!'));
      return;
    }

    try {
      scafKey.currentState!.showSnackBar(snackBar(Colors.black, Colors.white, Icons.error, 'Signing up...'));
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      )
          .then((credential) {
        var uid = credential.user!.uid;
        var user = AppUser(
            name: name.text,
            address: address.text,
            phone: phone.text,
            nid: nid.text,
            age: int.parse(age.text),
            blood: blood.text,
            type: 'USER');
        db.collection('User').doc(uid).set(user.toMap()).then((value) {
          auth.signInWithEmailAndPassword(email: email.text, password: pass.text);
          Navigator.of(context).pushNamedAndRemoveUntil('/patientHome', (route) => false);
        });
      });
    } on FirebaseAuthException catch (e) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, e.code));
    } catch (e) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'Something wrong!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', scale: 2.5),
                      const SizedBox(width: 15),
                      const Text('Susastho - সুস্বাস্থ্য', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: repass,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Re-enter password',
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      prefixIcon: const Icon(Icons.home),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nid,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'NID Number',
                      prefixIcon: const Icon(Icons.badge),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      prefixIcon: const Icon(Icons.schedule),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: blood,
                    decoration: InputDecoration(
                      hintText: 'Blood Group',
                      prefixIcon: const Icon(Icons.water_drop),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () => _signup(context),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text('Signup', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Already registered? login here'),
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
