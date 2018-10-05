import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

typedef Widget BuildItem(DocumentSnapshot item, int index);

class TodoItems extends StatelessWidget {
  TodoItems({ this.stream, this.buildItem });

  final Stream<QuerySnapshot> stream;
  final BuildItem buildItem;


  @override
  Widget build(BuildContext context) {
//      return StreamBuilder(
//        stream: Firestore.instance.collection('items').snapshots(),
//        builder: (context, snapshot) {
//          DocumentSnapshot doc = snapshot.data.documents[0];
//          return Text(doc['title']);
//
//        }
//      );
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView.builder(
            itemCount: snapshot.data.documents.length * 2,
            itemBuilder: (ctx, int i) {
              if (i.isOdd) {
                return Divider();
              }
              int index = i ~/ 2;
              return buildItem(snapshot.data.documents[index], index);
            }
        );
      }
    );
  }
}