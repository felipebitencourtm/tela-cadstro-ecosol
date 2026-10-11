import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/register/register_page.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final client = GraphQLConfig.initializeClient();

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Ecosol Digital',
        theme: AppTheme.light,
        home: const RegisterPage(),
      ),
    );
  }
}
