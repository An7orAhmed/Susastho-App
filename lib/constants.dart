import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var auth = FirebaseAuth.instance;
var db = FirebaseFirestore.instance;

bool isLoggedIn = false;
bool isAdmin = false;
