import 'package:flutter/material.dart';

import 'package:contrihub/fake_data.dart';

class CustomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) {
          return new Divider();
        }

        if (index > fakeData.length - 1) {
          index = index % fakeData.length;
        }

        var data = fakeData.elementAt(index);

        return ListTile(
          leading: Icon(Icons.merge_type),
          title: Text(data.project + ' ' + data.title),
          subtitle: Text(data.description),
          trailing: Icon(Icons.comment),
        );
      },
    );
  }
}
