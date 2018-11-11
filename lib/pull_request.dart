import 'package:flutter/material.dart';

import 'package:contrihub/listview.dart';

final _pullRequestTypes = [
  Text('Created'),
  Text('Assigned'),
  Text('Mentioned')
];

final _pullRequestItems = [
  CreatedListView(),
  AssignedListView(),
  MentionedListView()
];

class PullRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pullRequestTypes.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: _pullRequestTypes.map((Text pullRequestType) {
              return Tab(
                text: pullRequestType.data,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: _pullRequestItems,
        ),
      ),
    );
  }
}
