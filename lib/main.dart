import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:contrihub/homepage.dart';

ValueNotifier<Client> _graphqlClient = ValueNotifier(
    Client(
      endPoint: 'https://api.github.com/graphql',
      cache: InMemoryCache(),
      apiToken: '',
    ),
  );


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphqlProvider(
      client: _graphqlClient,
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(primaryColor: Colors.white),
      ),
    );
  }
}

void main() => runApp(App());
