import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final List dummyList = List.generate(1000, (index) {
    return {
      "id": index,
      "title": "This is the title $index",
      "subtitle": "This is the subtitle $index"
    };
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
        body: SafeArea(
            child: ListView.builder(
              itemCount: dummyList.length,
              itemBuilder: (context, index) =>
                  Card(
                    elevation: 6,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(dummyList[index]["id"].toString()),
                        backgroundColor: Colors.purple,
                      ),
                      title: Text(dummyList[index]["title"]),
                      subtitle: Text(dummyList[index]["subtitle"]),
                      trailing: Icon(Icons.add_a_photo),
                    ),
                  ),
            )));
  }
}