import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:manhattan/constants.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String path) async {
    return await FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }
}

class MixingPage extends StatelessWidget {
  DocumentSnapshot documentSnapshot;
  String imageCocktail = '';
  MixingPage(this.documentSnapshot, {super.key}) ;


  @override
  Widget build(BuildContext context) {
    return Scaffold( //Card(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
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
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: Column(
        children: [
          const SizedBox( //top spacing
            //width: MediaQuery.of(context).size.width-60,
            height: 100,
          ),
          Container(
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
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      // for cocktail picture
                        height: cardHeight,
                        width: 239,
                        child: FutureBuilder(
                            future:
                            downloadImage(context, documentSnapshot['picture']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return FittedBox(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.hardEdge,
                                  fit: BoxFit.cover,
                                  child: snapshot.data,
                                );
                              }
                              return const FittedBox();
                            })),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container( //name
                            padding: const EdgeInsets.all(3.0),
                            alignment: Alignment.topCenter,
                            child: Padding(padding: const EdgeInsets.all(3.0),
                              child: Text(
                                documentSnapshot['name'],
                                textAlign: TextAlign.center,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                19.0, 3.0, 19.0, 9.0),
                            child: Text(
                              documentSnapshot['description'],
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ),
                          ),
                          //Expanded(
                          Flexible(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.topLeft,
                              //height: 30,
                              //color: Colors.green,
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(19, 6, 19, 6),
                                child: Text("Ingredients"),
                              ),
                            ),
                          ),
                          Flexible(
                            //ingredients row
                            flex: 9,
                            child: Row( //ingredients
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.fromLTRB(
                                        19, 1, 19, 3),
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 1,
                                          mainAxisExtent: 26,
                                        ),
                                        itemCount: documentSnapshot['ingredients']
                                            .length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> m =
                                          documentSnapshot['ingredients'];
                                          var keysList = m.keys.toList();
                                          String str =
                                              "${keysList[index]} :  ${m[keysList[index]]
                                              .toString()} ml";
                                          return Container(
                                            alignment: Alignment.centerLeft,

                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.battery_full,
                                                    size: 16,
                                                    color: Colors
                                                        .indigoAccent,),
                                                  Flexible(
                                                    child: Text(str,
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.fade,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ]
          ),
    ),

        const SizedBox( height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox (
                    //width: MediaQuery.of(context).size.width-200,
                    height: 130,
                  child: Card (
                    //padding: EdgeInsets.fromLTRB(50,10,50,10),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      )
                    ),
                    color: Colors.transparent,
                    borderOnForeground: true,
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        ElevatedButton(
                            onPressed: () { print('pressed'); },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder (
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.indigoAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                            textStyle: const TextStyle(fontFamily: 'Montserrat',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)
                          ),
                            child: const Text("Prime"),
                        ),
                        const SizedBox(width: 30),
                        
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: 300,
                          child: LiquidLinearProgressIndicator(
                          value: 0.5,
                          valueColor: const AlwaysStoppedAnimation(Colors.purpleAccent),
                          backgroundColor: Colors.deepPurple.withOpacity(0.1),
                          //shapePath: _buildGlassPath() ,
                          borderWidth: 3.0,
                          borderColor: Colors.white,
                          direction: Axis.horizontal,
                          borderRadius: 12,
                            center: const Text("Priming"),
                      ),
                        ),
                        const SizedBox(width: 30),
                    ],
                    ),
                ),
                ),
              ],
            ),
                      ]
          ),
        );
  }

  Path _buildGlassPath () {
    return Path()
      ..moveTo(55, 15)
      //..cubicTo(55, 12, 50, 0, 30, 0)
      //..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..lineTo(0,15)
      ..cubicTo(0,55,20,77,55,95)
      ..cubicTo(90, 77, 110, 55, 110, 15)
      ..lineTo(55,15)
      //..cubicTo(110,37.5, 110, 0, 80, 0)
      //..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }


  Future<Widget> downloadImage(BuildContext context, String path) async {
    Widget cocktailImage;
    cocktailImage = Image.asset('');
    await FirebaseStorageService.loadImage(context, path).then((value) {
      cocktailImage = CachedNetworkImage(
        imageUrl: value.toString(),
        placeholder: (context, url) => const Center(
          widthFactor: 3,
          heightFactor: 3,
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Center(
          widthFactor: 3,
          heightFactor: 3,
          child: Icon(Icons.error_outline_sharp),
        ),
        fit: BoxFit.fitHeight,
      );
    });
    //print('Image URL -----> $imageUrl');
    return cocktailImage;
  }
}

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  static Future<dynamic> loadImage(BuildContext context, String path) async {
    String imageUrl =
        await FirebaseStorage.instance.ref().child(path).getDownloadURL();
    //print ('Load URL ---------- $imageUrl');
    return imageUrl.toString();
  }
}
