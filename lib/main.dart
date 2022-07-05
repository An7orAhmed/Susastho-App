import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:susastho/screen/admin/admin_home.dart';
import 'package:susastho/screen/admin/patients_details.dart';
import 'package:susastho/screen/admin/patients_list.dart';
import 'package:susastho/screen/admin/pubish_news.dart';
import 'package:susastho/screen/admin/vaccine_add.dart';
import 'package:susastho/screen/admin/vaccine_list.dart';
import 'package:susastho/screen/login.dart';
import 'package:susastho/screen/patient/article.dart';
import 'package:susastho/screen/patient/news.dart';
import 'package:susastho/screen/patient/patient_home.dart';
import 'package:susastho/screen/patient/registration.dart';
import 'package:susastho/screen/patient/status.dart';
import 'package:susastho/screen/signup.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    if (auth.currentUser != null) isLoggedIn = true;
    var doc = db.collection("User").doc(auth.currentUser?.uid).get();
    doc.then((data) {
      var user = User.fromMap(data.data()!);
      if (user.type == "ADMIN") isAdmin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Susastho - সুস্বাস্থ্য',
      scaffoldMessengerKey: scafKey,
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/' : '/login',
      routes: {
        '/': (context) => isAdmin ? AdminHome() : PatientHome(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/patientHome': (context) => PatientHome(),
        '/registration': (context) => Registration(),
        '/status': (context) => Status(),
        '/news': (context) => News(),
        '/article': (context) => Article(),
        '/adminHome': (context) => AdminHome(),
        '/patientList': (context) => PatientList(),
        '/patientDetails': (context) => PatientDetails(),
        '/vaccineAdd': (context) => VaccineAdd(),
        '/vaccineList': (context) => VaccineList(),
        '/publishNews': (context) => PublishNews(),
      },
    );
  }
}
