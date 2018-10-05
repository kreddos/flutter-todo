import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


typedef void SaveItemCb(String text);
typedef void CancelCb();


class TextEditor extends StatelessWidget {
  TextEditor({
    this.selectedDocument,
    this.focusNode,
    this.control,
    this.onSave,
    this.cancel
  });

  @required
  final DocumentSnapshot selectedDocument;
  @required
  final FocusNode focusNode;
  @required
  final TextEditingController control;
  @required
  final SaveItemCb onSave;
  @required
  final CancelCb cancel;

  Widget _buildInput(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: control,
            decoration: new InputDecoration.collapsed(hintText: "Add something"),
            focusNode: focusNode,
          ),
        ),
        Container(
          child: new IconButton(
              color: Theme.of(context).primaryColor,
              icon: new Icon(Icons.send),
              onPressed: () {
                if (control.text == '') {
                  return;
                }
                onSave(control.text);
              }),
        ),
      ],
    );
  }

  Widget _buildSelectedItem(BuildContext context) {
    return ListTile(
      title: Text(selectedDocument['title']),
      leading: IconButton(icon: Icon(Icons.close), color: Theme.of(context).primaryColor, onPressed: cancel),
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[_buildInput(context)];
    if (selectedDocument != null) {
      children.insert(0, _buildSelectedItem(context));
    }
    return Container(child: Column(
      children: children,
    ));
  }

}