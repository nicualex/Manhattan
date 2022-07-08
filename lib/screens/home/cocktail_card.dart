
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:manhattan/constants.dart';


class FireStorageService extends ChangeNotifier {
  FireStorageService ();
  static Future <dynamic> loadImage(BuildContext context, String path) async {
    return await  FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }
}

class CocktailCard extends StatelessWidget {
  DocumentSnapshot documentSnapshot;
  String imageCocktail = '';

  //Url imageCocktail = Uri.parse('graphics/generic_cocktail.png') as Url;

  CocktailCard(this.documentSnapshot, {super.key}) {
    //imageCocktail = documentSnapshot['picture'] ?? 'graphics/generic_cocktail.png';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        //onTap: () => do something,
          child: Container(
            //margin: const EdgeInsets.all(10) ,
            alignment: Alignment.centerLeft,
            height: cardHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Theme
                    .of(context)
                    .cardColor
                ],
              ),
              borderRadius: const BorderRadius.all(
                  Radius.circular(10.0)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container (
                      //flex: 6,
                    height: cardHeight,
                    width: 250,
                      child: FutureBuilder(
                          future: downloadImage(context,documentSnapshot['picture']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return FittedBox(
                                alignment: Alignment.center,
                                clipBehavior: Clip.hardEdge,
                                fit:BoxFit.cover,
                                child:snapshot.data,
                              );
                            }
                            return const FittedBox();
                          }
                      )
                  ),
                  Expanded( // middle column , name, descriptions and all
                    flex: 7,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(padding: const EdgeInsets.all(8.0),
                            child: Text(documentSnapshot['name'],
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1,),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(padding: const EdgeInsets.all(16.0),
                            child: Text(
                              documentSnapshot['description'],
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:ListView.builder(
                                itemCount: documentSnapshot['ingredients'].length,
                                itemBuilder: (context,index) {
                                  Map m = documentSnapshot['ingredients'][index];
                                  if (m.isNotEmpty) {
                                  print(m.keys.toString()); }
                                  return ListTile(
                                    title: Text(m.toString()),
                                  );
                                  }
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ]
            ),
          )

        // children:[Text(documentSnapshot['name']),]
      ),
    );
  }

  Future <Widget> downloadImage(BuildContext context, String path) async {
    //Image cocktailImage;
    Widget cocktailImage;
    cocktailImage = Image.asset('');

    await FirebaseStorageService.loadImage(context, path).then((value) {
      //print ('Load Image ---------- $value');
      //cocktailImage = Image.network(
      //  value.toString(),
      //  fit: BoxFit.fitHeight,
      //);
      cocktailImage = CachedNetworkImage(
          imageUrl: value.toString(),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error_outline_sharp),
          fit: BoxFit.fitHeight,
      );
    });
    //print('Image URL -----> $imageUrl');
    return cocktailImage;
  }
}

//FadeInImage.memoryNetwork(
//placeholder: kTransparentImage,
//image: snapshot.data!,
//Image.network(
// snapshot.data!,
// fit: BoxFit.fitHeight,
//),
//width: 300,
//child: CachedNetworkImage(
//  imageUrl: snapshot.data!,//
//  placeholder: (context, url) => const CircularProgressIndicator(),
//   errorWidget: (context, url, error) => const Icon(Icons.error_outline_sharp),
//  fit: BoxFit.fill,


class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService ();
  static Future <dynamic> loadImage(BuildContext context, String path) async {
    String imageUrl = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
    //print ('Load URL ---------- $imageUrl');
    return imageUrl.toString();
  }
}

