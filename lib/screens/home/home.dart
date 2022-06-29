import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:manhattan/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manhattan/screens/home/cocktail_card.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference _cocktails =
  FirebaseFirestore.instance.collection('cocktails');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName, style: Theme
            .of(context)
            .textTheme
            .headline1,),
        elevation: 15,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        shadowColor: Theme
            .of(context)
            .shadowColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              //color: Colors.blue,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
          stream: _cocktails.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return SafeArea(
                  child: ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        print('Database image: ! ${documentSnapshot['picture']}');
                        return CocktailCard(documentSnapshot);
                      }
                  )
              );
            } else {
              return Center (
                child: CircularProgressIndicator(
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              );
            }
          }
      ),
    );
  }
}

