import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final _readPullRequestsGraphql = """
  query (\$username: String!, \$index: Int!) {
    user(login: \$username) {
      pullRequests(
        first: \$index,
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

final client = Client(
  endPoint: 'https://api.github.com/graphql',
  cache: InMemoryCache(),
  apiToken: '',
);

class _CreatedListViewState extends State<CreatedListView> {
  Future<Map<String, dynamic>> _getQuery(int index) {
    return client.query(
      query: _readPullRequestsGraphql,
      variables: {
        'username': 'jxltom',
        'index': index + 1,
      },
    );
  }

  Future<void> _onRefresh() {
    return client.query(
      query: _readPullRequestsGraphql,
      variables: {
        'username': 'jxltom',
        'index': 1,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: FutureBuilder(
        future: _getQuery(30),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          } else {
            final pullRequests = snapshot.data['user']['pullRequests']['nodes'];

            return ListView.builder(
              padding: EdgeInsets.all(16.0),
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
              },
            );
          }
        },
      ),
    );
  }
}

class CreatedListView extends StatefulWidget {
  @override
  _CreatedListViewState createState() => _CreatedListViewState();
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
