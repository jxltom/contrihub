import 'package:flutter/material.dart';

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('This should be the Timeline\r\n'
            'Someone fork your repo\r\n'
            'Someone star your repo\r\n'
            'Your followed open a Pull Request\r\n'
            'Your followed close a Issue\r\n'
            'Your PR is merged\r\n'
            'Your issue is closed\r\n'));
  }
}
