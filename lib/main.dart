import 'package:flutter/material.dart';

import 'package:contrihub/homepage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

void main() => runApp(App());
