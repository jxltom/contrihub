import 'dart:async';

import 'package:flutter/material.dart';

import 'package:contrihub/widgets/loading_indicator.dart';
import 'package:contrihub/graphql/client.dart';
import 'package:contrihub/graphql/queries.dart';
import 'package:contrihub/pages/pullrequest/pullrequest_element.dart';

final _itemsOnce = 3;

class _CreatedPullrequestTabState extends State<CreatedPullrequestTab> {
  int _currentItemsIndex = 0;
  List<dynamic> _pullRequestItems = List<dynamic>();
  Future<void> _updatePullRequestItemsFuture;
  ScrollController _scrollController = ScrollController();

  Future<List<dynamic>> _query(int index) async {
    final _data = await graphqlClient.query(
      query: readPullRequestsQuery,
      variables: {
        'username': 'jxltom',
        'index': _currentItemsIndex,
      },
    );

    return _data['user']['pullRequests']['nodes'];
  }

  Future<void> _resetPullRequestItems() async {
    _currentItemsIndex = _itemsOnce;
  
    final _data = await _query(_currentItemsIndex);

    setState(() {
      _pullRequestItems = _data;
    });
  }

  Future<void> _updatePullRequestItems() async {
    print('called');
    _currentItemsIndex += _itemsOnce;
  
    final _data = await _query(_currentItemsIndex);

    setState(() {
      _pullRequestItems = _data;
    });
  }

  // FIXME: Disable loading multiple times
  bool _onNotification(Notification notification) {
    if (notification is OverscrollNotification) {
      _updatePullRequestItems();
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    // This is required otherwise FutureBuilder will trigger build infinitely
    // since there is a setState in this Future
    _updatePullRequestItemsFuture = _updatePullRequestItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // FIXME: This is rebuild when the widget is rebuild
      future: _updatePullRequestItemsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // snapshot.hasData doesn't work since the Future returns void
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        return NotificationListener(
          onNotification: _onNotification,
          child: RefreshIndicator(
            onRefresh: _resetPullRequestItems,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.0),
              controller: _scrollController,
              itemCount: _pullRequestItems.length * 2 + 1,
              itemBuilder: (context, index) {
                // FIXME: Remove loading indicator if items are less than a page
                if (index + 1 == _pullRequestItems.length * 2 + 1) {
                  return LoadingIndicator();
                }

                if (index % 2 == 1) {
                  return Divider();
                }

                final pullRequest = _pullRequestItems[index ~/ 2];
                return PullrequestElement(
                  pullrequest: pullRequest,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class CreatedPullrequestTab extends StatefulWidget {
  @override
  _CreatedPullrequestTabState createState() => _CreatedPullrequestTabState();
}

class AssignedPullrequestTab extends CreatedPullrequestTab {}

class MentionedPullrequestTab extends CreatedPullrequestTab {}
