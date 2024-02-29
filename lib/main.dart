
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:design_crud/screens/lockscreen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
  ? await Firebase.initializeApp(
  options: const FirebaseOptions (
  apiKey: 'AIzaSyA1J4s510LoMWBBqlQtB2kMZ4ov8KVuM6Y',
  appId: '1:993326661817:android:5687b4018d3b5226ee1b68',
  messagingSenderId: '993326661817',
  projectId: 'cruddesign-94672')
  ):await Firebase.initializeApp();
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
