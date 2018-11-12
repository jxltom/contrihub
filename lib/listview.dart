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
  Future<Map<String, dynamic>> query;
  List<dynamic> _items = List<dynamic>();

  @override
  void initState() {
    super.initState();

    query = client.query(
      query: _readPullRequestsGraphql,
      variables: {
        'username': 'jxltom',
        'index': _items.length + 1,
      },
    );
  }

  Future<Map<String, dynamic>> _getQuery(int index) {
    return client.query(
      query: _readPullRequestsGraphql,
      variables: {
        'username': 'jxltom',
        'index': index,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getQuery(_items.length + 1),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          } else {
            final d = snapshot.data['user']['pullRequests']['nodes'];
            //final _pullRequest = d[d.length - 1];
            _items.add(d[d.length - 1]);

            return ListView.builder(
              itemBuilder: (context, index) {
                final pullRequest = _items[index];

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
        });
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
