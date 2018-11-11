import 'package:flutter/material.dart';

import 'package:contrihub/pull_request.dart';

final _navigationItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text('Timeline')),
  BottomNavigationBarItem(icon: Icon(Icons.merge_type), title: Text('Pull requests')),
  BottomNavigationBarItem(icon: Icon(Icons.question_answer), title: Text('Issues')),
];

final _navigationWidgets = [
  Center(child: Text(
    'This should be the Timeline\r\n'
    'Someone fork your repo\r\n'
    'Someone star your repo\r\n'
    'Your followed open a Pull Request\r\n'
    'Your followed close a Issue\r\n'
    'Your PR is merged\r\n'
    'Your issue is closed\r\n'
  )),
  PullRequest(),
  Center(child: Text('This should be the Issues')),
];

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationWidgets.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
