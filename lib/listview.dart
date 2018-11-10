import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) {
          return new Divider();
        }

        return ListTile(
          leading: Icon(Icons.merge_type),
          title: Text('The seat for the $index'),
          subtitle: Text('The seat for the $index'),
          trailing: Icon(Icons.comment),
        );
      },
    );
  }
}
