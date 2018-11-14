import 'package:flutter/material.dart';

import 'package:contrihub/pages/timeline/timeline_page.dart';
import 'package:contrihub/pages/pullrequest/pullrequest_page.dart';
import 'package:contrihub/pages/issue/issue_page.dart';

final _navigationWidgets = [
  TimelinePage(),
  PullrequestPage(),
  IssuePage(),
];

final _navigationItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text('Timeline')),
  BottomNavigationBarItem(icon: Icon(Icons.merge_type), title: Text('Pull requests')),
  BottomNavigationBarItem(icon: Icon(Icons.question_answer), title: Text('Issues')),
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
