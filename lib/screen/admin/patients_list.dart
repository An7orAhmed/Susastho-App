import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/screen/admin/patients_details.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  var search = TextEditingController();

  Future<void> fatchUser() async {
    var docs = await db.collection('User').get();
    var data = docs.docs;
    users.clear();
    for (var element in data) {
      var user = AppUser.fromMap(element.data());
      if (user.type == "USER") users.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Patient List"),
      ),
      body: FutureBuilder(
          future: fatchUser(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.done) {
              if (users.isEmpty) {
                return const Center(child: Text("No patient registered yet!"));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: TextField(
                          controller: search,
                          keyboardType: TextInputType.phone,
                          onEditingComplete: () => setState(() {}),
                          decoration: InputDecoration(
                            hintText: "search by phone or NID",
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                search.text = "";
                              }),
                              icon: const Icon(Icons.cancel),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: ((context, index) {
                            if (search.text.isNotEmpty) {
                              if (search.text == users[index].phone || search.text == users[index].nid) {
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    leading: const Icon(Icons.personal_injury_outlined, size: 50),
                                    title: Text(users[index].name),
                                    subtitle: Text(users[index].phone),
                                    trailing: IconButton(
                                      onPressed: () => Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => PatientDetails(user: users[index]))),
                                      icon: const Icon(Icons.chevron_right, size: 30),
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(child: Text("Not found!"));
                              }
                            } else {
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: const Icon(Icons.personal_injury_outlined, size: 50),
                                  title: Text(users[index].name),
                                  subtitle: Text(users[index].phone),
                                  trailing: IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => PatientDetails(user: users[index]))),
                                    icon: const Icon(Icons.chevron_right, size: 30),
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
