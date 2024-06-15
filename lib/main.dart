import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyABHODVXncxRyFGBTm0m5atk-3YXINmEvM",
  authDomain: "mineprofiles-69778.firebaseapp.com",
  projectId: "mineprofiles-69778",
  storageBucket: "mineprofiles-69778.appspot.com",
  messagingSenderId: "397601645499",
  appId: "1:397601645499:web:c708a52215553690949a9e",
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const App());
}
