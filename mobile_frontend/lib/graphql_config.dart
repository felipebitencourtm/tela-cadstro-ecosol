import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class GraphQLConfig {
  // 10.0.2.2 emulador
  static String endpoint = "http://10.0.2.2:3000/graphql";
  static final HttpLink httpLink = HttpLink(endpoint);

  static ValueNotifier<GraphQLClient> initializeClient() {
    return ValueNotifier(GraphQLClient(link: httpLink, cache: GraphQLCache()));
  }
}
