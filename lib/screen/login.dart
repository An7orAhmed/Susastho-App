import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/widgets/utilities.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  var email = TextEditingController();
  var pass = TextEditingController();

  Future<void> _login(context) async {
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

    try {
      scafKey.currentState!.showSnackBar(snackBar(Colors.black, Colors.white, Icons.pending, 'Trying to login...'));
      var credential = await auth.signInWithEmailAndPassword(email: email.text, password: pass.text);
      db.collection("User").doc(credential.user?.email).get().then((doc) {
        var user = AppUser.fromMap(doc.data()!);
        user.type == "ADMIN" ? isAdmin = true : isAdmin = false;
        Navigator.of(context).pushNamedAndRemoveUntil(isAdmin ? '/adminHome' : '/patientHome', (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, e.code));
    } catch (e) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'Something wrong!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', scale: 1.5),
              const SizedBox(height: 10),
              const Text('Susastho - সুস্বাস্থ্য', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
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
              OutlinedButton(
                onPressed: () => _login(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Text('Login', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/signup'),
                  child: const Text('Not registered? Signup here'))
            ],
          ),
        ),
      ),
    );
  }
}
