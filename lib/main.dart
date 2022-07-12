import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:susastho/screen/admin/admin_home.dart';
import 'package:susastho/screen/admin/news_admin.dart';
import 'package:susastho/screen/admin/patients_list.dart';
import 'package:susastho/screen/admin/pubish_news.dart';
import 'package:susastho/screen/admin/vaccine_add.dart';
import 'package:susastho/screen/admin/vaccine_list.dart';
import 'package:susastho/screen/login.dart';
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
  runApp(const MyApp());
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
    if (auth.currentUser != null) isLoggedIn = true;
  }

  Future<void> checkAdmin() async {
    var doc = await db.collection("User").doc(auth.currentUser?.email).get();
    var user = AppUser.fromMap(doc.data()!);
    if (user.type == "ADMIN") {
      isAdmin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkAdmin(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Susastho - সুস্বাস্থ্য',
              scaffoldMessengerKey: scafKey,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,
              theme: ThemeData.light(),
              darkTheme: ThemeData.light(),
              initialRoute: isLoggedIn ? '/' : '/login',
              routes: {
                '/': (context) => isAdmin ? const AdminHome() : const PatientHome(),
                '/login': (context) => Login(),
                '/signup': (context) => Signup(),
                '/patientHome': (context) => const PatientHome(),
                '/registration': (context) => const Registration(),
                '/status': (context) => const Status(),
                '/news': (context) => const News(),
                '/newsAdmin': (context) => const NewsAdmin(),
                '/adminHome': (context) => const AdminHome(),
                '/patientList': (context) => const PatientList(),
                '/vaccineAdd': (context) => const VaccineAdd(),
                '/vaccineList': (context) => const VaccineList(),
                '/publishNews': (context) => PublishNews(),
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
