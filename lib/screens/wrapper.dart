import 'package:flutter/material.dart';
import 'package:manhattan/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // either home or connect page
    return Home();
  }
}

