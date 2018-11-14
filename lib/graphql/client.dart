import 'package:graphql_flutter/graphql_flutter.dart';

final graphqlClient = Client(
  endPoint: 'https://api.github.com/graphql',
  cache: InMemoryCache(),
  apiToken: '',
);
