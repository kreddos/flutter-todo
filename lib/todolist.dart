import 'package:flutter/material.dart';
import 'components/todo_items.dart';
import 'components/todo_item.dart';
import 'components/text_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TodoList extends StatefulWidget {
  @override
  TodoListState createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  final TextEditingController control = TextEditingController();
  final FocusNode textInputFocusNode = FocusNode();
  DocumentSnapshot selectedDocument;

  @override
  void dispose() {
    textInputFocusNode.dispose();
    super.dispose();
  }

  void addItem(String newValue) {
    Firestore.instance.collection('items').add({
      'title': newValue,
      'isChecked': false
    });
  }

  void saveItem(String newValue) {
    if (selectedDocument == null) {
      addItem(newValue);
    } else {
      onChangeItem(selectedDocument, {'title': newValue});
      setState(() {
        selectedDocument = null;
      });
    }
    control.clear();
  }

  void onChangeItem(DocumentSnapshot doc, update) {
    doc.reference.updateData(update);
  }

  void onDeleteItem(DocumentSnapshot doc) {
    doc.reference.delete();
  }

  void onSelectItem(DocumentSnapshot doc) {
    setState(() {
      selectedDocument = doc;
    });
    control.text = doc['title'];
    FocusScope.of(context).requestFocus(textInputFocusNode);
  }

  void cancelSelectItem() {
    setState(() {
      selectedDocument = null;
    });
    control.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список дел'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(child: TodoItems(
            stream: Firestore.instance.collection('items').snapshots(),
            buildItem: (DocumentSnapshot item, int index) => TodoItem(
                item: item,
                onChangeItem: onChangeItem,
                onSelectItem: onSelectItem,
                onDeleteItem: onDeleteItem,
                index: index,
                selectedDocument: selectedDocument
            ),
          )),
          Divider(height: 1.0, color: Colors.grey,),
          TextEditor(
            control: control,
            focusNode: textInputFocusNode,
            selectedDocument: selectedDocument,
            onSave: saveItem,
            cancel: cancelSelectItem
          )
        ],
      ),
    );
  }
}
