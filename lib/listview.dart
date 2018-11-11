import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:contrihub/fake_data.dart';

final _readPullRequestsGraphql = """
  query (\$username: String!) {
    user(login: \$username) {
      name,
      bio,
      pullRequests(
        first: 50,
        states: [CLOSED, MERGED, OPEN],
        orderBy: {
          field: CREATED_AT,
          direction: DESC
        }
      ) {
        nodes {
          state,
          title,
          repository {
            name
          },
        }
      }
    }
  }
"""
    .replaceAll('\n', ' ');

final _queryPullRequests = Query(
  _readPullRequestsGraphql,
  variables: {
    'username': 'jxltom',
  },
  pollInterval: 10,
  builder: ({
    bool loading,
    var data,
    Exception error,
  }) {
    if (error != null) {
      return Center(
        child: Text(error.toString()),
      );
    }

    if (loading) {
      return Center(
        child: Text('Loading'),
      );
    }

    List pullRequests = data['user']['pullRequests']['nodes'];

    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: pullRequests.length,
        itemBuilder: (context, index) {
          final pullRequest = pullRequests[index];

          return ListTile(
            leading: Icon(Icons.merge_type),
            title: Text(pullRequest['title']),
            subtitle: Text(pullRequest['title']),
            trailing: Icon(Icons.comment),
          );
        });
  },
);

class CustomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _queryPullRequests;
  }
}
