import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:firebase_image/firebase_image.dart';

class CocktailCard extends StatelessWidget {
  DocumentSnapshot documentSnapshot;
  String imageCocktail='';
  //Url imageCocktail = Uri.parse('graphics/generic_cocktail.png') as Url;

  CocktailCard(this.documentSnapshot, {super.key}) {
    imageCocktail = documentSnapshot['picture'] ?? 'graphics/generic_cocktail.png';
    //imageCocktail = 'graphics/generic_cocktail.png';

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(10),
      child: InkWell (
        //onTap: () => do something,
          child: Container(
            //margin: const EdgeInsets.all(10) ,
            alignment: Alignment.centerLeft,
            height: 300,
              //alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black , Theme.of(context).cardColor],
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    Expanded(
                       flex: 3,
                        child: ClipRect(
                              //child: FadeInImage.memoryNetwork(
                                child: FadeInImage.assetNetwork(
                                placeholder: imageCocktail,
                                image: FirebaseImage(imageCocktail),
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.centerLeft,
                              )
                            ),
                    ),
                    Expanded( // middle column , name, descripiotns and all
                      flex:6,
                      child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex:2,
                                child: Padding(padding: const EdgeInsets.all(8.0),
                                  child: Text( documentSnapshot['name'],
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline1,),
                                ),
                            ),
                            Expanded (
                              flex: 7,
                                child: Padding(padding:const EdgeInsets.all(16.0),
                                  child: Text(
                                    documentSnapshot['description'],
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                  ),
                                ),
                            ),
                            Expanded(
                              flex:1,
                              child: Text(documentSnapshot['name']),
                            ),

                          ],
                        ),
                    ),
                    Expanded(
                      flex:1,
                      child: Container(),
                    )
                  ]
              ),
          )

                         // children:[Text(documentSnapshot['name']),]
      ),
              );
  }
}
