import 'package:flutter/material.dart';

final _pullRequestTypes = [
  Text('Created'),
  Text('Assigned'),
  Text('Mentioned')
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
          children: _pullRequestTypes.map((Text pullRequestType) {
            return Center(
              child: pullRequestType,
            );
          }).toList(),
        ),
      ),
    );
  }
}
