import 'package:flutter/material.dart';
import 'package:manhattan/screens/connect/connect.dart';
import 'package:manhattan/screens/home/home.dart';
import 'package:manhattan/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return Home();
            }
            //return Connect(state: state);
            return Home();

          }),
    );
  }
}

