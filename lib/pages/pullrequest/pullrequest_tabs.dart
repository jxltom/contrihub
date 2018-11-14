import 'dart:async';

import 'package:flutter/material.dart';

import 'package:contrihub/widgets/loading_indicator.dart';
import 'package:contrihub/graphql/client.dart';
import 'package:contrihub/graphql/queries.dart';
import 'package:contrihub/pages/pullrequest/pullrequest_element.dart';

final _itemsOnce = 3;

class _CreatedPullrequestTabState extends State<CreatedPullrequestTab> {
  List<dynamic> _pullRequestItems = List<dynamic>();

  Future<void> _updatePullRequestItems() async {
    final _data = await graphqlClient.query(
      query: readPullRequestsQuery,
      variables: {
        'username': 'jxltom',
        'index': _itemsOnce,
      },
    );

    setState(() {
      _pullRequestItems = _data['user']['pullRequests']['nodes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _updatePullRequestItems,
      child: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _pullRequestItems.length * 2 + 1,
        itemBuilder: (context, index) {
          if (index + 1 == _pullRequestItems.length * 2 + 1) {
            return LoadingIndicator();
          }

          if (index % 2 == 1) {
            return Divider();
          }

          final pullRequest = _pullRequestItems[index ~/ 2];
          return PullrequestElement(pullrequest: pullRequest,);
        },
      ),
    );
  }
}

class CreatedPullrequestTab extends StatefulWidget {
  @override
  _CreatedPullrequestTabState createState() => _CreatedPullrequestTabState();
}

class AssignedPullrequestTab extends CreatedPullrequestTab {}

class MentionedPullrequestTab extends CreatedPullrequestTab {}
