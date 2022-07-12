import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';

class PatientDetails extends StatefulWidget {
  final AppUser user;
  const PatientDetails({Key? key, required this.user}) : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Patients Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: Text("Vaccine Status:", style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 10),
          if (widget.user.vaccineTaken.isEmpty) const Center(child: Text("No vaccine record!")),
          if (widget.user.vaccineTaken.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: widget.user.vaccineTaken.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    var vaccineInfo = widget.user.vaccineTaken[index];
                    List<bool> state = List<bool>.filled(2, false);
                    state[1] = vaccineInfo.status == "DONE" ? true : false;
                    state[0] = state[1]
                        ? true
                        : vaccineInfo.status == "PENDING"
                            ? true
                            : false;
                    return ListTile(
                      leading: Icon(
                          vaccineInfo.status == "ENROLL"
                              ? Icons.how_to_reg
                              : vaccineInfo.status == "PENDING"
                                  ? Icons.pending
                                  : Icons.task_alt,
                          size: 50,
                          color: vaccineInfo.status == "ENROLL"
                              ? Colors.amber
                              : vaccineInfo.status == "PENDING"
                                  ? Colors.blue
                                  : Colors.green),
                      title: Text(vaccineInfo.name),
                      subtitle: Text(vaccineInfo.takenDate.split('.')[0]),
                      trailing: ToggleButtons(
                        isSelected: state,
                        onPressed: (i) {
                          setState(() {
                            String mail = widget.user.email;
                            if (state[i] == false) {
                              i == 0
                                  ? widget.user.vaccineTaken[index].status = "PENDING"
                                  : widget.user.vaccineTaken[index].status = "DONE";
                              db.collection("User").doc(mail).update(widget.user.toMap());
                              state[i] = true;
                            }
                          });
                        },
                        children: const [Icon(Icons.pending_actions), Icon(Icons.task)],
                      ),
                    );
                  })),
            ),
          const Divider(thickness: 2),
          ListTile(
            title: Text(widget.user.name),
            subtitle: const Text("Name"),
          ),
          ListTile(
            title: Text(widget.user.age.toString()),
            subtitle: const Text("Age"),
          ),
          ListTile(
            title: Text(widget.user.blood),
            subtitle: const Text("Blood Group"),
          ),
          ListTile(
            title: Text(widget.user.address),
            subtitle: const Text("Address"),
          ),
          ListTile(
            title: Text(widget.user.phone),
            subtitle: const Text("Phone"),
          ),
          ListTile(
            title: Text(widget.user.nid),
            subtitle: const Text("NID"),
          ),
        ],
      ),
    );
  }
}
