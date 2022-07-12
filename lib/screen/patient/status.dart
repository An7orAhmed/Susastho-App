import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/model/vaccine_taken.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  List<VaccineTaken> takenList = [];
  int enroll = 0, pending = 0, done = 0;

  Future<void> fatchTakenList() async {
    var docs = await db.collection("User").doc(auth.currentUser?.email).get();
    var data = AppUser.fromMap(docs.data()!);
    takenList.clear();
    for (var vaccine in data.vaccineTaken) {
      if (vaccine.status == "ENROLL") {
        enroll++;
      } else if (vaccine.status == "PENDING") {
        enroll++;
        pending++;
      } else if (vaccine.status == "DONE") {
        enroll++;
        done++;
      }
      takenList.add(vaccine);
    }
  }

  @override
  void initState() {
    super.initState();
    fatchTakenList().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vaccine Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 90,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$enroll", style: const TextStyle(fontSize: 46, color: Colors.white)),
                          const Text("ENROLL", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$pending", style: const TextStyle(fontSize: 46, color: Colors.white)),
                          const Text("PENDING", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$done", style: const TextStyle(fontSize: 46, color: Colors.white)),
                          const Text("DONE", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            if (takenList.isEmpty)
              const Expanded(
                  child: Center(
                child: Text("You didn't enrolled for any vaccine."),
              )),
            if (takenList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: takenList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(takenList[index].name),
                          subtitle: Text(takenList[index].takenDate),
                          trailing: Icon(
                              takenList[index].status == "ENROLL"
                                  ? Icons.how_to_reg
                                  : takenList[index].status == "PENDING"
                                      ? Icons.pending
                                      : Icons.task_alt,
                              size: 50,
                              color: takenList[index].status == "ENROLL"
                                  ? Colors.amber
                                  : takenList[index].status == "PENDING"
                                      ? Colors.blue
                                      : Colors.green),
                        ),
                      );
                    }),
              )
          ],
        ),
      ),
    );
  }
}
