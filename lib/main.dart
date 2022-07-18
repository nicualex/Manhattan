import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:manhattan/screens/connect/connect.dart';
import 'package:manhattan/screens/home/home.dart';
import 'package:manhattan/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:manhattan/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseDatabase.instance.setPersistenceEnabled(true);
  // Pass all uncaught errors from the framework to Crashlytics.
//  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future <FirebaseApp> _fbApp =   Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseDatabase.instance.setPersistenceEnabled(true);
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        backgroundColor: Colors.black,
        shadowColor: Colors.white12,
        fontFamily: 'Georgia',
        cardColor: Colors.purple[900],
        textTheme: const TextTheme(
            bodyText1: TextStyle(fontFamily: 'Montserrat',fontSize:12.0 , color: Colors.white),
            bodyText2: TextStyle(fontFamily: 'Montserrat',fontSize:16.0 , color: Colors.white),
            headline1: TextStyle(fontFamily: 'DancingScript',fontSize: 30.0,color: Colors.white),
       ),
      ),
      home: FutureBuilder(
          future: _fbApp,
          builder: (context ,snapshot ) {
            //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
            //FirebaseDatabase.instance.setPersistenceEnabled(true);

            if (snapshot.hasError) {
              print('You have an error ! ${snapshot.error.toString()}');
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              return Home();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      )
    );
  }
}
