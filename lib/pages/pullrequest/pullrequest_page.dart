import 'package:flutter/material.dart';

import 'package:contrihub/pages/pullrequest/pullrequest_tabs.dart';

final _pullrequestTypes = [
  Text('Created'),
  Text('Assigned'),
  Text('Mentioned')
];

final _pullrequestTabs = [
  CreatedPullrequestTab(),
  AssignedPullrequestTab(),
  MentionedPullrequestTab()
];

class PullrequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pullrequestTypes.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: _pullrequestTypes.map((Text pullRequestType) {
              return Tab(
                text: pullRequestType.data,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: _pullrequestTabs,
        ),
      ),
    );
  }
}
