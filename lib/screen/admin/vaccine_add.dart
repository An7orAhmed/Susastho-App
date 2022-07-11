import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/vaccine.dart';
import 'package:susastho/widgets/utilities.dart';

class VaccineAdd extends StatefulWidget {
  VaccineAdd({Key? key}) : super(key: key);

  @override
  State<VaccineAdd> createState() => _VaccineAddState();
}

class _VaccineAddState extends State<VaccineAdd> {
  var vaccineName = TextEditingController();
  int minAge = 18, maxAge = 35;

  Future<void> _addVaccine(context) async {
    if (vaccineName.text == "") {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'Enter vaccine name first!'));
      return;
    }
    if (minAge < 1 || maxAge < minAge) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'Wrong age input!'));
      return;
    }
    var vaccine = Vaccine(name: vaccineName.text, min: minAge, max: maxAge);
    vaccines.add(vaccine);
    var doc = await db.collection("Data").doc("Vaccine").get();
    if (doc.data() != null) {
      await db.collection("Data").doc("Vaccine").update(Vaccines(vaccines: vaccines).toMap());
    } else {
      await db.collection("Data").doc("Vaccine").set(Vaccines(vaccines: vaccines).toMap());
    }
    scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.done, 'Added successfully.'));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add New Vaccine"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: vaccineName,
              decoration: const InputDecoration(
                  hintText: "Enter Vaccine Name", labelText: "Vaccine Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: ListTile(
                  title: const Text("Minimum Age"),
                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            minAge--;
                          });
                        },
                        icon: const Icon(Icons.do_not_disturb_on)),
                    Text("$minAge"),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            minAge++;
                          });
                        },
                        icon: const Icon(Icons.add_circle)),
                  ]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: ListTile(
                  title: const Text("Maximum Age"),
                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            maxAge--;
                          });
                        },
                        icon: const Icon(Icons.do_not_disturb_on)),
                    Text("$maxAge"),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            maxAge++;
                          });
                        },
                        icon: const Icon(Icons.add_circle)),
                  ]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () => _addVaccine(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text("Add"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
