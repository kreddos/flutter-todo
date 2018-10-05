import 'package:flutter/material.dart';


class Info extends StatefulWidget {
  @override
  InfoState createState() =>  new InfoState();
}

class InfoState extends State<Info> {
  String _text = 'asd';

  _onPressIcon() {
    setState(() {
      _text = 'onPressed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _onPressIcon),
          ],
        ),
        body: Center(
          child: Text(_text),
        )
    );
  }
}