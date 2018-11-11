import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final _readPullRequestsGraphql = """
  query (\$username: String!) {
    user(login: \$username) {
      pullRequests(
        first: 50,
        states: [CLOSED, MERGED, OPEN],
        orderBy: {
          field: UPDATED_AT,
          direction: DESC
        }
      ) {
        nodes {
          state,
          title,
          repository {
            nameWithOwner
          },
        }
      }
    }
  }
"""
    .replaceAll('\n', ' ');

Query _getPullRequestsQuery(String type) {
  return Query(
    _readPullRequestsGraphql,
    variables: {
      'username': type,
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
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        );
      }

      List pullRequests = data['user']['pullRequests']['nodes'];

      return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: pullRequests.length,
          itemBuilder: (context, index) {
            final pullRequest = pullRequests[index];

            return ListTile(
              leading: Icon(Icons.merge_type,
                  color: _getStateColor(pullRequest['state'])),
              title: Text(pullRequest['title']),
              subtitle: Text(pullRequest['repository']['nameWithOwner']),
              trailing: Icon(Icons.comment),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
            );
          });
    },
  );
}

Color _getStateColor(String state) {
  var color = Colors.yellow;

  if (state == 'OPEN') {
    color = Colors.green;
  } else if (state == 'CLOSED') {
    color = Colors.red;
  } else if (state == 'MERGED') {
    color = Colors.purple;
  }

  return color;
}

class CreatedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _getPullRequestsQuery('jxltom');
  }
}

class AssignedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _getPullRequestsQuery('ry');
  }
}

class MentionedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _getPullRequestsQuery('kennethreitz');
  }
}
