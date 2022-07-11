import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:susastho/model/news_model.dart';
import 'package:susastho/model/user.dart';
import 'package:susastho/model/vaccine.dart';

var auth = FirebaseAuth.instance;
var db = FirebaseFirestore.instance;

bool isLoggedIn = false;
bool isAdmin = false;

var scafKey = GlobalKey<ScaffoldMessengerState>();

List<AppUser> users = [];
List<Vaccine> vaccines = [];
List<NewsModel> publishedNews = [];
