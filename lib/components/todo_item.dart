import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  Item({this.title, this.isChecked});
  final String title;
  final bool isChecked;
}

typedef void OnChangeItem(DocumentSnapshot docuemnt, dynamic updates);
typedef void OnDeleteItem(DocumentSnapshot document);
typedef void OnSelectItem(DocumentSnapshot document);


class TodoItem extends StatelessWidget {
  TodoItem({this.item, this.onChangeItem, this.index, this.onDeleteItem, this.onSelectItem,  this.selectedDocument});

  final DocumentSnapshot item;
  final DocumentSnapshot selectedDocument;
  final OnChangeItem onChangeItem;
  final OnSelectItem onSelectItem;
  final OnDeleteItem onDeleteItem;
  final int index;

  void updateItem(bool newVal) {
    onChangeItem(item, { 'isChecked': newVal });
  }

  void onDelete() {
    onDeleteItem(item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: InkWell(onTap: () => onSelectItem(item), child: Text(item['title'])),
        leading: Checkbox(value: item['isChecked'], onChanged: updateItem),
        trailing: IconButton(icon: Icon(Icons.close), color: Theme.of(context).primaryColor, onPressed: onDelete),
        selected: selectedDocument != null ? item.documentID == selectedDocument.documentID : false,
      ),
    );
  }
}