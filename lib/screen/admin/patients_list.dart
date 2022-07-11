import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/screen/admin/patients_details.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

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
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const Icon(Icons.personal_injury_outlined, size: 50),
                          title: Text(users[index].name),
                          subtitle: Text(users[index].phone),
                          trailing: IconButton(
                            onPressed: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => PatientDetails(user: users[index]))),
                            icon: const Icon(Icons.chevron_right, size: 30),
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
    );
  }
}
