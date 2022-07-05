import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var auth = FirebaseAuth.instance;
var db = FirebaseFirestore.instance;

bool isLoggedIn = false;
bool isAdmin = false;

var scafKey = GlobalKey<ScaffoldMessengerState>();
