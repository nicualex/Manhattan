import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:manhattan/constants.dart';

class CocktailCard extends StatelessWidget {
  DocumentSnapshot documentSnapshot;
  String imageCocktail='';
  //Url imageCocktail = Uri.parse('graphics/generic_cocktail.png') as Url;

  CocktailCard(this.documentSnapshot, {super.key}) {
    //imageCocktail = documentSnapshot['picture'] ?? 'graphics/generic_cocktail.png';
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
            height: cardHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black , Theme.of(context).cardColor],
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    Expanded(
                        //alignment: Alignment.centerLeft,
                        flex:6,
                          child: FutureBuilder (
                            future: downloadURL(documentSnapshot['picture']),
                            builder: (BuildContext context, AsyncSnapshot <String> snapshot) {
                              if (snapshot.hasData) {
                                print('Image URL -----> $snapshot');
                                return ClipRect(
                                  child:FittedBox (
                                    alignment: Alignment.center,
                                    child:
                                    Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    //width: 300,
                                    //child: CachedNetworkImage(
                                    //  imageUrl: snapshot.data!,
                                    //  placeholder: (context, url) => const CircularProgressIndicator(),
                                   //   errorWidget: (context, url, error) => const Icon(Icons.error_outline_sharp),
                                    //  fit: BoxFit.fill,
                                    ),
                                );
                              }
                              return const ClipRect();
                            }
                          )
                              //child: FadeInImage.memoryNetwork(
                            //),
                    ),
                    Expanded( // middle column , name, descripiotns and all
                      flex:7,
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

Future <String> downloadURL(String path) async {

  String imageUrl = await FirebaseStorage.instance.ref().child('generic_cockails.jpg').getDownloadURL();
  //String imageUrl = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
   print('Image URL -----> $imageUrl');
   return imageUrl;
}

}
