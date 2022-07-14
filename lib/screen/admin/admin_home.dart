import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/widgets/utilities.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  _logout(context) {
    scafKey.currentState!.showSnackBar(snackBar(Colors.black, Colors.white, Icons.pending, 'Signing out...'));
    auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Susastho - সুস্বাস্থ্য"),
        actions: [
          IconButton(
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationName: "Susastho",
                    applicationVersion: "1.0.0",
                    applicationLegalese: "Developed by Engineering Project Solution(EPS)",
                    applicationIcon: Image.asset("assets/icon.png", scale: 2.3));
              },
              icon: const Icon(Icons.info)),
          IconButton(onPressed: () => _logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person, size: 50, color: Colors.blue[400]),
                title: const Text("Welcome,"),
                subtitle: Text(auth.currentUser?.email ?? "None"),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    splashColor: Colors.blue[100],
                    onTap: () => Navigator.of(context).pushNamed('/patientList'),
                    child: Row(
                      children: const [
                        SizedBox(width: 15),
                        Icon(Icons.personal_injury, size: 80, color: Colors.blue),
                        SizedBox(width: 45),
                        Text(
                          "Patient List",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    splashColor: Colors.blue[100],
                    onTap: () => Navigator.of(context).pushNamed('/vaccineList'),
                    child: Row(
                      children: const [
                        SizedBox(width: 15),
                        Icon(Icons.vaccines, size: 80, color: Colors.blueGrey),
                        SizedBox(width: 45),
                        Text(
                          "Vaccine List",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    splashColor: Colors.blue[100],
                    onTap: () => Navigator.of(context).pushNamed('/publishNews'),
                    child: Row(
                      children: const [
                        SizedBox(width: 15),
                        Icon(Icons.newspaper, size: 80, color: Colors.deepPurple),
                        SizedBox(width: 45),
                        Text(
                          "Publish News",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    splashColor: Colors.blue[100],
                    onTap: () => Navigator.of(context).pushNamed('/newsAdmin'),
                    child: Row(
                      children: const [
                        SizedBox(width: 15),
                        Icon(Icons.newspaper, size: 80, color: Colors.redAccent),
                        SizedBox(width: 45),
                        Text(
                          "News List",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
