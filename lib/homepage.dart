import 'package:flutter/material.dart';

final _navigationItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Pull requests')),
  BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Issues')),
];

final _navigationWidgets = [
  Text('This should be the Pull Requests'),
  Text('This should be the Issues'),
];

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navigationWidgets.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue[700],
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
