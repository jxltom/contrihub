import 'package:flutter/material.dart';

class PullrequestElement extends StatelessWidget {
  PullrequestElement({
    Key key,
    this.pullrequest,
  }) : super(key: key);

  final Map<String, dynamic> pullrequest;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Icon(Icons.merge_type, color: _getStateColor(pullrequest['state'])),
      title: Text(pullrequest['title']),
      subtitle: Text(pullrequest['repository']['nameWithOwner']),
      trailing: Icon(Icons.comment),
      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
    );
  }
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
