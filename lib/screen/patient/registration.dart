import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/model/vaccine.dart';
import 'package:susastho/model/vaccine_taken.dart';
import 'package:susastho/widgets/utilities.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  List<DropdownMenuItem<String>> vaccineItem = [];
  String selectedItem = "";
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  Future<void> fatchVaccine() async {
    var docs = await db.collection("Data").doc("Vaccine").get();
    var data = Vaccines.fromMap(docs.data()!);
    vaccineItem.clear();
    for (var vaccine in data.vaccines) {
      String name = "${vaccine.name} - Age limit (${vaccine.min}-${vaccine.max})";
      var item = DropdownMenuItem<String>(value: name, child: Text(name));
      vaccineItem.add(item);
      if (selectedItem == "") selectedItem = vaccineItem.first.value!;
    }
  }

  Future<void> register(context) async {
    if (selectedItem == "") {
      scafKey.currentState!.showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Please select vaccine!'));
      return;
    }
    int minAge, maxAge;
    int i = selectedItem.indexOf('(');
    int j = selectedItem.indexOf(')');
    String ages = selectedItem.substring(i + 1, j);
    minAge = int.parse(ages.split('-')[0]);
    maxAge = int.parse(ages.split('-')[1]);

    var docs = await db.collection('User').doc(auth.currentUser?.email).get();
    var user = AppUser.fromMap(docs.data()!);
    if (user.age < minAge || user.age > maxAge) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Your age ${user.age} isn\'t in range!'));
      return;
    }

    String name = selectedItem.split(' - Age')[0];
    for (var taken in user.vaccineTaken) {
      if (taken.name == name) {
        scafKey.currentState!.showSnackBar(
            snackBar(Colors.amber, Colors.black, Icons.warning, 'You already enrolled for this vaccine!'));
        return;
      }
    }

    var newTaken = VaccineTaken(name: name, takenDate: selectedDate.toString().split(' ')[0], status: "ENROLL");
    user.vaccineTaken.add(newTaken);
    await db.collection('User').doc(auth.currentUser?.email).update(user.toMap());
    scafKey.currentState!
        .showSnackBar(snackBar(Colors.green, Colors.white, Icons.done, 'Enrolled successfully. Thanks you.'));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: FutureBuilder(
          future: fatchVaccine(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    DropdownButtonFormField(
                        hint: const Text("Select vaccine type"),
                        items: vaccineItem,
                        value: selectedItem,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? setected) {
                          setState(() {
                            selectedItem = setected!;
                          });
                        }),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text("Perferable Date"),
                        subtitle: Text(selectedDate.toString().split(' ')[0]),
                        trailing: OutlinedButton(
                          child: const Text("Change"),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
                              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
                            ).then((value) {
                              setState(() {
                                selectedDate = value ?? selectedDate;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        onPressed: () => register(context),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          child: Text("Register"),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
