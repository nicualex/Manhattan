
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
            width: double.infinity,
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
                  Container ( // for cocktail picture
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
                  Expanded( // middle section , wide column , name, descriptions and all
                    flex: 1,
                    //height: cardHeight,
                    //margin: EdgeInsets.all(20.0),
                    //width: 350.0,
                    //height: double.infinity,
                    //color: Colors.blue,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //flex: 2,
                          margin: EdgeInsets.all(5.0),
                          width: double.infinity,
                          height: 50,
                          child: Padding(padding: const EdgeInsets.all(8.0),
                            child: Text(documentSnapshot['name'],
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1,),
                          ),
                        ),
                        Expanded(
                          //flex: 5,
                          child: Padding(padding: const EdgeInsets.all(16.0),
                            child: Text(
                              documentSnapshot['description'],
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ),
                          ),
                        ),
                          Row ( //ingredients and mix button
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                //mainAxisSize: MainAxisSize.min,
                                //child: const Text ("Ingredients"),
                                height: 120.0,
                                width: 250,
                                alignment: Alignment.center,
                                //width: double.infinity,
                                //width: double.infinity,
                                child:  GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount (
                                      crossAxisCount: 2,
                                      //childAspectRatio: 60,
                                      //crossAxisSpacing: 1,
                                      //mainAxisSpacing: 0,
                                      //mainAxisExtent: 120,
                                    ),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: documentSnapshot['ingredients'].length,
                                    itemBuilder: (context,index) {
                                      Map <String,dynamic> m = documentSnapshot['ingredients'];
                                      var keysList = m.keys.toList();
                                      String str = "${keysList[index]}  ${m[keysList[index]].toString()}";
                                      print(str);
                                      return Container(
                                        //height: 10,
                                        width: 120,
                                        alignment: Alignment.center,
                                        child: Text(str),
                                      );
                                    }
                                  ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 50.0,
                                child: Text("for button"),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ]
            ),
          )
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

