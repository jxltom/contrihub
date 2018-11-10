import 'package:flutter/material.dart';

import 'package:contrihub/homepage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

void main() => runApp(App());
