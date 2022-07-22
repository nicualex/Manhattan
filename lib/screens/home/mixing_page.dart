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
      body: Container(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          //padding: const EdgeInsets.all(19.0),
                          padding: const EdgeInsets.fromLTRB(
                              19.0, 3.0, 19.0, 9.0),
                          child: Text(
                            documentSnapshot['description'],
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topLeft,
                            //height: 30,
                            //color: Colors.green,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(19, 6, 19, 1),
                              child: Text("Ingredients"),
                            ),
                          ),
                        ),
                        Expanded(
                          //ingredients row
                          flex: 9,
                          child: Row( //ingredients
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
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
                                        //"  ${keysList[index]}";
                                        //print(str);
                                        return Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.battery_full,
                                                  size: 16,
                                                  color: Colors
                                                      .lightBlueAccent,),
                                                Expanded(
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
              Row(
                //alignment: Alignment.centerLeft,
                //height: cardHeight,
                //width: double.infinity,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                //child:
                //<Widget>[
                //SizedBox(
                // height: cardHeight/2,
                // width: 239,
                  Text('Testing progress indicator'),
                //)
                /*LiquidLinearProgressIndicator(
                        value: 0.25,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        backgroundColor: Colors.purple,
                        borderWidth: 5.0,
                        borderColor: Colors.deepOrange,
                        borderRadius: 12.0,
                      ) */
                ],
              ),
            ]
        ),
      ),
    );
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
