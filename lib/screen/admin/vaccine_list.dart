import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/vaccine.dart';
import 'package:susastho/widgets/utilities.dart';

class VaccineList extends StatefulWidget {
  const VaccineList({Key? key}) : super(key: key);

  @override
  State<VaccineList> createState() => _VaccineListState();
}

class _VaccineListState extends State<VaccineList> {
  Future<void> fatchVaccine() async {
    var docs = await db.collection("Data").doc("Vaccine").get();
    var data = Vaccines.fromMap(docs.data()!);
    vaccines.clear();
    for (var vaccine in data.vaccines) {
      vaccines.add(vaccine);
    }
  }

  Future<void> deleteVaccine(int id) async {
    vaccines.removeAt(id);
    await db.collection("Data").doc("Vaccine").update(Vaccines(vaccines: vaccines).toMap());
    scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.done, 'Removed successfully.'));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vaccine List"),
      ),
      body: FutureBuilder(
          future: fatchVaccine(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.done) {
              if (vaccines.isEmpty) {
                return const Center(child: Text("No vaccine added yet!"));
              } else {
                return ListView.builder(
                  itemCount: vaccines.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(vaccines[index].name),
                          subtitle: Text("Limits: ${vaccines[index].min} - ${vaccines[index].max} age."),
                          trailing: IconButton(
                            onPressed: () => deleteVaccine(index),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/vaccineAdd').then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }
}
