import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class Connect extends StatelessWidget {
const Connect({Key? key, this.state}) : super(key: key);

final BluetoothState? state;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Bluetooth'),
      leading: Icon(
        Icons.bluetooth_disabled,
        //size: .0,
        color: Colors.white54,
      ),
    ),
    backgroundColor: Colors.lightBlue,
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.bluetooth_disabled,
            size: 200.0,
            color: Colors.white54,
          ),
          Text(
            'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
          ),
        ],
      ),
    ),
  );
}
}




